import 'package:alectron/res/constants.dart';
import 'package:alectron/res/dashboard/components/addTextField.dart';
import 'package:alectron/res/dashboard/components/employeeTypeSelector.dart';
import 'package:alectron/res/dashboard/utils/administratorUtils.dart';
import 'package:flutter/material.dart';
import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/dashboard/components/calendarCard.dart';
import 'package:alectron/res/dashboard/components/drawer.dart';

class Ajoutdadministrateurs extends StatefulWidget {
  const Ajoutdadministrateurs({Key? key}) : super(key: key);

  @override
  State<Ajoutdadministrateurs> createState() => _AjoutdadministrateursState();
}

class _AjoutdadministrateursState extends State<Ajoutdadministrateurs> {
  bool administrator = false;
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  bool visibleProfile = false;
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), //
        child: Container(
          child: Row(
            children: [
              SizedBox(
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
      body: spinner(
        visible: visible,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child:
               Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomDrawer(
                    selectedPage: 'Ajoutdadministrateurs',
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
                            'Ajout d’administrateurs',
                            style: headingText.copyWith(color: Colors.white70),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                         Padding(
                          padding: EdgeInsets.all(20.0),
                          child: AddTextField(
                            controller: name,
                            title: 'Nom complet',
                            hintText: 'Entrer le nom complet',
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.all(20.0),
                          child: AddTextField(
                              title: 'Email', hintText: 'Entrer l’email',controller: email,),
                        ),
                         Padding(
                          padding: EdgeInsets.all(20.0),
                          child: AddTextField(
                            title: 'Mot de passe',
                            hintText: 'Entrer le mot de passe ',controller: password,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: EmployeeTypeSelector(
                            title: 'Administrateur',
                            value: administrator,
                            onchanged: (a) {
                              setState(() {
                                administrator = true;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: EmployeeTypeSelector(
                            title: 'Vice administrateur',
                            value: administrator == false,
                            onchanged: (a) {
                              setState(() {
                                administrator = false;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            onTap: () async{
                              setState(() {
                                visible = true;
                              });
                              await AdministrationUtils().addAdministrator(
                                  data: {
                                    'name': name.text.trim(),
                                    'email': email.text.trim(),
                                    'password': password.text.trim(),
                                    'role' : administrator? 'Admin' : 'Vice Admin'
                                  },
                                  email: email.text.trim(),
                                  password: password.text.trim());
                              setState(() {
                                visible = false;
                              });
                            },
                            child: Container(
                              width: 400,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: const Color(0xffE8991A),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                child: Text('Confirm'),
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
