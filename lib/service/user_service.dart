import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class UserService {
  String follow_member_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/user/follow/';

  String get_user_url = 'https://api-gateway-ixdm6djuha-uc.a.run.app/user/';

  String unfollow_member_url =
      "https://api-gateway-ixdm6djuha-uc.a.run.app/user/unfollow/";

  final dio = Dio();
  String token = "";

  Future<UserModel?> followMember({
    required String user_id_to_follow,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    log("searched *> ${user_id_to_follow}");
    var search_url_updated = follow_member_url + user_id_to_follow;
    log("url -> ${search_url_updated}");
    try {
      var response = await dio.put(
        search_url_updated,
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      search_url_updated = follow_member_url;
      if (response != null && response.statusCode == 200) {
        var result = UserModel.fromJson(response.data);
        log(search_url_updated);
        log("Gelen response => ${response.data}");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String a = jsonEncode((result).toJson());
        prefs.setString('user', a);
        return result;
      }
    } on DioError catch (e) {
      log(e.message);
    }
  }

  Future<UserModel?> getUser({
    required String user_id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    log("searched *> ${user_id}");
    var search_url_updated = get_user_url + user_id;
    log("url -> ${search_url_updated}");
    try {
      var response = await dio.get(
        search_url_updated,
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      search_url_updated = get_user_url;
      if (response != null && response.statusCode == 200) {
        var result = UserModel.fromJson(response.data);
        log(search_url_updated);
        log("Gelen response => ${response.data}");
        return result;
      }
    } on DioError catch (e) {
      log(e.message);
    }
  }

  Future<UserModel?> unfollowMember({
    required String user_id_to_unfollow,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    log("searched *> ${user_id_to_unfollow}");
    var search_url_updated = unfollow_member_url + user_id_to_unfollow;
    log("url -> ${search_url_updated}");
    try {
      var response = await dio.put(
        search_url_updated,
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      search_url_updated = unfollow_member_url;
      if (response != null && response.statusCode == 200) {
        var result = UserModel.fromJson(response.data);
        log(search_url_updated);
        log("Gelen response => ${response.data}");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String a = jsonEncode((result).toJson());
        prefs.setString('user', a);
        return result;
      }
    } on DioError catch (e) {
      log(e.message);
    }
  }
}
