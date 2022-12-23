import 'package:alectron/res/Auth/components/textstyle.dart';
import 'package:alectron/res/Auth/modals/signinCredential.dart';
import 'package:alectron/res/Auth/utils/auth.dart';
import 'package:alectron/res/constants.dart';

import 'package:flutter/material.dart';

import '../components/AuthTexrtField.dart';
import '../components/Authbtjn.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SignInCredential cred = SignInCredential('', '');
  bool visible = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black87,
      body: spinner(
        visible: visible,
        child: Center(
          child: MediaQuery.of(context).size.width <
                  MediaQuery.of(context).size.height
              ? Container(
                  color: Colors.black,
                  child: Center(
                      child: Text(
                    'Only Available For Computers',
                    style: headingText.copyWith(color: Colors.white70),
                  )),
                )
              : ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connexion',
                          style: headingText.copyWith(color: Colors.white70),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthTextField(
                          hintText: 'email',
                          icon: Icons.person_outline,
                          onChanged: (a) {
                            setState(() {
                              cred.email = a.toString();
                            });
                          },

                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AuthTextField(
                          hintText: 'mot de passe',
                          icon: Icons.lock_outline,
                          onChanged: (a) {
                            setState(() {
                              cred.password = a.toString();
                            });
                          },

                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AuthButton(
                          onTap: () async{
                            setState(() {
                              visible  = true;
                            });
                            await Authentication().login(cred,context).then((value){
                              setState(() {
                                visible = false;
                              });
                              if(value!= null) {
                                Navigator.pushNamed(context, '/Tableaudebord');
                              }
                            });

                          },
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
