import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardUtils{
  final firestore = FirebaseFirestore.instance;
  Future<QuerySnapshot<Map<String, dynamic>>> getTotalUsers()async{
    return await firestore.collection('Users').get();
  }
  Future<QuerySnapshot<Map<String, dynamic>>> getSubscriptions()async{
    return await firestore.collection('subscription').get();
  }
}