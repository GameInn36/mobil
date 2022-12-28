///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GameModel {
/*
{
  "id": "639f851add21996db197cb73",
  "name": "World of Warcraft",
  "cover": null,
  "summary": "Best MMORPG Game ever",
  "genres": [
    "MMORPG"
  ],
  "publisher": "Blizzard Entertainment",
  "platforms": [
    "ps3"
  ],
  "vote": 0,
  "voteCount": 0,
  "first_release_date": 0
}
*/

  String? id;
  String? name;
  String? cover;
  String? summary;
  List<String?>? genres;
  String? publisher;
  List<String?>? platforms;
  double? vote;
  int? voteCount;
  int? firstReleaseDate;

  GameModel({
    this.id,
    this.name,
    this.cover,
    this.summary,
    this.genres,
    this.publisher,
    this.platforms,
    this.vote,
    this.voteCount,
    this.firstReleaseDate,
  });
  GameModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    cover = json['cover']?.toString();
    summary = json['summary']?.toString();
    if (json['genres'] != null) {
      final v = json['genres'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      genres = arr0;
    }
    publisher = json['publisher']?.toString();
    if (json['platforms'] != null) {
      final v = json['platforms'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      platforms = arr0;
    }
    vote = json['vote']?.toDouble();
    voteCount = json['voteCount']?.toInt();
    firstReleaseDate = json['first_release_date']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['summary'] = summary;
    if (genres != null) {
      final v = genres;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['genres'] = arr0;
    }
    data['publisher'] = publisher;
    if (platforms != null) {
      final v = platforms;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['platforms'] = arr0;
    }
    data['vote'] = vote;
    data['voteCount'] = voteCount;
    data['first_release_date'] = firstReleaseDate;
    return data;
  }
}
