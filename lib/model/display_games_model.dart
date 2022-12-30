import 'package:gameinn/model/user_model.dart';

import 'game_model.dart';

class NewsFromFriendsLog {
/*
{
  "createDate": 1672311748852,
  "updateDate": 0,
  "startDate": 1672261200000,
  "stopDate": 0,
  "gameId": "63a82a825bafb01e2936254f",
  "finished": false
} 
*/

  int? createDate;
  int? updateDate;
  int? startDate;
  int? stopDate;
  String? gameId;
  bool? finished;

  NewsFromFriendsLog({
    this.createDate,
    this.updateDate,
    this.startDate,
    this.stopDate,
    this.gameId,
    this.finished,
  });
  NewsFromFriendsLog.fromJson(Map<String, dynamic> json) {
    createDate = json['createDate']?.toInt();
    updateDate = json['updateDate']?.toInt();
    startDate = json['startDate']?.toInt();
    stopDate = json['stopDate']?.toInt();
    gameId = json['gameId']?.toString();
    finished = json['finished'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['createDate'] = createDate;
    data['updateDate'] = updateDate;
    data['startDate'] = startDate;
    data['stopDate'] = stopDate;
    data['gameId'] = gameId;
    data['finished'] = finished;
    return data;
  }
}

class NewFromFriendsModel {
/*
{
  "log": {
    "createDate": 1672311748852,
    "updateDate": 0,
    "startDate": 1672261200000,
    "stopDate": 0,
    "gameId": "63a82a825bafb01e2936254f",
    "finished": false
  },
  "user": {
    "id": "63a80f5ac5ae0f7d5c83872a",
    "username": "ayse124",
    "profileImage": null,
    "following": [
      "63a458d5c5ae0f7d5c838726"
    ],
    "logs": [
      {
        "createDate": 1672311748852,
        "updateDate": 0,
        "startDate": 1672261200000,
        "stopDate": 0,
        "gameId": "63a82a825bafb01e2936254f",
        "finished": false
      }
    ]
  },
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
    "vote": 4.25,
    "voteCount": 4,
    "first_release_date": 1552003200,
    "logCount": 1
  }
} 
*/

  NewsFromFriendsLog? log;
  UserModel? user;
  GameModel? game;

