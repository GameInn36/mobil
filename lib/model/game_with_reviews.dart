import 'package:gameinn/model/game_model.dart';
import 'package:gameinn/model/review_log_model.dart';

class GameWithReviews {
/*
{
  "game": {
    "id": "63a82a825bafb01e2936254f",
    "name": "Devil May Cry 5",
    "cover": "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",
    "summary": "Devil May Cry 5 is a brand-new entry in the legendary over-the-top action series Devil May Cry. The game features three playable characters, each with a radically different stylish combat play style as they take on the city overrun with demons. Developed with Capcom’s in-house proprietary RE engine, the series continues to achieve new heights in fidelity with graphics that utilize photorealistic character designs and stunning lighting and environmental effects.",
    "genres": [
      "Hack and slash/Beat 'em up"
    ],
    "publisher": null,
    "platforms": [
      "PC"
    ],
    "vote": 3.3333333333333335,
    "voteCount": 3,
    "first_release_date": 1552003200,
    "logCount": 0
  },
  "reviews": [
    {
      "id": "63aacd95cbc72c30f62c1aa2",
      "user": {
        "id": "63a80f5ac5ae0f7d5c83872a",
        "username": "ayse124",
        "profileImage": null,
        "following": [
          "63a458d5c5ae0f7d5c838726"
        ],
        "logs": null
      },
      "context": "duejqksj",
      "vote": 3,
      "voted": false,
      "likeCount": 0,
      "createdAt": 1672138133,
      "updatedAt": 0
    }
  ],
  "followedFriendsReviews": [
    {
      "id": "63aacd95cbc72c30f62c1aa2",
      "user": {
        "id": "63a80f5ac5ae0f7d5c83872a",
        "username": "ayse124",
        "profileImage": null,
        "following": [
          "63a458d5c5ae0f7d5c838726"
        ],
        "logs": null
      },
      "context": "duejqksj",
      "vote": 3,
      "voted": false,
      "likeCount": 0,
      "createdAt": 1672138133,
      "updatedAt": 0
    }
  ]
} 
*/

  GameModel? game;
  List<ReviewLogModel?>? reviews;
  List<ReviewLogModel?>? followedFriendsReviews;

  GameWithReviews({
    this.game,
    this.reviews,
    this.followedFriendsReviews,
  });
  GameWithReviews.fromJson(Map<String, dynamic> json) {
    game = (json['game'] != null) ? GameModel.fromJson(json['game']) : null;
    if (json['reviews'] != null) {
      final v = json['reviews'];
      final arr0 = <ReviewLogModel>[];
      v.forEach((v) {
        arr0.add(ReviewLogModel.fromJson(v));
      });
      reviews = arr0;
    }
    if (json['followedFriendsReviews'] != null) {
      final v = json['followedFriendsReviews'];
      final arr0 = <ReviewLogModel>[];
      v.forEach((v) {
        arr0.add(ReviewLogModel.fromJson(v));
      });
      followedFriendsReviews = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (game != null) {
      data['game'] = game!.toJson();
    }
    if (reviews != null) {
      final v = reviews;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['reviews'] = arr0;
    }
    if (followedFriendsReviews != null) {
      final v = followedFriendsReviews;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['followedFriendsReviews'] = arr0;
    }
    return data;
  }
}
