import 'dart:convert';

import 'package:alectron/res/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:http/http.dart' as http;

class MessagesUtils {
  final firestore = FirebaseFirestore.instance;
  void sendSms(String message, List<String> recipents) async {}

  sendMessage(
      {required String title,
      required String decsription,
      required List ids,
      required MessageType type}) async {
    ids.forEach((elemen) async {
      var element =  elemen['id'];
      var selection_type = elemen['type'];
      if (type == MessageType.message) {
        _addMessages(element, title, decsription,selection_type);

      } else {
        _addNotification(element, title, decsription,selection_type);

      }
    });

    if (type == MessageType.message) {

      await _sendNotification(title, 'Vous avez une nouvelle alerte', ids.map((e) => e['id']).toList());
    } else {

      await _sendNotification(title, decsription, ids.map((e) => e['id']).toList());
    }

    toastSuccess('sent');
  }

  _addMessages(element, String title, String decsription,selection_type) async{
    firestore.collection('Messages').add({
      'date': DateTime.now(),
      'ID': element,
      'title': title,
      'description': decsription,
      'activeUser': await userActive(element),
      'selection_type': selection_type,

    });
  }

  _sendNotification(String title, String decsription, List id) async {
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode({
          'registration_ids': await _getTokens(id),
          'notification': {
            'body': decsription,
            'title': title,
            'android_channel_id': 'pushnotificationapp',
            'sound': true
          },
          'data': {
            'title': title,
            'body': decsription,
          }
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA-ifa0mA:APA91bGd78CgG67GKZVcy1azebS1BPCfvAPHUnwuLigivEDdnUyWiU_ZRcz6zr5QCNmSenNqdMbMbImQ9caGSy9Sylztqkudci_4AW2UyQTJtYNjxqOmRb87zdsmYeF8lsh3_RA1ZW7w'
        }).then((value) {
      print(jsonDecode(value.body));
    });
  }

  _getTokens(List id) async {
    List<String> tokens = [];
    final allTokens = await firestore.collection('NotificationTokens').get();
    id.forEach((element) {
      allTokens.docs.forEach((token) {
        if (token['ID'] == element) {
          tokens.add(token['token'].toString());
        }
      });
    });
    return tokens;
  }

  void _addNotification(element, String title, String decsription,selection_type) async{
    firestore.collection('Notifications').add({
      'date': DateTime.now(),
      'ID': element,
      'title': title,
      'description': decsription,
      'activeUser':await userActive(element),
      'selection_type': selection_type,

    });
  }

  Future<bool> userActive(id) async{
    final users = await firestore.collection('Users').where('ID',isEqualTo: id).get();
    return users.docs.first['available'];
  }
}

enum MessageType {
  message,
  notification,
}
