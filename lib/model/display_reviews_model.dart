import 'package:flutter/gestures.dart';
import 'package:gameinn/model/game_model.dart';
import 'package:gameinn/model/review_model.dart';
import 'package:gameinn/model/user_model.dart';

///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///

class ReviewsTabReviewModel {
/*
{
  "review": {
    "id": "63aeedc254081c3bdd815926",
    "userId": "63a80f5ac5ae0f7d5c83872a",
    "gameId": "63a82a765bafb01e29362534",
    "duplicateCheckVariable": "63a80f5ac5ae0f7d5c83872a63a82a765bafb01e29362534",
    "context": "wryıp",
    "vote": 4,
    "voted": false,
    "likeCount": 0,
    "createdAt": 1672408514,
    "updatedAt": 0,
    "likedUsers": [
      null
    ]
  },
  "game": {
    "id": "63a82a765bafb01e29362534",
    "name": "Dishonored 2",
    "cover": "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",
    "summary": "Dishonored 2 is a first-person action video game and the sequel to Dishonored. It borrows many of the gameplay elements from the first opus: players define their own play style by blending action, assassination, stealth, mobility and combat. Combining tools at their disposal, players are allowed options to eliminate enemies, whether they choose to pursue them unseen or ruthlessly attack head on. Dishonored 2 features the same campaign style as its predecessor in which the protagonist must advance through a series of missions.",
    "genres": [
      "Shooter"
    ],
    "publisher": "Zildjian",
    "platforms": [
      "PC"
    ],
    "vote": 4,
    "voteCount": 1,
    "first_release_date": 1478822400
  },
  "user": {
    "id": "63a80f5ac5ae0f7d5c83872a",
    "username": "ayse124",
    "profileImage": null,
    "following": [
      "63a458d5c5ae0f7d5c838726"
    ]
  }
} 
*/

  ReviewModel? review;
  GameModel? game;
  UserModel? user;

