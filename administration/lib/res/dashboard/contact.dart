import 'package:administration/res/constant.dart';
import 'package:flutter/material.dart';


class Contact extends StatelessWidget {
  final number;
  final email;
  final name;
  const Contact({Key? key, this.number, this.email, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(title: const Text('Contacter Nous',style: TextStyle(color: Colors.white70),),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nom',style: TextStyle(color: Colors.white70,fontSize: 22,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Icon(Icons.person,color: Colors.brown,),
                  const SizedBox(width: 10,),
                  Text(name,style: const TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.bold),),

                ],
              ), const SizedBox(height: 30,),
              const Text('Par telephone',style: TextStyle(color: Colors.white70,fontSize: 22,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Icon(Icons.whatsapp,color: Colors.green,),
                  const SizedBox(width: 10,),
                  Text(number,style: const TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.bold),),

                ],
              ),const SizedBox(height: 30,),
              const Text('Par Email',style: TextStyle(color: Colors.white70,fontSize: 22,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Icon(Icons.email,color: Colors.deepPurpleAccent,),
                  const SizedBox(width: 10,),
                  Text(email,style: const TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.bold),),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
