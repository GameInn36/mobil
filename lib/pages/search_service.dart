import 'dart:developer';

import 'package:dio/dio.dart';

import 'game_model.dart';

class SearchService {

  String search_url = 'https://game-service-ixdm6djuha-uc.a.run.app/game/?name=';


  final dio = Dio();

  Future<List<GameModel>?> gameSearch({
    required String searched_name,

  }) async {
    log("searched *> ${searched_name}");
    var search_url_updated = search_url + searched_name;
    try {
      var response = await dio.get(search_url_updated);
      search_url_updated = search_url;
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