import 'dart:convert';

import 'package:gameinn/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class UserService {
  Future<UserModel?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));
    return user;
  }
}
