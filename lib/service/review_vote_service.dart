import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gameinn/widgets/show_custom_loginerror_dialog.dart';

import '../model/login_model.dart';

class ReviewVoteService {
  final String review_vote_url =
      'https://api-gateway-ixdm6djuha-uc.a.run.app/review/';

  final dio = Dio();

  Future<LoginModel?> reviewVoteCall({
    required BuildContext ctx,
    required String userId,
    required String gameId,
    required String context,
    required int vote,
  }) async {
    Map<String, dynamic> json = {
      "userId": userId,
      "gameId": gameId,
      "context": context,
      "vote": vote
    };
    try {
      log(userId);
      log(gameId);
      log(context);
      log(vote.toString());
      var response = await dio.post(review_vote_url, data: json);
      if (response != null && response.statusCode == 200) {
        log("Worked!");
      }
    } on DioError catch (e) {
      showCustomLoginError(ctx, 'Error', 'Cannot write review.');
    }
  }
}
