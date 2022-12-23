import 'dart:async';

import 'package:administration/res/globalUtils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class DashboardUtils {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final res = await firestore
        .collection('Users')
        .doc(userId(auth.currentUser!.uid))
        .get();
    return res;
  }

  Future<Stream<LocationData>> locationStream() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        
      }
    }
    return location.onLocationChanged;
  }
}


