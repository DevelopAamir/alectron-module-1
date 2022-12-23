import 'dart:async';
import 'dart:math';
import 'dart:html' as html;
import 'package:alectron/res/dashboard/components/Maps.dart';
import 'package:alectron/res/dashboard/components/SelecterMap.dart';
import 'package:alectron/res/dashboard/components/title.dart';
import 'package:alectron/res/providers/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/dashboard/components/SearchTextField.dart';
import 'package:alectron/res/dashboard/components/drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import '../../constants.dart';
import '../components/DescriptionTextField.dart';

class Ajoutets extends StatefulWidget {
  const Ajoutets({Key? key}) : super(key: key);

  @override
  State<Ajoutets> createState() => _AjoutetsState();
}

class _AjoutetsState extends State<Ajoutets> {
  final random = Random();
  final firestore = FirebaseFirestore.instance;
  bool wait = true;
  num zoo = 2;
  List<Map<String, dynamic>> markers = [
    {
      'position': LatLng(6.8746193113132135, -5.035171187500007),
      'user': {'name': '', 'ID': '', 'whatsapp': ''}
    },
  ];

  List selectActiveUser = [];


  Future getData() async {
    final value = await firestore.collection('Habitations').get();

    for (var element in value.docs) {
      GeoPoint geo = element['location'];
      var user = await firestore.collection('Users').doc(element.id).get();
      markers.add({
        'position': LatLng(geo.latitude, geo.longitude),
        'user': user.data(),
        'habitation': element['habitaion']
      });
      setState(() {});
      print(
          element.data().toString() + ' ' + value.docs.last.data().toString());

      if (markers.length == value.docs.length + 1) {
        setState(() {
          wait = false;
          markers.removeAt(0);
        });
      }
    }
  }
  bool selectionMode = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), //
        child: Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/logo.png',
                  width: 200,
                  height: 100,
                ),
              ),
            ],
          ),
          decoration: const BoxDecoration(
              color: Colors.black87,
              boxShadow: [BoxShadow(color: Colors.grey)]),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomDrawer(
                selectedPage: 'Ajoutetselectiondesadressessurlamaps',
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Ajout et sélection des adresses sur la maps',
                          style: headingText.copyWith(
                              color: Colors.white70, fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        height: 500,
                        child: wait
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.indigo,
                              ))
                            : FutureBuilder(
                                future: firestore
                                    .collection('Users')
                                    .where('available')
                                    .get(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  return snapshot.hasData
                                      ? wait
                                          ? Container()
                                          : GoogleMaps(
                                              key: Key(
                                                  "${Random().nextDouble()}"),
                                              streamer: firestore
                                                  .collection('Users')
                                                  .where('available')
                                                  .snapshots(),
                                              onActiveUserSelected: (a) {
                                                selectActiveUser.clear();
                                                selectActiveUser = a.map((e) {
                                                  var data = e.data()
                                                      as Map<String, dynamic>;
                                                  data.addAll({
                                                    'selection_type': 'active'
                                                  });
                                                  return data;
                                                }).toList();
                                              },
                                              onInActiveUserSelected: (a) {

                                                a.forEach((element) {
                                                  var doc = snapshot.data!.docs
                                                          .firstWhere((el) =>
                                                              element['user']
                                                                  ['ID'] ==
                                                              el['ID'])
                                                          .data()
                                                      as Map<String, dynamic>;
                                                  doc.addAll({
                                                    'selection_type': 'Inactive'
                                                  });

                                                  selectActiveUser.add(doc);
                                                });
                                              },
                                              zoom: zoo,
                                              markers: markers,
                                              activeUsers: snapshot.data!.docs
                                                  .where((element) =>
                                                      element['available'])
                                                  .toList(),
                                              onMapClick: (a, zoom) {
                                                setState(() {
                                                  zoo = zoom!;
                                                });
                                              },
                                            )
                                      : Container();
                                }),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: MaterialButton(
                              onPressed: () {
                                Provider.of<StateManagement>(context,
                                        listen: false)
                                    .setUsers(selectActiveUser);
                                print(selectActiveUser);
                                setState(() {
                                  wait = true;
                                });
                                Navigator.pushNamed(context, '/Messagesdalerte',
                                        arguments: selectActiveUser)
                                    .then((value) {
                                  setState(() {
                                    wait = false;
                                  });
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8),
                                child: Text('Messages'),
                              ),
                              color: const Color(0xffE8991A),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/notifications',
                                    arguments: selectActiveUser.where((e) =>e.containsKey('email') && e['selection_type'] != 'active').toList());
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8),
                                child: Text('Notifications'),
                              ),
                              color: const Color(0xffE8991A),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
