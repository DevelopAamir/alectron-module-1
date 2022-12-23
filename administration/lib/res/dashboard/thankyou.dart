import 'package:administration/res/auth/components/submitButton.dart';
import 'package:administration/res/constant.dart';
import 'package:administration/res/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class ThankYou extends StatelessWidget {
  const ThankYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Merci pour votre \npaiement',textAlign: TextAlign.center,style: TextStyle(color: Colors.white70,fontSize: 30,fontWeight: FontWeight.bold),),
              Lottie.asset('assets/thanks.json'),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SubmitButton(title: "D'accord,",onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                },),
              )
            ],
          ),
        ),
      ),
    );
  }
}
