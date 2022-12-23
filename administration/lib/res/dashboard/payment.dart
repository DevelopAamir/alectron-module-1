import 'package:administration/res/auth/components/submitButton.dart';
import 'package:administration/res/constant.dart';
import 'package:administration/res/dashboard/addpaymentMathod.dart';
import 'package:flutter/material.dart';

class Payments extends StatelessWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Paiement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text('Montant'),
                  trailing: Text('1000 FCFA'),
                  tileColor: Colors.white70,
                ),
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                    title: Text('Frais'),
                    trailing: const Text('1000 FCFA'),
                    tileColor: Colors.white70),
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                    title: const Text('Total'),
                    trailing: const Text('2000 FCFA'),
                    tileColor: Colors.white70),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Paiement par carte bancaire',
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              ListTile(
                leading: const Icon(
                  Icons.payment_outlined,
                  color: Colors.white70,
                ),
                title: const Text(
                  'Carte bancaire',
                  style: const TextStyle(color: Colors.white70),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPaymentsMethod()));
                },
              ),
              const SizedBox(height: 20,),
              const Text(
                'Par mobile money',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5,),
              const ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: Colors.white70,
                ),
                title: const Text(
                  'Orange Money',
                  style: const TextStyle(color: Colors.white70),
                ),
                subtitle: const Card(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(style : TextStyle(fontSize: 12),decoration: const InputDecoration(hintText: '+225 07 88 66 55 44',border: InputBorder.none,)),
                ),),
              ),
              const SizedBox(height: 5,),
              const ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: Colors.white70,
                ),
                title: const Text(
                  'MTN Money',
                  style: const TextStyle(color: Colors.white70),
                ),
                subtitle: const Card(child: const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(style : TextStyle(fontSize: 12),decoration: const InputDecoration(hintText: '+225 07 88 66 55 44',border: InputBorder.none,)),
                ),),
              ),
              const SizedBox(height: 5,),
              const ListTile(
                leading: const Icon(
                  Icons.person_outline,
                  color: Colors.white70,
                ),
                title: const Text(
                  'Moov Money',
                  style: const TextStyle(color: Colors.white70),
                ),
                subtitle: const Card(child: const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(style : TextStyle(fontSize: 12),decoration: const InputDecoration(hintText: '+225 07 88 66 55 44',border: InputBorder.none,)),
                ),),
              ),
              const SizedBox(height: 25,),
              const SubmitButton(title: 'Payer',)
            ],
          ),
        ),
      ),
    );
  }
}
