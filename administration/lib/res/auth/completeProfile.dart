import 'package:administration/res/auth/components/submitButton.dart';
import 'package:administration/res/auth/utlis/loginUlits.dart';
import 'package:administration/res/constant.dart';
import 'package:administration/res/dashboard/components/discWithEdit.dart';
import 'package:administration/res/dashboard/components/profileCard.dart';
import 'package:administration/res/dashboard/dashboard.dart';
import 'package:administration/res/globalUtils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../dashboard/components/tileField.dart';

class Complete extends StatefulWidget {
  final User? user;
  const Complete({Key? key, this.user}) : super(key: key);

  @override
  State<Complete> createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {
  var habitation;
  var name;
  var wa;
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    name = widget.user!.displayName;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Information sur votre profil'),
      ),
      body: spinner(
        visibility: visibility,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('BieSomthing',style: TextStyle(color: Colors.white70,fontSize: 22,fontWeight: FontWeight.bold),),
                // Text('Albert somthing',style: TextStyle(color: Colors.white70,fontSize: 22,fontWeight: FontWeight.bold,height: 1.5)),
                // SizedBox(height: 15,),
                // ProfileCard(title: 'AlbertSomethine'),
                // DiscWithEdit(title: 'Habitation',withButton: true,),
                // DiscWithEdit(title: 'Assurance',withButton: true,),
                // DiscWithEdit(title: 'Alectron Alertes',withButton: true,),
                // DiscWithEdit(title: 'Souscription (Mai 2022)',value: '0 0 0 0 0 FCFA',withButton: true,)
                TileFile(
                  text: widget.user!.displayName,
                  title: 'Nom/Prénom',
                  onChange: (a) {
                    setState(() {
                      name = a;
                    });
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                TileFile(
                  text: '+225',
                  title: 'Numéro Whatsapp',
                  onChange: (a) {
                    setState(() {
                      wa = a;
                    });
                  },
                  readOnly: false,
                ),
                SizedBox(
                  height: 25,
                ),
                TileFile(
                  text: widget.user!.email,
                  title: 'Adresse e-mail',
                  readOnly: true,
                ),
                SizedBox(
                  height: 25,
                ),
                TileFile(
                  text: userId(widget.user!.uid),
                  title: 'ID',
                  readOnly: true,
                ),
                SizedBox(
                  height: 25,
                ),
                DiscWithEdit(
                  title: 'Habitation',
                  value: '',
                  withButton: true,
                  withEdit: true,
                  onChanged: (a) {
                    setState(() {
                      habitation = a;
                    });
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                SubmitButton(
                  onTap: () async {
                    setState(() {
                      visibility = true;
                    });
                    if(habitation == null){
                      toast('Enter Habitation');
                    }
                    else if(wa != null) {
                      await LoginUtils().uploadUserData({
                        'email': widget.user!.email,
                        'name': name,
                        'ID': userId(widget.user!.uid),
                        'whatsapp': wa,
                        'available': false,
                        'current_location' : GeoPoint(0,0),
                        'last_pos_changed' : DateTime.now()
                      }, {
                        'habitaion': habitation
                      });
                    } else {
                      toast('Enter Whatsapp Number');
                    }
                    setState(() {
                      visibility = false;
                    });
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
