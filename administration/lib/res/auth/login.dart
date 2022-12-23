

import 'package:administration/res/auth/completeProfile.dart';
import 'package:administration/res/auth/components/authField.dart';
import 'package:administration/res/auth/utlis/loginUlits.dart';
import 'package:administration/res/auth/varify.dart';
import 'package:administration/res/constant.dart';
import 'package:administration/res/dashboard/dashboard.dart';
import 'package:administration/res/globalUtils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../dashboard/components/contryPicker.dart';
import 'components/submitButton.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,

                children:   [


                  const Text('Bienvenue sur Alectron. \nL’application qui vous alertera \nen cas de prévention habituelle et gouvernementale.',style: TextStyle(color:Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  const SizedBox(height: 50,),
                  Hero(

                      tag: 'logo',
                      child: Image.asset('assets/logo.png')),
                  const SizedBox(height: 100,),

                   SubmitButton(
                     leading: 'assets/google.png',
                     title: 'Connectez vous avec Google',
                    onTap: (){
                      LoginUtils().login().then((value)async{
                        if(value != null){
                          final firestore = FirebaseFirestore.instance;
                          final d = await firestore.collection('Users').doc(userId(value.uid)).get();
                          if(!d.exists){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Complete(user: value,)));
                          }else{
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                          }

                        }
                      });
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>const Varify()));
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

