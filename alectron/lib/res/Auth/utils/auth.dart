import 'package:alectron/res/Auth/modals/signinCredential.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';

class Authentication {
  final auth = FirebaseAuth.instance;
  Future<User?> login(SignInCredential credential,context) async {

    if (credential.email == '') {
      toastError('Email is required');
    } else if (credential.password == '') {
      toastError('Password is required');
    } else {
      try {
        final response = await auth.signInWithEmailAndPassword(
            email: credential.email, password: credential.password);
        var data = response.user;
        if(data != null){
          toastSuccess('Login Successful');

        }

        return data;
      } on FirebaseAuthException catch (e) {

          toastError(e.message);



      }
    }
  }

  checkSession(context) async {
    if (auth.currentUser != null) {
      return auth.currentUser;

    }else{
      Navigator.pushNamed(context, '/connexion');
    }
  }
}