  ReviewsTabReviewModel({
    this.review,
    this.game,
    this.user,
  });
  ReviewsTabReviewModel.fromJson(Map<String, dynamic> json) {
    review =
        (json['review'] != null) ? ReviewModel.fromJson(json['review']) : null;
    game = (json['game'] != null) ? GameModel.fromJson(json['game']) : null;
    user = (json['user'] != null) ? UserModel.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (review != null) {
      data['review'] = review!.toJson();
    }
    if (game != null) {
      data['game'] = game!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class DisplayReviewsModel {
/*
{
  "mostPopularReviews": [
    {
      "review": {
        "id": "63ac78aa5ae61f5cacb8a9a1",
        "userId": "63a80f5ac5ae0f7d5c83872a",
        "gameId": "63a82a7e5bafb01e29362546",
        "duplicateCheckVariable": "63a80f5ac5ae0f7d5c83872a63a82a7e5bafb01e29362546",
        "context": "qefuoğ",
        "vote": 4,
        "voted": false,
        "likeCount": 2,
        "createdAt": 1672247466,
        "updatedAt": 0,
        "likedUsers": [
          "63a80f5ac5ae0f7d5c83872a"
        ]
      },
      "game": {
        "id": "63a82a7e5bafb01e29362546",
        "name": "DJMAX Respect",
        "cover": "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCABaAFoDASIAAhEBAxEB/8QAHAAAAgMBAQEBAAAAAAAAAAAABQYDBAcCAQAI/8QAOhAAAQMDAgMECAUEAQUAAAAAAQIDBAAFEQYSEyExByJBURQVIzJSYXGBCDNCkaFicrHRQxYkU1SS/8QAGwEAAgMBAQEAAAAAAAAAAAAABAUCAwYAAQf/xAAvEQACAgEEAAMGBQUAAAAAAAABAgADEQQSITEFE0EiI1FhcfAUMpGhsSSBwdHh/9oADAMBAAIRAxEAPwDe1ww3v4itqkjOPE0r3R0tr9Inr7ufZREHkcfEf800Xu9paJW2EI6DfjnSszZXrs6ZsslDR/LQo89opJ47rttYq9TGPhtKhjY/QntgR6/ml+6Djxmfy2OjQV9PlTPdNP2+bblr9HQwWQVgtgCoNOW1lq0NDHvlTg+55V9ebPImfl3FbR6BHVI+eOmaM0CGvTBV7I5zK9RdvvJBwBE1qRIQyd6pbsbbvcEcJGMnkknu86ZbIi1z4LRlMGKCPZ8ZaSW/kat6ZhxoL8qApxuRl7erjY3Lykd7FLes4lwRqeA5ZGm0RmwA+yPcKCc7+XRaSE4pW/hKqN7sB6n4fQdQltTubaucfL/MluVrVJdcjQkPR2wBxJR7oOf0gUTtWpLZpW0rt9xuTK2YSQllYGHHAfDaOuK7avbC4cgyFFaBkqWn9bh8KyDUc6NeJnHbdHDecRbm3ieRwrLhz5ZOKo8IX+q9z+X1naks1eHmq6b1a/rFyTcIsb0W3A8NgvHC3z4nHQCmSJILLhD8cKyk8yKFWqHHgW9i3xkJS0ygIATRArdhM7UHdnqDzArX7h1E+OeJAssrJIG3nXOxHx1JxY7/ACLSmlnxa5j9q6NvOfzP4NS3/OR2wXc2kTbqywPcCd6qtz18GE+sfpbVj9qoRpCU3CS+v4yP2AFXrg0X4TjedvEARnyya+ea12v1RA+OI9qwiAGXrW8zAaZiPK9oGhjHhgUu6n1AiM86gOLw2MBtHMuL8eQ5nqkYqXV0OUmKLjFO2TC5Fs8wseWKDaO9EuV3NylIbakrBMVtw+BPMpJ6860V2rag7ChPHGP4lNGlDobs/URS9XSEaxlXWepUdcSFxHoKipSQpY7ucHG6rUG66luEVhz1S4xAeWEOKbW9swT4EjBp4t2l53re63C6qjKS5Iy01sSPDksnxwOVWX9SMrSptDpkNbNmGBvQU/aqtfr/AC2VPw72nA/KMj9epCpiM4YCIcqDc9V2D1Vp90x1GYUKcdG0FsBe5SaFXjszmWq1QrU8+lYiIIZcQNo51rVkukOe/G9ktEaKXm1rKMBtwFGEnxHI1zctR2C8IfgMXCLIWjOUIOSKZaQEU70XYTyQex8jKzcWsG7kffUStFazmW+OLbe4jq3mAA2+nqtNPTV19ZMhbbLyGvNYxzNDbPbYVwhAymCxMGBhCDlYPRQxRpmzTGWVplSUMsbvzF8iseHd86p0j3u7eYMfxPdSKQPYHMtwLM+X2nlgJQCCedHFRkqUTtHM5oBEkCM+2hgOKRu5uOn/AAKNGe1k+0T1o1mVTgmBCIcOISzJcWk8nF4yOveolccptkpwe822FfsRUWn5cm8tPRHNqlxyE5HwkZBoxd46BbUxG0+0nqS19M81H7AVjtNQ1t/mr1nMbWPs9lu4s9p1xV6gkyICFLWUJbUUDI3r5fwKB3yXEtqLXY2WmXbg20lZQte3Yk/bqa1CJZ4zTDEVLQ4bXPB8aUb32ZR3dVJvcRTodcUFuA8wcVrvwtd1q2WnhYImpaoba4i9vVw1BpHQcOZBnp9KYuMdccoJ3g97lS9oXSau1Cwm5RdX6vcW2S3Nt6rtwRDd+DAQSU0zfiZheq+zJiS6c7LrFUr+f9VnOnLnqzTLsztYgWpPodwcBl2psEH1eO7xSPiJq9nCOFUZBlNh8zLE8xs/D3Ful20RGjwpxYeTcZ/FkOd8qSeGK2W2dm1htzbCvRgt5kc3Om8/EayL8MF1jQNECbIXsbVMmqH7t1pd/wC0JNthszZjaGoErchIz7RBHiRXtbuyf3I+vJkQDniea+11C0xb0MWtQcnLVtaQxz5jwNVG/XWorDHkXM+i3LbvLaVhSCPAHw5ikF+4zbg+uVpy1tpSWccdTYWsr8eSiOXzqXTPaJebG1aYeoIj0x5x3gTW2ouwQ0k4QsLBwRSvxN3sqFdICkd88/tniF0oKzuPMeLa/dmEgOOtuoBIwsc0fer/ABl/Gqu7kthme0v3GpXs1fJY6Kr30J/4aB094ZPZ5ntq85IxD9vFlZdckQgkKGGVlAPLHQGoA+mZeuKjKmYjJwP6ln/QoQ23It14fYaQVInICsI+IUbtcYwXJKHFo4hcS4foEjlUtE1l2DsCqO8DHM6xVTJzknqFICHkMf8AcbeISScVaqBExhZCQ6jJ6DPOp6fJgDGcwE9xL7UdBs9oVijWmQsCM1OalPI/8qUZ7n3q5AtCLTalMGK06l9vY+AnICcYCAnxSBS0uZqrTdxs8W9XlEtC33y+42wAH0EdxPy21atsm/PXOLCcvSl8O2ucRxEVPBfkqPJeeo2+VciAkvJEMAOOIr6ctOlOz4PW2Pd4AhokSZIirfSCzvCMIwadLDAtl2gR3pDcaahY7pyFpH0pcf0VdI12gTZohTY3o2LgBFTl98jCnAaN6VWmBbY9tel8eWyglw8MIzlXkABS/WO1C5AOP9y5GJBAnU3TjcK4IkwnOFg95CU8vpS3P0U1edXNXFyY+0xFCFuxW+SZBB3J3fIEVozyGX0cRwq5p8PMUsOTmIDs2U+ragKS2PMkDw/es1qtQytlD3DdOWs4bmU9WcRbLKGxuWjLh+gr1nVDvCRlKs7RV2PEeWy9Imo2vPozw1f8afBNIu1PnQddz1ZAjGmtLBhvSahIdmNRH34ikIex3VbMk/Kl5cu5ykKmMPKf4iSh5pXVCh0pllP7trbY2gHp86ATI71mmGY2N0V4+2QPA+dEHxHUIAitkdQGitSDxzBaJiEGZJdmoansOg7PdC/PH0pw0Fru367trs23pXw23C3lQ97HjSNqthlUhl9gIw+jOU+JHjQDTerdS23VFs0hp2yIFrbbMlbiP1BRVuJJ5DBp/wCF+Ief7thhgP1les0u1BYvR/aNXbvEv79ttrtkZ38KYyreOrKwvAV/b501262xLfa2/wDqByEmbtyshzaP5NR9ocS53TR8ldqkiLPjgPjnyO3mUmq6bnpTXFgiyX5kVLrzCVgodHEbJHSmoZBnMXguRhZnF27QLGzr25W9ybGjwIrTQZdcJUFrPvbcU8WRYdIegtpdjOAEylf8g/pHlX5/1P2Uau1FquRItVrcdjNSAht13DaXEj9eVVvWi7JcdNaOtdquLsNEmM1sdW29xDkknl0pL40d1fu7Mj4Z4hVJPTCMUy4twre645lRHNpsdVq8hQTSen35s0XG6d9Tai4hs80oUTn7mvHkpW9ht9T7x+6sUwWmNMit+kS3RHZA93xNIdJ7TjIziEFjXWQp7lLVLrkJp7aQXH8hv/f2rOth8v4pp1RcxKcVsJUpw7Enx2141pZ7hIzKWk7R3fL5VS+0uSOow0ti01jf6w7KmOCUUFKQEK6DrXdwuUdEBxDnRfcA6k1UvvvO/wBlB7gSYUXJJ61GtiW2wdKg2DAc/LaQyhxSo4VlOR0zQi8S71Cs8pzT8j0W5owWnCB0JAV1pibAPFzz7iqFt/mRv7jV1VhosDr6cxpsFtZQ+stWu1apZ0i+/qC/xUNyWCH3OOXStJ8QfOhX4fdNWe86Qn3J95bpizXm0bvdQkVLOab4Z7ieqvCodFKU2m8xkEpYXNG5oHCVexHUdK1dWvW8EFMZHx/5EduhNI3BvX79Z1rC1aimTIbGhrgHUnLjqkZdCwsjbjPIBNNto0DMYQ0u/Xh5SwkbmGMZWfHJ6CtHtcONCtrTUWOzHbCBhDSAkD7Cgsr8w0s8TrrpQMFGT9+nc6rVWMSoOPv9pWaRHgIIhx0ND+n3j9TQi8XtWzY69uQgcm0mrN2J2dTSmvvcPdz3K558aRIzPkEwqmoOctC+nmUzZRnylJ7pw0g/5+lOPoyvNNJlo/PJ8dtdemSf/Ye/+zUbKlJwRPL69zT/2Q==",
        "summary": "DJMax Respect is a rhythm game and a reboot of the latest installment in the DJMax rhythm game series.",
        "genres": [
          "Music"
        ],
        "publisher": "Ablex",
        "platforms": [
          "Playstation 4"
        ],
        "vote": 4,
        "voteCount": 1,
        "first_release_date": 1501200000
      },
      "user": {
        "id": "63a80f5ac5ae0f7d5c83872a",
        "username": "ayse124",
        "profileImage": null,
        "following": [
          "63a458d5c5ae0f7d5c838726"
        ]
      }
    }
  ],
  "friendReviews": [
    {
      "review": {
        "id": "63aeedc254081c3bdd815926",
        "userId": "63a80f5ac5ae0f7d5c83872a",
        "gameId": "63a82a765bafb01e29362534",
        "duplicateCheckVariable": "63a80f5ac5ae0f7d5c83872a63a82a765bafb01e29362534",
        "context": "wryıp",
        "vote": 4,
        "voted": false,
        "likeCount": 0,
        "createdAt": 1672408514,
        "updatedAt": 0,
        "likedUsers": [
          null
        ]
      },
      "game": {
        "id": "63a82a765bafb01e29362534",
        "name": "Dishonored 2",
        "cover": "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",
        "summary": "Dishonored 2 is a first-person action video game and the sequel to Dishonored. It borrows many of the gameplay elements from the first opus: players define their own play style by blending action, assassination, stealth, mobility and combat. Combining tools at their disposal, players are allowed options to eliminate enemies, whether they choose to pursue them unseen or ruthlessly attack head on. Dishonored 2 features the same campaign style as its predecessor in which the protagonist must advance through a series of missions.",
        "genres": [
          "Shooter"
        ],
        "publisher": "Zildjian",
        "platforms": [
          "PC"
        ],
        "vote": 4,
        "voteCount": 1,
        "first_release_date": 1478822400
      },
      "user": {
        "id": "63a80f5ac5ae0f7d5c83872a",
        "username": "ayse124",
        "profileImage": null,
        "following": [
          "63a458d5c5ae0f7d5c838726"
        ]
      }
    }
  ]
} 
*/

  List<ReviewsTabReviewModel?>? mostPopularReviews;
  List<ReviewsTabReviewModel?>? friendReviews;

  DisplayReviewsModel({
    this.mostPopularReviews,
    this.friendReviews,
  });
  DisplayReviewsModel.fromJson(Map<String, dynamic> json) {
    if (json['mostPopularReviews'] != null) {
      final v = json['mostPopularReviews'];
      final arr0 = <ReviewsTabReviewModel>[];
      v.forEach((v) {
        arr0.add(ReviewsTabReviewModel.fromJson(v));
      });
      mostPopularReviews = arr0;
    }
    if (json['friendReviews'] != null) {
      final v = json['friendReviews'];
      final arr0 = <ReviewsTabReviewModel>[];
      v.forEach((v) {
        arr0.add(ReviewsTabReviewModel.fromJson(v));
      });
      friendReviews = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (mostPopularReviews != null) {
      final v = mostPopularReviews;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['mostPopularReviews'] = arr0;
    }
    if (friendReviews != null) {
      final v = friendReviews;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['friendReviews'] = arr0;
    }
    return data;
  }
}
