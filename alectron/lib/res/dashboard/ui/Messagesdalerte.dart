import 'package:alectron/res/constants.dart';
import 'package:alectron/res/dashboard/components/DescriptionTextField.dart';
import 'package:alectron/res/dashboard/components/title.dart';
import 'package:alectron/res/dashboard/utils/messagesUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/dashboard/components/SearchTextField.dart';
import 'package:alectron/res/dashboard/components/drawer.dart';

class Messagesdalerte extends StatefulWidget {
  const Messagesdalerte({Key? key}) : super(key: key);

  @override
  State<Messagesdalerte> createState() => _MessagesdalerteState();
}

class _MessagesdalerteState extends State<Messagesdalerte> {
  bool userSelected = false;
  var title = 'Alectron Alertes';
  var description = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  bool redDotOnly = false;
  List notificationTobeSent = [];
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments == null
        ? null
        : ModalRoute.of(context)!.settings.arguments as List;
    print(args.toString() + 'fsf');
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
            ],
          ),
          height: 250,
          decoration: const BoxDecoration(
              color: Colors.black87,
              boxShadow: [BoxShadow(color: Colors.grey)]),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomDrawer(
                selectedPage: 'Messagesdalerte',
              ),
              Expanded(
                child: Column(
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
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "Messages d'alerte",
                                    style: headingText.copyWith(
                                        color: Colors.white70),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    'Titre : ',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                TitleTextField(cantChange : true,value: 'Alectron Alertes',onChange: (a){
                                  setState(() {
                                    title = a;
                                  });
                                },),
                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    'Description : ',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),

                                ),
                                 DescriptionTextField(
                                  controller: description,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 130,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child:  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                      decoration: BoxDecoration(
                                        color: dashboardColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Expanded(
                                            child: Center(
                                              child: Text('App only',style:
                                              TextStyle(color: Colors.white70),),
                                            ),
                                          ),
                                          Expanded(child: Switch(value: false, onChanged: (a){},inactiveTrackColor: Colors.grey,)),
                                          const Expanded(
                                            child: Center(
                                              child: Text('Both app and messages',style:
                                              TextStyle(color: Colors.white70),),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child:  Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                        decoration: BoxDecoration(
                                          color: dashboardColor,
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Expanded(
                                              child: Center(
                                                child: Text('Everyone',style:
                                                TextStyle(color: Colors.white70),),
                                              ),
                                            ),
                                            Expanded(child: Switch(value: redDotOnly, onChanged: (a){
                                              setState(() {
                                                redDotOnly = a;
                                              });
                                            },inactiveTrackColor: Colors.grey,)),
                                            const Expanded(
                                              child: Center(
                                                child: Text('Only red dot',style:
                                                TextStyle(color: Colors.white70),),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: MaterialButton(
                                      onPressed: ()async{
                                        setState(() {
                                          visible = true;
                                        });
                                        if(args!= null){
                                          await MessagesUtils().sendMessage(type: MessageType.message,title: title,decsription : description.text,ids: args.where((element) => redDotOnly?  !element.data().containsKey('email') : true)
                                              .map((e) => {'id':e['ID'],'type': e['selection_type']}).toList());
                                        }

                                        setState(() {
                                          description.clear();
                                          visible = false;
                                        });

                                      },
                                      child:  Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: spinner(
                                          visible: visible,
                                          child: const Text(
                                            'Envoyer',
                                            style:
                                                TextStyle(color: Colors.white70),
                                          ),
                                        ),
                                      ),
                                      color: dashboardColor,
                                    ),
                                  ),

                                  ////here to select app or messages and app
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0,),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FlexColumnWidth(5),
                          1: FlexColumnWidth(5),
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
                                  'Utilisateurs',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'Pays',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                      child: StreamBuilder(
                        stream: firestore.collection('Users').snapshots(),
                        builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                          if(snapshot.hasData) {
                            notificationTobeSent = snapshot.data!.docs.where((element) => redDotOnly?  !element.data().containsKey('email') : true).toList();
                          }
                          return Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: const {
                              0: FlexColumnWidth(5),
                              1: FlexColumnWidth(5),
                            },
                            children: args != null
                                ? args.where((element) => redDotOnly?  !element.containsKey('email') : true)
                                    .map(
                                      (e) => TableRow(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white38)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              e['name'],
                                              style: const TextStyle(
                                                  color: Colors.white, fontSize: 15),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Text(
                                              "Cote d’ivoire",
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList()
                                :[]
                            // !snapshot.hasData? []: snapshot.data!.docs.where((element) => redDotOnly?  !element.data().containsKey('email') : true).map((e) => TableRow(
                            //   decoration: BoxDecoration(
                            //       border:
                            //       Border.all(color: Colors.white38)),
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.all(15.0),
                            //       child: Text(
                            //         e['name'],
                            //         style: const TextStyle(
                            //             color: Colors.white, fontSize: 15),
                            //       ),
                            //     ),
                            //     const Padding(
                            //       padding: EdgeInsets.all(15.0),
                            //       child: Text(
                            //         "Cote d’ivoire",
                            //         style: TextStyle(
                            //             color: Colors.white, fontSize: 15),
                            //       ),
                            //     ),
                            //   ],
                            // ),).toList()
                          );
                        }
                      ),
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
