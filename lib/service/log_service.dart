import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gameinn/model/log_model.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/review_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/widgets/show_custom_loginerror_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_model.dart';

class LogService {
  final String log_add_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/user/';

  final dio = Dio();

  Future<UserModel?> LogCall(
      {required BuildContext ctx,
      required int createDate,
      required int updateDate,
      required int startDate,
      required int stopDate,
      required String gameId,
      required bool finished,
      required String userId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");

    Map<String, dynamic> json = {
      "createDate": createDate,
      "updateDate": updateDate,
      "startDate": startDate,
      "stopDate": stopDate,
      "gameId": gameId,
      "finished": finished,
    };
    try {
      var response = await dio.post(
        "$log_add_url$userId/log/",
        data: json,
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      if (response != null && response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      showCustomLoginError(ctx, 'Error', 'Cannot write log.');
    }
  }

  Future<List<LogModel>?> LogGet(
      {
      required String userId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");

    try {
      var response = await dio.get(
        "$log_add_url$userId/logs",
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      if (response != null && response.statusCode == 200) {
        var result =
            (response.data as List).map((x) => LogModel.fromJson(x)).toList();
        return result;
      }
    } on DioError catch (e) {
    }
  }

  // Future<List<ReviewLogModel>?> reviewLogGet(
  //     {required BuildContext ctx, required String gameId}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = (prefs.getString('token') ?? "");
  //   try {
  //     var response = await dio.get(
  //       "$review_get_for_log_url$gameId/page",
  //       options: Options(
  //           headers: {"authorization": "Bearer $token"},
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status! <= 500;
  //           }),
  //     );
  //     if (response != null && response.statusCode == 200) {
  //       var result = (response.data['reviews'] as List)
  //           .map((x) => ReviewLogModel.fromJson(x))
  //           .toList();
  //       return result;
  //     }
  //   } on DioError catch (e) {
  //     showCustomLoginError(ctx, 'Error', 'Cannot write review.');
  //   }
  // }
}
