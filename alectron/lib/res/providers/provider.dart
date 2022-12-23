

import 'package:flutter/material.dart';

class StateManagement with ChangeNotifier {
  List users = [];
  setUsers(List user){
    users == user;
    notifyListeners();
  }
}
