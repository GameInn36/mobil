///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class UserModelLogs {
/*
{
  "createDate": "1458777600",
  "updateDate": "1458777600",
  "startDate": "1458777600",
  "stopDate": "1458777600",
  "gameId": "lllla",
  "finished": false
} 
*/

  int? createDate;
  int? updateDate;
  int? startDate;
  int? stopDate;
  String? gameId;
  bool? finished;

  UserModelLogs({
    this.createDate,
    this.updateDate,
    this.startDate,
    this.stopDate,
    this.gameId,
    this.finished,
  });
  UserModelLogs.fromJson(Map<String, dynamic> json) {
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

class UserModel {
/*
{
  "id": "63a458d5c5ae0f7d5c838726",
  "username": "MageOben",
  "bio": "potential wow player",
  "email": "oben2@gameinn.com",
  "toPlayList": [
    "639f97717fbbdb33987aeed9"
  ],
  "following": [
    "lalala"
  ],
  "followers": [
    "lalala"
  ],
  "favoriteGames": [
    "lallala"
  ],
  "logs": [
    {
      "createDate": "1458777600",
      "updateDate": "1458777600",
      "startDate": "1458777600",
      "stopDate": "1458777600",
      "gameId": "lllla",
      "finished": false
    }
  ],
  "profileImage": "jjjj"
} 
*/

  String? id;
  String? username;
  String? bio;
  String? email;
  List<String?>? toPlayList;
  List<String?>? following;
  List<String?>? followers;
  List<String?>? favoriteGames;
  List<UserModelLogs?>? logs;
  String? profileImage;

  UserModel({
    this.id,
    this.username,
    this.bio,
    this.email,
    this.toPlayList,
    this.following,
    this.followers,
    this.favoriteGames,
    this.logs,
    this.profileImage,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    username = json['username']?.toString();
    bio = json['bio']?.toString();
    email = json['email']?.toString();
    if (json['toPlayList'] != null) {
      final v = json['toPlayList'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      toPlayList = arr0;
    } else {
      final arr0 = <String>[];
      toPlayList = arr0;
    }
    if (json['following'] != null) {
      final v = json['following'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      following = arr0;
    } else {
      final arr0 = <String>[];
      following = arr0;
    }
    if (json['followers'] != null) {
      final v = json['followers'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      followers = arr0;
    } else {
      final arr0 = <String>[];
      followers = arr0;
    }
    if (json['favoriteGames'] != null) {
      final v = json['favoriteGames'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      favoriteGames = arr0;
    } else {
      final arr0 = <String>[];
      favoriteGames = arr0;
    }
    if (json['logs'] != null) {
      final v = json['logs'];
      final arr0 = <UserModelLogs>[];
      v.forEach((v) {
        arr0.add(UserModelLogs.fromJson(v));
      });
      logs = arr0;
    } else {
      final arr0 = <UserModelLogs>[];
      logs = arr0;
    }
    profileImage = json['profileImage']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['bio'] = bio;
    data['email'] = email;
    if (toPlayList != null) {
      final v = toPlayList;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['toPlayList'] = arr0;
    }
    if (following != null) {
      final v = following;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['following'] = arr0;
    }
    if (followers != null) {
      final v = followers;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['followers'] = arr0;
    }
    if (favoriteGames != null) {
      final v = favoriteGames;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['favoriteGames'] = arr0;
    }
    if (logs != null) {
      final v = logs;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['logs'] = arr0;
    }
    data['profileImage'] = profileImage;
    return data;
  }
}
