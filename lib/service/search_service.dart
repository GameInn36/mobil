import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/game_model.dart';

class SearchService {

  String searchgame_url = 'https://api-gateway-ixdm6djuha-uc.a.run.app/game/?name=';
  String searchstudio_url = 'https://api-gateway-ixdm6djuha-uc.a.run.app/game/?studio=';

  final dio = Dio();
  String token="";

  Future<List<GameModel>?> gameSearch({
    required String searched_name,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");

    var search_url_updated = searchgame_url + searched_name;
    try {
      var response = await dio.get(
        search_url_updated,
        options: Options(
            headers: {
              "authorization": "Bearer $token"
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }
        ),
      );
      search_url_updated = searchgame_url;
      if (response != null && response.statusCode == 200) {
        var result = (response.data as List).map((x) => GameModel.fromJson(x)).toList();
        return result;
      }
    } on DioError catch (e){
    }
  }

  Future<List<GameModel>?> studioSearch({
    required String searched_name,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");
    var search_url_updated = searchstudio_url + searched_name;
    try {
      var response = await dio.get(
        search_url_updated,
        options: Options(
            headers: {
              "authorization": "Bearer $token"
            },
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }
        ),
      );
      search_url_updated = searchstudio_url;
      if (response != null && response.statusCode == 200) {
        var result = (response.data as List).map((x) => GameModel.fromJson(x)).toList();
        return result;
      }
    } on DioError catch (e){
    }
  }
}