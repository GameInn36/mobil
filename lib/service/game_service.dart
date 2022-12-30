import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gameinn/model/display_games_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/game_model.dart';

class GameService {
  String display_games_url =
      "https://api-gateway-ixdm6djuha-uc.a.run.app/game/displayGames";

  final dio = Dio();
  String token = "";

  Future<DisplayGamesModel?> displayGamesPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? "");

    try {
      var response = await dio.get(
        display_games_url,
        options: Options(
            headers: {"authorization": "Bearer $token"},
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );

      if (response != null && response.statusCode == 200) {
        var result = DisplayGamesModel.fromJson(response.data);
        return result;
      }
    } on DioError catch (e) {}
  }
}
