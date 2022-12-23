import 'package:alectron/res/dashboard/ui/manageutilisateurs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/dashboard/components/SearchTextField.dart';
import 'package:alectron/res/dashboard/components/drawer.dart';

class Gestiondesutilisateurs extends StatefulWidget {
  const Gestiondesutilisateurs({Key? key}) : super(key: key);

  @override
  State<Gestiondesutilisateurs> createState() => _GestiondesutilisateursState();
}

class _GestiondesutilisateursState extends State<Gestiondesutilisateurs> {
  final firestore = FirebaseFirestore.instance;
  var search = '';
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
                selectedPage: 'Gestiondesutilisateurs',
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Gestion des utilisateurs',
                          style: headingText.copyWith(color: Colors.white70),
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.all(15.0),
                        child: SearchTextField(
                          onChanged: (a){
                            setState(() {
                              search = a;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Text(
                              "Cote d'Ivoire",
                              style: headingText.copyWith(
                                  color: Colors.white70, fontSize: 25),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/Creeruncompte');
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 8),
                                  child: Text('Creer un compte'),
                                ),
                                color: const Color(0xffE8991A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: const {
                                0: FlexColumnWidth(8),
                                1: FlexColumnWidth(3),
                                2: FlexColumnWidth(3),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      border: Border.all(
                                        color: Colors.white70,
                                      ),
                                      borderRadius: BorderRadius.circular(4)),
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Text(
                                        'Nom complet',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Text(
                                        'Actions',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Icon(
                                          Icons.circle,
                                          color: Colors.white38,
                                        )),
                                  ],
                                ),

                                ///Heading is Upto here
                              ],
                            ),
                            StreamBuilder(
                              stream: firestore.collection('Users').snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                return !snapshot.hasData
                                    ? Container()
                                    : Table(
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        columnWidths: const {
                                          0: FlexColumnWidth(8),
                                          1: FlexColumnWidth(3),
                                          2: FlexColumnWidth(3),
                                        },
                                        children: snapshot.data!.docs.where((element) => element['name'].toString().toLowerCase().contains(search.toString().toLowerCase()) || element['ID'].toString().toLowerCase().contains(search.toString().toLowerCase())).map(
                                          (e) {
                                            var oo = e.data() as Map;
                                            return TableRow(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white38)),
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    e['name'],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                        15.0,
                                                      ),
                                                      child: MaterialButton(
                                                        onPressed: () {

                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Manageutilisateurs(id: e['ID'],)));

                                                        },
                                                        child:
                                                            const Text('Voir'),
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                 Padding(
                                                    padding:
                                                        EdgeInsets.all(15.0),
                                                    child: Icon(
                                                      Icons.circle,
                                                      color:oo.containsKey('email')? Colors.green : Colors.red
                                                    )),
                                              ],
                                            );
                                          },
                                        ).toList(),
                                      );
                              },
                            )
                          ],
                        ),
                      ),
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
