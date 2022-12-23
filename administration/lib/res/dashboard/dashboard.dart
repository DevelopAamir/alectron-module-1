import 'dart:async';
import 'dart:math';

import 'package:administration/res/auth/completeProfile.dart';
import 'package:administration/res/auth/login.dart';
import 'package:administration/res/constant.dart';
import 'package:administration/res/dashboard/contact.dart';
import 'package:administration/res/dashboard/components/discWithEdit.dart';
import 'package:administration/res/dashboard/components/profileCard.dart';
import 'package:administration/res/dashboard/payment.dart';
import 'package:administration/res/dashboard/utils/dashboardUtils.dart';
import 'package:administration/res/dashboard/utils/notificationConfig.dart';
import 'package:administration/res/globalUtils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import 'components/alertBoxes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GeoPoint? pvGeo;
  var data;
  final firestore = FirebaseFirestore.instance;

  final auth = FirebaseAuth.instance;
  StreamSubscription<LocationData>? streamLoc;
  getUser() async {
    DocumentSnapshot<Map<String, dynamic>> a =
        await DashboardUtils().getUserData();
    data = a.data();
    if (data['available']) {
      activateLocation(a.reference);
    }
    if (data == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Complete(
                    user: auth.currentUser,
                  )));
    }
    setState(() {});
  }

  activateLocation(reference) async {
    final loc = await DashboardUtils().locationStream();

    streamLoc = loc.listen(
      (event) {
        if (pvGeo !=
            GeoPoint(
              event.latitude!.toDouble(),
              event.longitude!.toDouble(),
            )) {
          pvGeo = GeoPoint(
            event.latitude!.toDouble(),
            event.longitude!.toDouble(),
          );
          reference.update(
              {'current_location': pvGeo, 'last_pos_changed': DateTime.now()});
        } else {
          print('not changed');
        }
      },
    );
  }

  @override
  void initState() {
    NotificationConfig().config();
    getUser();
    NotificationConfig().notificationHandler(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: Image.asset(
          'assets/logo.png',
          width: 80,
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: primaryColor,
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset('assets/logo.png'),
            ),
            ListTile(
              leading: const Icon(
                Icons.contact_page_outlined,
                color: Colors.orange,
              ),
              title: const Text(
                'Contacter Nous',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  Contact(name: data['name'],number: data['whatsapp'],email: data['email'],)));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.orange,
              ),
              title: const Text(
                'Deconnexion',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              onTap: () async {
                final auth = FirebaseAuth.instance;
                await auth.signOut();
                await GoogleSignIn().signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
            )
          ],
        ),
      ),
      body: spinner(
        visibility: data == null,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Salut',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Text(data != null ? data['name'] : '',
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.5)),
                const SizedBox(
                  height: 15,
                ),
                ProfileCard(
                  data: data,
                ),
                StreamBuilder(
                  stream: firestore
                      .collection('Habitations')
                      .doc(userId(auth.currentUser!.uid))
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    return snapshot.data == null
                        ? Container()
                        : DiscWithEdit(
                            key: Key("${Random().nextDouble()}"),
                            title: 'Habitation',
                            value: snapshot.data!['habitaion'].toString(),
                            trailing: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                                StreamBuilder(
                                  stream: firestore
                                      .collection('Users')
                                      .doc(userId(auth.currentUser!.uid))
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<
                                              DocumentSnapshot<
                                                  Map<String, dynamic>>>
                                          sna) {
                                    return !sna.hasData
                                        ? Container()
                                        : Switch(
                                            value: sna.hasData &&
                                                sna.data!['available'],
                                            onChanged: (a) async {
                                              if (!sna.data!['available']) {
                                                sna.data!.reference
                                                    .update({'available': a});
                                                activateLocation(
                                                    sna.data!.reference);
                                                setState(() {});
                                              } else {
                                                sna.data!.reference
                                                    .update({'available': a});

                                                setState(() {
                                                  if (streamLoc != null) {
                                                    streamLoc!.cancel();
                                                  }
                                                  pvGeo = null;
                                                });
                                              }
                                            },
                                          );
                                  },
                                )
                              ],
                            ),
                          );
                  },
                ),
                StreamBuilder(
                    stream: firestore
                        .collection('Messages')
                        .orderBy('date', descending: false)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      int index = 0;
                      return Column(
                          children: snapshot.hasData
                              ? snapshot.data!.docs
                                      .where((element) =>
                                          element['ID'] ==
                                              userId(auth.currentUser!.uid) &&
                                          element['selection_type'] ==
                                              'active').isEmpty
                                  ? [
                                      AlertsBox(
                                        height: 200,
                                        title: 'Alerte Déplacement',
                                        child: Text(''),
                                        trailing: Container(),
                                      )
                                    ]
                                  : snapshot.data!.docs
                                      .where((element) =>
                                          element['ID'] ==
                                              userId(auth.currentUser!.uid) &&
                                          element['selection_type'] ==
                                              'active')
                                      .map((e) {
                                      index++;
                                      return AlertsBox(
                                        height: index == 1 ? 200 : null,
                                        title: 'Alerte Déplacement',
                                        child: Text(e['description']),
                                        trailing: InkWell(
                                            onTap: () {
                                              e.reference.delete();
                                            },
                                            child: Icon(Icons.close)),
                                      );
                                    }).toList()
                              : []);
                    }),
                StreamBuilder(
                    stream: firestore.collection('Messages').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      int index = 0;
                      return Column(
                          children: snapshot.hasData
                              ? snapshot.data!.docs
                                      .where((element) =>
                                          element['ID'] ==
                                              userId(auth.currentUser!.uid) &&
                                          element['selection_type'] == 'Inactive').isEmpty
                                  ? [
                                      AlertsBox(
                                        height: 200,
                                        title: 'Alectron Alertes',
                                        child: Text(''),
                                        trailing: Container(),
                                      )
                                    ]
                                  : snapshot.data!.docs
                                      .where((element) =>
                                          element['ID'] ==
                                              userId(auth.currentUser!.uid) &&
                                          element['selection_type'] == 'Inactive')
                                      .map((e) {
                                      index++;
                                      return AlertsBox(
                                        height: index == 1 ? 200 : null,
                                        title: 'Alectron Alertes',
                                        child: Text(e['description']),
                                        trailing: InkWell(
                                            onTap: () {
                                              e.reference.delete();
                                            },
                                            child: Icon(Icons.close)),
                                      );
                                    }).toList()
                              : []);
                    }),
                DiscWithEdit(
                  title:
                      'Souscription (${DateFormat('yyyy MMMM').format(DateTime.now())})',
                  value: '0 0 0 0 0 FCFA',
                  withButton: true,
                  btnValue: 'Dû',
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Payments()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
