import 'dart:async';

import 'package:administration/res/globalUtils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationConfig{
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final message = FirebaseMessaging.instance;
  config()async{
    
    var token = await message.getToken();
    _firestore.collection('NotificationTokens').doc(userId(_auth.currentUser!.uid)).set({
      'token' : token,
      'ID' : userId(_auth.currentUser!.uid),
    });
    print(token);
  }

  notificationHandler(context){
    return FirebaseMessaging.onMessage.listen((event) {
      showDialog(context: context, builder: ((context) {
        return AlertDialog(
          title: Text(event.data['title']),
          content: Text(event.data['body']),
          actions: [
            OutlinedButton(onPressed: () => Navigator.pop(context), child: Text('ok'))
          ],
        );
      }));
    });
  }

}