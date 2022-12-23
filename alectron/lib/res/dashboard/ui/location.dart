import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/constants.dart';
import 'package:alectron/res/dashboard/components/Maps.dart';
import 'package:alectron/res/dashboard/components/title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../components/DescriptionTextField.dart';
import '../components/drawer.dart';


class LocationTrace extends StatefulWidget {
  final LatLng position;
  const LocationTrace({Key? key, required this.position}) : super(key: key);

  @override
  State<LocationTrace> createState() => _LocationTraceState();
}

class _LocationTraceState extends State<LocationTrace> {
  final firestore = FirebaseFirestore.instance;
  String search  = '';
  final habitationController = TextEditingController();
  bool visible = false;
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize:  const Size.fromHeight(80.0), //
        child: Container(
          child: Row(
            children: [
              const SizedBox(width: 25,),
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
      body: spinner(
        visible: visible,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomDrawer(
                  selectedPage: 'Ajoutetselectiondesadressessurlamaps',
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(15.0),
                                  //   child: Text(
                                  //     'Ajout et sélection des adresses sur la maps',
                                  //     style:
                                  //     headingText.copyWith(color: Colors.white70),
                                  //   ),
                                  // ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'ID : ',
                                      style:
                                      TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                  TitleTextField(title: 'Entrer l’ID',onChange: (a){
                                    setState(() {
                                      search  = a;
                                    });

                                  },),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: MaterialButton(
                                      onPressed: () {},
                                      child:  const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Center(
                                            child:   Text(
                                              'Rechercher',
                                              style:  TextStyle(color: Colors.white70),
                                            ),
                                          ),
                                        ),
                                      ),
                                      color: dashboardColor,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Entrer l’habitation : ',
                                      style:
                                      TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                  DescriptionTextField(title: 'Entrer l’habitation',controller: habitationController,),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: MaterialButton(
                                      onPressed: ()async {
                                        setState(() {
                                          visible = true;
                                        });
                                        final data = search.isNotEmpty? await firestore.collection('Users').doc(search.trim()).get(): null;
                                        if(data != null){
                                          await firestore.collection('Habitations').doc(data['ID']).set({
                                            'available': true,
                                            'ID':  data['ID'],
                                            'location': GeoPoint(widget.position.latitude.toDouble(),widget.position.longitude.toDouble()) ,
                                            'date': DateFormat('yyyy-mm-dd').format(DateTime.now()),
                                            'habitaion': habitationController.text
                                          }).then((value){
                                            setState(() {
                                              visible = false;
                                            });
                                            Navigator.pushReplacementNamed(context, '/Ajoutetselectiondesadressessurlamaps');
                                          });
                                        }
                                      },
                                      child:  const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Center(
                                            child:   Text(
                                              'Confirmer',
                                              style:  TextStyle(color: Colors.white70),
                                            ),
                                          ),
                                        ),
                                      ),
                                      color: dashboardColor,
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Expanded(
                              child: search.isEmpty ?Container() :SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: StreamBuilder(
                                    stream: firestore.collection('Users').doc(search.trim()).snapshots(),
                                    builder: (context,AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                                      return snapshot.hasData? snapshot.data!.exists ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children:  [
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          Text('Name : ' +snapshot.data!['name'],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white70,),),
                                          const SizedBox(height: 10,),
                                           Text('ID : ${snapshot.data!['ID']}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white70,),),
                                          const SizedBox(height: 5,),
                                           Text('NT: ${snapshot.data!['whatsapp']}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white70),),

                                        ],
                                      ) : Container(child: const Text('Not Found', style: TextStyle(fontSize: 30,color: Colors.white70),),): Container();
                                    }
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
