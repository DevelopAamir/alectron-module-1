
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class LoginUtils{
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Future<User?> login()async{
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final res = await FirebaseAuth.instance.signInWithCredential(credential);

    return res.user;
  }

  Future uploadUserData(data,habit)async{
    await firestore.collection('Users').doc(data['ID']).set(data);
    await firestore.collection('Habitations').doc(data['ID']).set(habit);
  }
}