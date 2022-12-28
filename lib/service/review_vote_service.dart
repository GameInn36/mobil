import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/review_model.dart';
import 'package:gameinn/widgets/show_custom_loginerror_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_model.dart';

class ReviewVoteService {
  final String review_vote_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/review/';
  final String review_get_for_log_url =
      "https://api-gateway-ixdm6djuha-uc.a.run.app/game/";
  final String review_update_delete_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/review/';

  final dio = Dio();

  Future<ReviewModel?> reviewVoteCall(
      {required BuildContext ctx,
      required String userId,
      required String gameId,
      required String context,
      required int vote}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");

    Map<String, dynamic> json = {
      "userId": userId,
      "gameId": gameId,
      "context": context,
      "vote": vote,
    };
    try {
      var response = await dio.post(
        review_vote_url,
        data: json,
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      if (response != null && response.statusCode == 200) {
        return ReviewModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      showCustomLoginError(ctx, 'Error', 'Cannot write review.');
    }
  }

  Future<List<ReviewLogModel>?> reviewLogGet(
      {required BuildContext ctx, required String gameId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");
    try {
      var response = await dio.get(
        "$review_get_for_log_url$gameId/page",
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      if (response != null && response.statusCode == 200) {
        var result = (response.data['reviews'] as List)
            .map((x) => ReviewLogModel.fromJson(x))
            .toList();
        return result;
      }
    } on DioError catch (e) {
      showCustomLoginError(ctx, 'Error', 'Cannot write review.');
    }
  }

  Future<ReviewModel?> reviewVoteUpdate(
      {required BuildContext ctx,
      required String userId,
      required String gameId,
      required String context,
      required int vote,
      required String review_id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");

    Map<String, dynamic> json = {
      "userId": userId,
      "gameId": gameId,
      "context": context,
      "vote": vote,
      "voted": true,
    };
    try {
      var response = await dio.put(
        "$review_update_delete_url$review_id",
        data: json,
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      if (response != null && response.statusCode == 200) {
        return ReviewModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      showCustomLoginError(ctx, 'Error', 'Cannot update review.');
    }
  }

  Future<ReviewModel?> reviewDelete(
      {required BuildContext ctx, required String review_id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");
    try {
      var response = await dio.delete(
        "$review_update_delete_url$review_id",
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      if (response != null && response.statusCode == 200) {
        return ReviewModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      showCustomLoginError(ctx, 'Error', 'Cannot write review.');
    }
  }
}
