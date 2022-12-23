import 'package:alectron/res/dashboard/utils/messagesUtils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/constants.dart';
import 'package:alectron/res/dashboard/components/DescriptionTextField.dart';
import 'package:alectron/res/dashboard/components/SearchTextField.dart';
import 'package:alectron/res/dashboard/components/drawer.dart';
import 'package:alectron/res/dashboard/components/title.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool userSelected = false;
  var selectedDate = '';
  var selectedLocation = 'Monde';
  var search = '';
  List countryWithCity = [
    'Your Country',
    'Your City',
    'All',
  ];
  List<String>? countries = ['Demo', 'demoCountry'];
  List<String>? cities = ['Demo', 'Demo City'];
  bool isDrawerOpened = false;
  bool isCountrySelectorOpen = false;
  bool isCitySelectorOpen = false;
  double x = 0.0;
  double y = 0.0;
  double posX = 0.0;
  double posY = 0.0;
  List candidates = [];
  var title = 'Alectron Alertes';
  var description = TextEditingController();
  bool visible = false;
  setPos() {
    setState(() {
      posX = x;
      posY = y;
    });
  }

  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments == null
        ? null
        : ModalRoute.of(context)!.settings.arguments as List;
    return GestureDetector(
      onTap: () {
        setState(() {
          isDrawerOpened = false;
        });
      },
      child: MouseRegion(
        onHover: (a) {
          setState(() {
            x = a.localPosition.dx;
            y = a.localPosition.dy;
          });
        },
        child: Scaffold(
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
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomDrawer(
                      selectedPage: 'notifications',
                    ),
                    Expanded(
                      child: MouseRegion(
                        onHover: (a) {
                          setState(() {
                            x = a.localPosition.dx;
                            y = a.localPosition.dy;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Notifications",
                                            style: headingText.copyWith(
                                                color: Colors.white70),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Titre : ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ),
                                        TitleTextField(
                                          onChange: (a) {
                                            title = a;
                                          },
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Description : ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // const SizedBox(
                                          //   height: 150,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  isDrawerOpened = true;
                                                });
                                              },
                                              child: Stack(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        isDrawerOpened = true;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Text(
                                                        selectedLocation,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white70),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: AnimatedContainer(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors.white,
                                                      ),
                                                      height: isDrawerOpened
                                                          ? 190
                                                          : 0,
                                                      width: isDrawerOpened
                                                          ? 250
                                                          : 0,
                                                      duration: const Duration(
                                                          milliseconds: 100),
                                                      child: ListView(
                                                        children:
                                                            countryWithCity
                                                                .map((e) {
                                                          return Column(
                                                            children: [
                                                              ListTile(
                                                                title: Text(
                                                                  e,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                onTap: () {
                                                                  isCitySelectorOpen =
                                                                      false;
                                                                  isCountrySelectorOpen =
                                                                      false;
                                                                  if (e ==
                                                                      'All') {
                                                                    setState(
                                                                        () {
                                                                      selectedLocation =
                                                                          e.toString();
                                                                      isDrawerOpened =
                                                                          false;
                                                                    });
                                                                  } else if (e ==
                                                                      'Your Country') {
                                                                    setState(
                                                                        () {
                                                                      setPos();
                                                                      isCountrySelectorOpen =
                                                                          true;
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      setPos();
                                                                      isCitySelectorOpen =
                                                                          true;
                                                                    });
                                                                  }
                                                                },
                                                                // trailing: Icon(Icons.check_box,size: 10,),
                                                              ),
                                                              const Divider()
                                                            ],
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              color: dashboardColor,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: MaterialButton(
                                              onPressed: () {},
                                              child: const Padding(
                                                padding: EdgeInsets.all(15.0),
                                                child: Text(
                                                  'Tout sélectionner',
                                                  style: const TextStyle(
                                                      color: Colors.white70),
                                                ),
                                              ),
                                              color: dashboardColor,
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: dashboardColor,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          'Everyone',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Switch(
                                                      value: false,
                                                      onChanged: (a) {},
                                                      inactiveTrackColor:
                                                          Colors.grey,
                                                    )),
                                                    const Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          'Transparent Dot',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: MaterialButton(
                                              onPressed: () async {
                                                setState(() {
                                                  visible = true;
                                                });
                                                if (candidates.isNotEmpty) {
                                                  print(candidates);
                                                  await MessagesUtils()
                                                      .sendMessage(
                                                          type:
                                                              MessageType
                                                                  .notification,
                                                          title: title,
                                                          decsription:
                                                              description.text,
                                                          ids: candidates);
                                                } else {
                                                  toastError(
                                                      'No Any Users Selected');
                                                }
                                                setState(() {
                                                  visible = false;
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: spinner(
                                                  visible: visible,
                                                  child: const Text(
                                                    'Envoyer',
                                                    style: TextStyle(
                                                        color: Colors.white70),
                                                  ),
                                                ),
                                              ),
                                              color: dashboardColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SearchTextField(
                                onChanged: (a) {
                                  setState(() {
                                    search = a;
                                    candidates.clear();
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, left: 15.0, right: 15.0),
                              child: Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: const {
                                  0: FlexColumnWidth(5),
                                  1: FlexColumnWidth(5),
                                  2: FlexColumnWidth(2)
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
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(
                                          'Pays',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(
                                          'Action',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: StreamBuilder(
                                  stream:
                                      firestore.collection('Users').snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>
                                          snapshot) {
                                    if(args != null) {
                                      args
                                        .where((element) =>
                                    element['name']
                                        .toString()
                                        .toLowerCase()
                                        .contains(search
                                        .toLowerCase()) ||
                                        element['ID']
                                            .toString()
                                            .toLowerCase()
                                            .contains(search
                                            .toLowerCase())).forEach((e) {
                                        candidates.add({'id':e['ID'],'type': e['selection_type'],'slectedAlready' : true});
                                    });
                                    }
                                    return !snapshot.hasData
                                        ? Container()
                                        : Table(
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: const {
                                              0: FlexColumnWidth(5),
                                              1: FlexColumnWidth(5),
                                              2: FlexColumnWidth(2)
                                            },
                                            children:  snapshot.data!.docs
                                                    .where((element) =>
                                                        element
                                                            .data()
                                                            .containsKey(
                                                                'email') &&
                                                        (element['name']
                                                                .toString()
                                                                .toLowerCase()
                                                                .contains(search
                                                                    .toLowerCase()) ||
                                                            element['ID']
                                                                .toString()
                                                                .toLowerCase()
                                                                .contains(
                                                                    search.toLowerCase())))
                                                    .map(
                                                      (e) => TableRow(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white38)),
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: Text(
                                                              e['name'],
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15.0),
                                                            child: Text(
                                                              "Cote d’ivoire",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      15.0),
                                                              child: candidates.where((element) => element['id'] == e.id && element.containsKey('slectedAlready')).isNotEmpty? Container():Checkbox(
                                                                  value: candidates.where((element) => element['id'] == e.id).isNotEmpty,
                                                                  onChanged:
                                                                      (z) {
                                                                    print(candidates);

                                                                    if (z ==
                                                                        true) {
                                                                      candidates
                                                                          .add({'id':e.id,'type': 'Inactive'}
                                                                              );
                                                                    } else {
                                                                      candidates
                                                                          .removeWhere((element) => element['id'] == e.id);
                                                                    }
                                                                    setState(
                                                                        () {});
                                                                  })),
                                                        ],
                                                      ),
                                                    )
                                                    .toList(),
                                          );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (isCountrySelectorOpen)
                  Positioned(
                      top: posY,
                      left: posX,
                      child: Card(
                        child: Container(
                            width: 200,
                            height: 150,
                            child: ListView(
                              children: countries!.map((element) {
                                return ListTile(
                                  title: Text(element),
                                  onTap: () {
                                    setState(() {
                                      selectedLocation = element;
                                      isCountrySelectorOpen = false;
                                      isDrawerOpened = false;
                                    });
                                  },
                                );
                              }).toList(),
                            )),
                      )),
                if (isCitySelectorOpen)
                  Positioned(
                      top: posY,
                      left: posX,
                      child: Card(
                        child: Container(
                            width: 200,
                            height: 150,
                            child: ListView(
                              children: cities!.map((element) {
                                return ListTile(
                                  title: Text(element),
                                  onTap: () {
                                    setState(() {
                                      selectedLocation = element;
                                      isCitySelectorOpen = false;
                                      isDrawerOpened = false;
                                    });
                                  },
                                );
                              }).toList(),
                            )),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