  NewFromFriendsModel({
    this.log,
    this.user,
    this.game,
  });
  NewFromFriendsModel.fromJson(Map<String, dynamic> json) {
    log =
        (json['log'] != null) ? NewsFromFriendsLog.fromJson(json['log']) : null;
    user = (json['user'] != null) ? UserModel.fromJson(json['user']) : null;
    game = (json['game'] != null) ? GameModel.fromJson(json['game']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (log != null) {
      data['log'] = log!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (game != null) {
      data['game'] = game!.toJson();
    }
    return data;
  }
}

class DisplayGamesModel {
/*
{
  "newGames": [
    {
      "id": "63a82a865bafb01e2936255a",
      "name": "My Talking Tom",
      "cover": "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",
      "summary": "Adopt Talking Tom as your very own baby tamagotchi-style kitten and help him grow into a super cool fully-grown virtual cat. Dress him up in different outfits and fur colors, and choose from loads of accessories to make him look however you like! Whether you’re a kid or an adult, there’s no end to the cool fun you can have with Tom as your virtual pet!",
      "genres": [
        "Role-playing (RPG)"
      ],
      "publisher": null,
      "platforms": [
        "Android"
      ],
      "vote": 0,
      "voteCount": 0,
      "first_release_date": 1384128000,
      "logCount": 0
    }
  ],
  "mostPopularGames": [
    {
      "id": "63a82a765bafb01e29362535",
      "name": "Dark Souls III",
      "cover": "/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAYEBAUEBAYFBQUGBgYHCQ4JCQgICRINDQoOFRIWFhUSFBQXGiEcFxgfGRQUHScdHyIjJSUlFhwpLCgkKyEkJST/2wBDAQYGBgkICREJCREkGBQYJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCT/wAARCABaAFoDASIAAhEBAxEB/8QAHAAAAQUBAQEAAAAAAAAAAAAABgIDBAUHCAEA/8QANRAAAgIBAwMCBQMCBgIDAAAAAQIDBAUAERIGITEHExQiMkFRYXGRFUIjJDNDUoEIYsHR8f/EABsBAAIDAQEBAAAAAAAAAAAAAAMEAQIFBgAH/8QAJhEAAQQCAgIBBAMAAAAAAAAAAQACAxEEIRIxBRNBFCJRYYHB4f/aAAwDAQACEQMRAD8AxrFYRpiO3n7DydaD0z0+ESJHHJgSPHnVJ05jiyLuZF2I1omIijiVCB41w2flPviFqwxgC0RYTCQpEQV4/odXf9HgKKRFzDbg/pqmh6hpY/cTsrffffU6v1bjbsS/DTxOusL6eZ7uSPzA0kWek4p91hX5vxofm6Knh35zxqRv47dtGNrqzH1KjyTZGFvbB9wg/RoEn9aOmmvrDNMr91K8SQDrXxsKfjbUB0guilZNa/T2JkvW5SsNZd2f8n7AD7k6z/p71EhyGfnvZGSWvjQvCCEbtsfywGofq31/juop1xWL4PQqNzEm7bySNrPab89jy5Hjvuw37jfyNb0Hjx6z7OylnyEO0ur+nVx19VNexBKXX3AiSAnj43I1Z2acSo2w+bWE+jc01LryLtw+KgmrkJ2AA2Ya6FmrkQlyOJ1zXkoPp5KBtNwv5C0DWcV/iEkfffZdNHhue0vn8aIblaTd+7MD/wCvjVG2Mm3Pzv5/Ol2TWNlEooDwpMFdPc21cvnqtJV357P9xoXLsKjCOUSxldw8L7/wRoTnzEaT+zbsz2n3IABIA38DZdgTro24IkNlLtcaVr1Z1JPZn4R2AsJYDfzt++qnFw+8/vQWrjLsTJ7ey77dzsOXfUzAI1ezPNbxosQId/akPEO3/Hl3AP6HQ3lZ4J7806VBVhdiVjjc7Rn7ga0oYgBwaEMuo2ET5CevFTjNW6JxMD7qcz8n69/DD7jQxfr1WpsYSsUiBvsfnXzqPPMEVXBl4Ovzbnff/wDNfPjcslKO09XjA4AWbbyT37abibx7KoCdml5lxSrRVYKJbiyrJPIx7u//AND7aerPUV4wY3VpiCr/AFDc+VO331V1oWnn9kL/AHbAHt3Pkd9bZ6J+nnSfUs6WMhlLM9uBzIKEcZjQhfy/k6mVzY2bKqT7HWBSJ/QToK18VL1Fb+alwaOp8+4kJ7chrZbKRsT3VttP1K1ehTipVIo6tWFRHFBAgVY1HgADSJljT/bZv1OuM8kfaSUzFpD+QMaLxJ/gaoDYG/8AoaJLsLSbkR8iPGq/4S3/AMB/GsJjCE1a41qX7datNBVmsV4yQZED7A/bvpqH3Z5GEAaWTYuSg8AeTon6o9O8lQyEdSghtbsUlUHusg7kuO3EaHpK02KnapNA6oyhJHG/z7Hcn9tfU4pY5BbflZB5D4Ts+dyX9O/o9gHeOT3A+5DD8r28jUaTJSW1gr/DovA7NIv1Pry7W9k2JI3M4hUDxuE3O2pOEC0Gjn9uJ3U+5vI6hQftuN9SWgC2hEhoupxoK/jwMxydSqweWrJGlgGIAMFP5U91X99OZvFXMe8YCVq6SJvGEJJceNz+ul0MrE49x0NqzOA825IHY9k7duO2o+VyU9z/ADEnw1VEA4xp2KKPCgaCzmBRTE0kTnW1DixPSuETRyKyfyf176030vyM3TXVVPIQOWSRVEvu/QVftrOPe+KeSd5Hcu2yk6KUrW6kSOJCvFQ8ZQ9jt9xpfK23iVETbstGgu28csF+nFaj/wBOZA6/sdMZh8fisfayFshIKsLzynbuFUbnQh0P1MbHStCd5o2YR7MUI4b76yj1x9U62ZqTdK4q0lqa0yxSmPugUOG2LayWRtkcI+Kg2NqV0P6yi/1pmL+ZjnTGXUT4SLmCKMSbkHh5JYHdjrWqfWnTGQpwXIL8zRWI1lRvhH7qw3B8fg65DksZPEg4FoGS1OvAD612cbdlO/f8ba6dwXTgx2Ex9L4hv8vWii+pv7VA/wDjV8rGgYbcO/6UMJPSA/8AyPxt7BzRTwWXVHgAlgC8eaqfsw0Mp0VStZep0jVz1qxl8hjkt1YbtVBBM0sIn9ksCSrbdg2qf1K6pvdaObmRc+8IxGPPELqHZ9TGpZ6plo+nq9bJQU4qEdoWZD7USxeyGRT4k9vw+tLBjb66KiaVxaGhHHpd6fqOkZGnapYr9Vw/AlTW5T41zLGycyxAKFCsmhTK+ktGj1dhMerWI4c5eloostThLTZJ0iExQsQ0Lb8l0SQ+qyUunqklvG8qq2a1+GAzScKs0Dbxov4jIGx0G0vVG9ZzOMydqpSsWcVdku0QXdWCNJ73sM47tEr91GmYS37nb2gkEJjqLH1uhLBpWDN/VxJIZKc0AHtQeIzL37O4+fgPA1ZH0otZleno61+zNb6hWNop1r70o3Jb3IXkB3Dxqm7DQv1F13Y6ix9apkKNd56UztWu82M8cDMXFck9nRSW479xoq9PvVSLDZOvUjo/01bc1RrU9WRpVkmi7LL7TdlLf36YeQ0Fyo2+lN6T9JamTElelkbTPJYrwn4mqoYQyzCMzxqGPZSV5qdTl6FyMCJUvTTxRTZGnjoJ44VccZ2dOR7jYpw7rrfOnOk4YEeWo0ddXkikUxktuEfmoG/hOffbU+50VjpIlexWr8Y7cV+NC7ECWNuSEHyANYBz4nEOf8d/4mvuZbWrmTHYa9nM/e6YxmQtKtUW+EQAEltoOwjjUkL7j+Rqk6T6Zx+V6oyFcz5kf06NLEXGqiSlhNGjJIjH5Svua0XrP0ukTK33xeLoTrkJpLJuS3XV4HY8/kYfQVfx2bfSKWGykHUGX6ky0VW5k8rAsDJBO8cUCIYz9ZBLufaXdjpyPNxA22uCEWSE9I1wXpf06uYF6SpLkskksjw2rScfa9qYx9lU7fbfRv8ACYVTxOTG47eBrPq3Wctenf8AZpvVm2lMcgnL95JjIfIHgnYaDJJLMkjOxbkxJP76w8o+6Um9fymY2kDaA8vejs3YjGvCIjxtqBf9rIYx6tqxHLPUnYCcDf3k8g7/AKjxphMJl8gTHIBX591jMgWUr+QD320xcxrYy5XqJzgZ08TSBwW323+Udtb0bGtoA7CAHkX+0rPpPVVMbCWZJG9zZPD7DYH9BtqhMWxZxIPbHmT7b/pq4zlyRqkCOiLNsyNN4JX8D9NVNeJ7De4WSKGPvuT2T9TpxnSD+kxZVg4Eg0/i46k12GK1I6QE/wCI6bbj9t9JsyyTlXkfk4jVN/z99MqpSFe/17k6uRYpVBorqX0868r06DubiLGkYQPZkA2A+41oR68q5uvVkx8kU9d13MwPbkftriavfEPAf2juR9jt41PTNmsEeG1ZicNueEh1z83huZPF1WmjkC+l0x1xlJq3Ao0W0h+zg7aD61jIWeZMTOnLbWUr6kZIcOc/xAQbL7ybsP8AvV/g/XNaZWK/h+cP/OtJsf4bQx4qWNlNFqRkNJ2VrFzFyxU6zzcU59zp4dPw7f6iazvMetGPjxSGMTXLR5PHXkQqI/xzOjLHdaXLFCtM1WJDJEjleS/LuN9tZ78HJaLqkYTN/KxDJ42W3kGyyXDE/wApG4JYMBsOO2qy5YvyZWI5Z3nkEew5Hvx77eNFeMAMkhPc7DVL1gB8RWOw34nXSQyEu4lJOaveoVxr4yqIGd5k7MRyICnsPq21UUMLkM1/lcXXafh/thwGc/sdt9ey/Ljvl7bhN9vv3bUfFSyR2o2R2Rt/KnY6abYaqlKu4m9iXkgyVKenIPtZjMf6dt9QLL+AP51ofQ1+3kL/AMPctT2YeJ/w5pC6/wAHtob9RKdal1HNFVrwwR7/AERIFH8DV438tKpHyhiabcjb8abMp/PLXqjs/wD1pB0wAqrwudLilZPoPFvz99IH205D9evKFK2iKF15fKoJBPk6souqL0USIJuyqB/Gqg/SNPxgcF/YaEWg9qwNL//Z",
      "summary": "Dark Souls continues to push the boundaries with the latest, ambitious chapter in the critically-acclaimed and genre-defining series. Prepare yourself and embrace the darkness!",
      "genres": [
        "Role-playing (RPG)"
      ],
      "publisher": "Iphigeneia Studio",
      "platforms": [
        "PC"
      ],
      "vote": 5,
      "voteCount": 9,
      "first_release_date": 1458777600,
      "logCount": 1
    }
  ],
  "newsFromFriends": [
    {
      "log": {
        "createDate": 1672311748852,
        "updateDate": 0,
        "startDate": 1672261200000,
        "stopDate": 0,
        "gameId": "63a82a825bafb01e2936254f",
        "finished": false
      },
      "user": {
        "id": "63a80f5ac5ae0f7d5c83872a",
        "username": "ayse124",
        "profileImage": null,
        "following": [
          "63a458d5c5ae0f7d5c838726"
        ],
        "logs": [
          {
            "createDate": 1672311748852,
            "updateDate": 0,
            "startDate": 1672261200000,
            "stopDate": 0,
            "gameId": "63a82a825bafb01e2936254f",
            "finished": false
          }
        ]
      },
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
        "vote": 4.25,
        "voteCount": 4,
        "first_release_date": 1552003200,
        "logCount": 1
      }
    }
  ]
} 
*/

  List<GameModel?>? newGames;
  List<GameModel?>? mostPopularGames;
  List<NewFromFriendsModel?>? newsFromFriends;

  DisplayGamesModel({
    this.newGames,
    this.mostPopularGames,
    this.newsFromFriends,
  });
  DisplayGamesModel.fromJson(Map<String, dynamic> json) {
    if (json['newGames'] != null) {
      final v = json['newGames'];
      final arr0 = <GameModel>[];
      v.forEach((v) {
        arr0.add(GameModel.fromJson(v));
      });
      newGames = arr0;
    }
    if (json['mostPopularGames'] != null) {
      final v = json['mostPopularGames'];
      final arr0 = <GameModel>[];
      v.forEach((v) {
        arr0.add(GameModel.fromJson(v));
      });
      mostPopularGames = arr0;
    }
    if (json['newsFromFriends'] != null) {
      final v = json['newsFromFriends'];
      final arr0 = <NewFromFriendsModel>[];
      v.forEach((v) {
        arr0.add(NewFromFriendsModel.fromJson(v));
      });
      newsFromFriends = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (newGames != null) {
      final v = newGames;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['newGames'] = arr0;
    }
    if (mostPopularGames != null) {
      final v = mostPopularGames;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['mostPopularGames'] = arr0;
    }
    if (newsFromFriends != null) {
      final v = newsFromFriends;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['newsFromFriends'] = arr0;
    }
    return data;
  }
}
