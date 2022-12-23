import 'package:alectron/res/dashboard/utils/administratorUtils.dart';
import 'package:alectron/res/dashboard/utils/dashboardUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/dashboard/components/SearchTextField.dart';
import 'package:alectron/res/dashboard/components/addTextField.dart';
import 'package:alectron/res/dashboard/components/calendarCard.dart';
import 'package:alectron/res/dashboard/components/drawer.dart';
import 'package:alectron/res/dashboard/components/employeeTypeSelector.dart';

class Listedesadministrateurs extends StatefulWidget {
  const Listedesadministrateurs({Key? key}) : super(key: key);

  @override
  State<Listedesadministrateurs> createState() =>
      _ListedesadministrateursState();
}

class _ListedesadministrateursState extends State<Listedesadministrateurs> {
  bool administrator = false;
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), //
        child: Container(
          child: Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
              const SizedBox(
                width: 100,
              ),
            ],
          ),
          height: 250,
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
                selectedPage: 'Listedesadministrateurs',
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Liste des administrateurs',
                        style: headingText.copyWith(color: Colors.white70),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: StreamBuilder(
                          stream:
                              firestore.collection('administrator').snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            return Column(
                              children: [
                                Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: const {
                                    0: FlexColumnWidth(3),
                                    1: FlexColumnWidth(5),
                                    2: FlexColumnWidth(5),
                                    3: FlexColumnWidth(5),
                                  },
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                          color: Colors.black87,
                                          border: Border.all(
                                            color: Colors.white70,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            'Nom complet',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            'Email',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            'Mot de passe',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            'Actions',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                StreamBuilder(
                                    stream: firestore
                                        .collection('administrator')
                                        .orderBy("date_created",descending: false)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      return !snapshot.hasData?  Container():Table(
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          columnWidths: const {
                                            0: FlexColumnWidth(3),
                                            1: FlexColumnWidth(5),
                                            2: FlexColumnWidth(5),
                                            3: FlexColumnWidth(5),
                                          },
                                          children:
                                              snapshot.data!.docs.map((e) {
                                            return TableRow(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white70,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              children:  [
                                                Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Text(
                                                    e['name'],
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Text(
                                                    e['email'],
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Text(
                                                    e['password'],
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                if(e['email'] != 'appalectron@gmail.com')
                                                Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: MaterialButton(
                                                      onPressed: () async{

                                                        AdministrationUtils().deleteAdminstrators(email:e['email'],password: e['password']);
                                                      },
                                                      child: const Text('Supprimer'),
                                                      color: const Color(0xffE8991A),
                                                    )),
                                                if(e['email'] == 'appalectron@gmail.com')
                                                  Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: MaterialButton(
                                                        onPressed: (){},
                                                        child: const Text('Supprimer'),
                                                        color:  Colors.white38,
                                                      )),
                                              ],
                                            );
                                          }).toList());
                                    }),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
