///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ReviewModel {
/*
{
  "id": "63aacd95cbc72c30f62c1aa2",
  "userId": "63a80f5ac5ae0f7d5c83872a",
  "gameId": "63a82a825bafb01e2936254f",
  "duplicateCheckVariable": "63a80f5ac5ae0f7d5c83872a63a82a825bafb01e2936254f",
  "context": "dfghujkol",
  "vote": 1,
  "voted": true,
  "likeCount": 0,
  "createdAt": 1672138133,
  "updatedAt": 1672240302,
  "likedUsers": [
    "dfg"
  ]
} 
*/

  String? id;
  String? userId;
  String? gameId;
  String? duplicateCheckVariable;
  String? context;
  int? vote;
  bool? voted;
  int? likeCount;
  int? createdAt;
  int? updatedAt;
  List<String?>? likedUsers;

  ReviewModel({
    this.id,
    this.userId,
    this.gameId,
    this.duplicateCheckVariable,
    this.context,
    this.vote,
    this.voted,
    this.likeCount,
    this.createdAt,
    this.updatedAt,
    this.likedUsers,
  });
  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    userId = json['userId']?.toString();
    gameId = json['gameId']?.toString();
    duplicateCheckVariable = json['duplicateCheckVariable']?.toString();
    context = json['context']?.toString();
    vote = json['vote']?.toInt();
    voted = json['voted'];
    likeCount = json['likeCount']?.toInt();
    createdAt = json['createdAt']?.toInt();
    updatedAt = json['updatedAt']?.toInt();
  if (json['likedUsers'] != null) {
  final v = json['likedUsers'];
  final arr0 = <String>[];
  v.forEach((v) {
  arr0.add(v.toString());
  });
    likedUsers = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['gameId'] = gameId;
    data['duplicateCheckVariable'] = duplicateCheckVariable;
    data['context'] = context;
    data['vote'] = vote;
    data['voted'] = voted;
    data['likeCount'] = likeCount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (likedUsers != null) {
      final v = likedUsers;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v);
  });
      data['likedUsers'] = arr0;
    }
    return data;
  }
}
