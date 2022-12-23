
import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/constants.dart';
import 'package:alectron/res/dashboard/components/addTextField.dart';
import 'package:alectron/res/dashboard/components/drawer.dart';
import 'package:alectron/res/dashboard/components/employeeTypeSelector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Creeruncompte extends StatefulWidget {
  const Creeruncompte({Key? key}) : super(key: key);

  @override
  State<Creeruncompte> createState() => _CreeruncompteState();
}

class _CreeruncompteState extends State<Creeruncompte> {
  final firestore = FirebaseFirestore.instance;
  bool administrator = false;
  final email = TextEditingController();
  final name = TextEditingController();
  final wa = TextEditingController();
  bool visible = false;

  @override
  void initState() {
    wa.text = '+225';
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
                  selectedPage: 'Gestiondesutilisateurs',
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
                          'Creer un compte',
                          style:
                          headingText.copyWith(color: Colors.white70),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // Row(
                      //   children: const [
                      //      Padding(
                      //       padding: EdgeInsets.all(20.0),
                      //       child: AddTextField(title: 'Code pays',width: 100.0,),
                      //     ),
                      //      Padding(
                      //       padding: EdgeInsets.all(8.0),
                      //       child: AddTextField(title: 'Entrer le numéro de téléphone',width: 266,),
                      //     ),
                      //   ],
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: InkWell(
                      //     onTap: (){},
                      //     child: Container(
                      //       width: 400,
                      //       height: 45,
                      //
                      //       decoration: BoxDecoration(color: const Color(0xffE8991A),
                      //           borderRadius: BorderRadius.circular(5)
                      //       ),
                      //       child: const Center(
                      //         child: Text('Next'),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                       Padding(
                        padding: EdgeInsets.all(20.0),
                        child: AddTextField(title: 'Nom/Prénom',controller: name,),
                      ),
                      //  Padding(
                      //   padding: EdgeInsets.all(20.0),
                      //   child: AddTextField(title: 'Email',controller: email,),
                      // ),
                      // const Padding(
                      //   padding: EdgeInsets.all(20.0),
                      //   child: AddTextField(title: 'ID',withHint: false,),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AddTextField(title: 'Whatsapp',controller: wa,hintText: 'Enter NT',),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: ()async{
                            setState(() {
                              visible =  true;
                            });
                            if(name.text.isNotEmpty && wa.text != '+225') {
                              await firestore.collection('Users').doc(DateFormat('CLmmsddms').format(DateTime.now())).set({
                              'ID': DateFormat('CLmmsddms').format(DateTime.now()),
                              'name': name.text,
                              'whatsapp': wa.text,
                              'available': false,
                              'current_location' : GeoPoint(0,0),
                              'last_pos_changed' : DateTime.now()
                            });
                              toastSuccess('Added Successfully');

                              Navigator.pushNamed(context, '/Gestiondesutilisateurs');
                            }else{
                              toastError('Name and whatsapp number must be entered');
                            }
                            setState(() {
                              visible =  false;
                            });

                          },
                          child: Container(
                            width: 400,
                            height: 45,

                            decoration: BoxDecoration(color: const Color(0xffE8991A),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: const Center(
                              child: Text('Confirmer'),
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
        ),
      ),
    );
  }
}
