import 'dart:developer';
import 'package:dio/dio.dart';
import '../model/game_model.dart';

class SearchService {

  String searchgame_url = 'https://game-service-ixdm6djuha-uc.a.run.app/game/?name=';
  String searchstudio_url = 'https://game-service-ixdm6djuha-uc.a.run.app/game/?publisher=';

  final dio = Dio();

  Future<List<GameModel>?> gameSearch({
    required String searched_name,
  }) async {
    log("searched *> ${searched_name}");
    var search_url_updated = searchgame_url + searched_name;
    try {
      var response = await dio.get(search_url_updated);
      search_url_updated = searchgame_url;
      if (response != null && response.statusCode == 200) {
        var result = (response.data as List).map((x) => GameModel.fromJson(x)).toList();
        log(search_url_updated);
        log("Gelen response => ${response.data}");
        return result;
      }
    } on DioError catch (e){
      log(e.message);
    }
  }

  Future<List<GameModel>?> studioSearch({
    required String searched_name,
  }) async {
    log("searched *> ${searched_name}");
    var search_url_updated = searchstudio_url + searched_name;
    try {
      var response = await dio.get(search_url_updated);
      search_url_updated = searchstudio_url;
      if (response != null && response.statusCode == 200) {
        var result = (response.data as List).map((x) => GameModel.fromJson(x)).toList();
        log(search_url_updated);
        log("Gelen response => ${response.data}");
        return result;
      }
    } on DioError catch (e){
      log(e.message);
    }
  }
}