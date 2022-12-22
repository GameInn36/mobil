import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gameinn/model/error_model.dart';
import 'package:gameinn/widgets/show_custom_loginerror_dialog.dart';

import '../model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/sign_up_model.dart';

class AutherizationService {
  final String login_url =
      'https://authentication-service-ixdm6djuha-uc.a.run.app/auth/authenticate';
  final String sign_up_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/auth/register';

  final dio = Dio();

  Future<LoginModel?> loginCall(
      {required BuildContext ctx,
      required String email,
      required String password}) async {
    Map<String, dynamic> json = {"email": email, "password": password};
    try {
      var response = await dio.post(login_url, data: json);
      if (response != null && response.statusCode == 200) {
        var result = LoginModel.fromJson(response.data);
        log("Gelen response => ${response.data}");
        return result;
      }
    } on DioError catch (e) {
      showCustomLoginError(ctx, 'Error', 'Invalid email or password.');
    }
  }

  Future<SignUpModel?> signUpCall({
    required BuildContext ctx,
    required String email,
    required String password,
    required String name,
  }) async {
    Map<String, dynamic> json = {
      "email": email,
      "password": password,
      "username": name
    };
    try {
      var response = await dio.post(sign_up_url, data: json);
      if (response != null && response.statusCode == 200) {
        var result = SignUpModel.fromJson(response.data);
        log("Gelen response => ${response.data}");
        return result;
      }
    } on DioError catch (e) {
      showCustomLoginError(ctx, 'Error', 'Invalid email or password.');
    }
  }
}
