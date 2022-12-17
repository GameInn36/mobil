import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gameinn/model/error_model.dart';

import '../model/login_model.dart';

class LoginService {

  final String login_url = 'https://authentication-service-ixdm6djuha-uc.a.run.app/auth/authenticate';


  final dio = Dio();

  Future<LoginModel?> loginCall({
    required String email,
    required String password
  }) async {
    Map<String, dynamic> json = {
        "email": email,
        "password": password
    };
    try {
      var response = await dio.post(login_url, data: json);
      if (response != null && response.statusCode == 200) {
        var result = LoginModel.fromJson(response.data);
        log("Gelen response => ${response.data}");
        return result;
      }
    } on DioError catch (e){
      log(e.message);
    }
  }
}