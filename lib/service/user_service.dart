import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../model/game_model.dart';
import '../model/user_model.dart';

class UserService {
  String follow_member_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/user/follow/';

  String get_update_user_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/user/';

  String unfollow_member_url =
      "https://api-gateway-ixdm6djuha-uc.a.run.app/user/unfollow/";

  String get_details_url = "https://api-gateway-ixdm6djuha-uc.a.run.app/user/";

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
    var search_url_updated = get_update_user_url + user_id;
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
      search_url_updated = get_update_user_url;
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

  Future<List<UserModel?>?> getFollowers({
    required user_id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    log("searched *> ${get_details_url}");
    var search_url_updated = get_details_url + user_id + "/followers";
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
      search_url_updated = get_details_url;
      if (response != null && response.statusCode == 200) {
        var result =
            (response.data as List).map((x) => UserModel.fromJson(x)).toList();
        log(search_url_updated);
        log("Gelen response => ${response.data}");
        return result;
      }
    } on DioError catch (e) {
      log(e.message);
    }
  }

  Future<UserModel?> getAuthorizedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));
    return user;
  }

  Future<List<UserModel?>?> getFollowings({
    required user_id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    log("searched *> ${get_details_url}");
    var search_url_updated = get_details_url + user_id + "/following";
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
      search_url_updated = get_details_url;
      if (response != null && response.statusCode == 200) {
        var result =
            (response.data as List).map((x) => UserModel.fromJson(x)).toList();
        log(search_url_updated);
        log("Gelen response => ${response.data}");
        return result;
      }
    } on DioError catch (e) {
      log(e.message);
    }
  }

  Future<List<GameModel?>?> getFavoriteGames({
    required user_id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    log("searched *> ${get_details_url}");
    var search_url_updated = get_details_url + user_id + "/favoriteGames";
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
      search_url_updated = get_details_url;
      if (response != null && response.statusCode == 200) {
        var result =
            (response.data as List).map((x) => GameModel.fromJson(x)).toList();
        log(search_url_updated);
        log("Gelen response => ${response.data}");
        return result;
      }
    } on DioError catch (e) {
      log(e.message);
    }
  }

  Future<UserModel?> updateUser({
    required UserModel user_to_update,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    try {
      Map<String, dynamic> user_password_added = user_to_update.toJson();
      user_password_added['password'] = 'Ayse124!';
      var response = await dio.put(
        "$get_update_user_url${user_to_update.id}",
        data: user_password_added,
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      if (response != null && response.statusCode == 200) {
        var result = UserModel.fromJson(response.data);
        log("Update user response => ${response.data}");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String a = jsonEncode((result).toJson());
        prefs.setString('user', a);
        return result;
      }
    } on DioError catch (e) {
      log(e.message);
    }
  }

  Future<List<GameModel>?> toPlayList({
    required String user_id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    try {
      var response = await dio.get(
        "$get_update_user_url$user_id/toPlayList",
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      if (response != null && response.statusCode == 200) {
        var result = (response.data as List).map((x) => GameModel.fromJson(x)).toList();
        return result;
      }
    } on DioError catch (e) {
      log(e.message);
    }
  }

  Future<List<GameModel>?> PlayedGames({
    required String user_id,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    try {
      var response = await dio.get(
        "$get_update_user_url$user_id/playedGames",
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      if (response != null && response.statusCode == 200) {
        var result = (response.data as List).map((x) => GameModel.fromJson(x)).toList();
        return result;
      }
    } on DioError catch (e) {
      log(e.message);
    }
  }
}
