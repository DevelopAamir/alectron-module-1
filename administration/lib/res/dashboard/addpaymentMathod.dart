import 'package:administration/res/auth/components/paymentTextFiled.dart';
import 'package:administration/res/auth/components/submitButton.dart';
import 'package:administration/res/constant.dart';
import 'package:administration/res/dashboard/thankyou.dart';
import 'package:flutter/material.dart';

class AddPaymentsMethod extends StatelessWidget {
  AddPaymentsMethod({Key? key}) : super(key: key);
  var i = 'sdk';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte bancaire'),
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                   Icon(Icons.payment_outlined,size: 50,color: Colors.white70,),
                   SizedBox(width: 20,),
                  Expanded(child: PaymenttextFiled(hintText: '42 42 42 42 42 42 42 42')),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.calendar_today_outlined,size: 50,color: Colors.white70,),
                        SizedBox(width: 20,),
                        Expanded(child: PaymenttextFiled(hintText: '00/00')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.credit_card,size: 50,color: Colors.white70,),
                        SizedBox(width: 20,),
                        Expanded(child: PaymenttextFiled(hintText: 'CVV')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(Icons.person_outline,size: 50,color: Colors.white70,),
                  SizedBox(width: 20,),
                  Expanded(child: PaymenttextFiled(hintText: 'Noms sur la carte')),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListTile(
                  title: const Text('Total',style: TextStyle(color: Colors.white70),),
                  trailing: const Text('3000 FCFA',style: TextStyle(color: Colors.white70),),
                  ),
            ),
            const SizedBox(height: 60,),
             Padding(
              padding: const EdgeInsets.all(15.0),
              child: SubmitButton(title: 'Payer',onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ThankYou()));
              },),
            ),

          ],
        ),
      ),
    );
  }
}

