import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/game_model.dart';

class SearchService {
  String searchgame_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/game/?name=';
  String searchstudio_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/game/?studio=';
  String searchmember_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/user/?username=';

  final dio = Dio();
  String token = "";

  Future<List<GameModel>?> gameSearch({
    required String searched_name,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");

    log("searched *> ${searched_name}");
    var search_url_updated = searchgame_url + searched_name;
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
      search_url_updated = searchgame_url;
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

  Future<List<GameModel>?> studioSearch({
    required String searched_name,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    log("searched *> ${searched_name}");
    var search_url_updated = searchstudio_url + searched_name;
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
      search_url_updated = searchstudio_url;
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

  Future<List<UserModel>?> memberSearch({
    required String searched_name,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    log("searched *> ${searched_name}");
    var search_url_updated = searchmember_url + searched_name;
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
      search_url_updated = searchmember_url;
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
}
