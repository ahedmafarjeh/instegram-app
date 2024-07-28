 import 'package:flutter/material.dart';
import 'package:new_project/firbase-services/auth.dart';
import 'package:new_project/models/userdata.dart';

class UserProvider with ChangeNotifier {
  UserData? _userData;
  UserData? get getUser => _userData;
  
  refreshUser() async {
    UserData userData = await AuthMethods().getUserDetails();
    _userData = userData;
    notifyListeners();
  }
 }