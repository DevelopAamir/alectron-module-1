import 'package:administration/res/auth/completeProfile.dart';
import 'package:administration/res/auth/components/submitButton.dart';
import 'package:administration/res/constant.dart';
import 'package:administration/res/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Varify extends StatelessWidget {
  const Varify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,),
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              const Text('Entrer le code de validation \nque nous avons envoyé \nsur 08 09 10 20 43.',textAlign: TextAlign.center,style: TextStyle(color:Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 15,),
              const VarifyTextField(),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: (){}, child: const Text('Renvoyer',style: TextStyle(color:Colors.indigo),)),
                  const Text('le message Whatsapp',style:  TextStyle(color:Colors.white),),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VarifyTextField extends StatelessWidget {
  const VarifyTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      textStyle: const TextStyle(color: Colors.white),
      numberOfFields: 4,

      //set to true to show as box or false to show as dash
      showFieldAsBox: false,

      onCodeChanged: (String code) {

      },

      onSubmit: (String verificationCode){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Complete()));
      }, // end onSubmit
    );
  }
}

