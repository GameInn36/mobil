import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gameinn/model/log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/pages/diary_page.dart';
import 'package:gameinn/pages/followers_page.dart';
import 'package:gameinn/pages/following_page.dart';
import 'package:gameinn/pages/played_list_page.dart';
import 'package:gameinn/pages/to_play_list_page.dart';
import 'package:gameinn/pages/user_reviews_page.dart';
import 'package:gameinn/view/sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/game_model.dart';
import '../model/review_log_model.dart';
import '../service/review_vote_service.dart';
import '../service/user_service.dart';
import 'game_details.page.dart';

class ProfilePage extends StatefulWidget {
  final String user_id;
  ProfilePage({super.key, required this.user_id});

  @override
  State<StatefulWidget> createState() => _ShowProfileState(user_id);
}

class _ShowProfileState extends State<ProfilePage> {
  late String user_id;
  _ShowProfileState(this.user_id);
  final userservice = UserService();
  late UserModel user;
  bool following = false;
  bool loading = true;

  String name = " ";
  List<GameModel?> favoriteGames = [];
  List<LogModel?> logs = [];

  late UserModel authorizedUser = UserModel();

  final urlImage =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU";

  @override
  void initState() {
    getUserDetails();

    super.initState();
  }

  void getUserDetails() async {
    user = (await userservice.getUser(user_id: user_id))!;

    authorizedUser = (await userservice.getAuthorizedUser())!;

    favoriteGames = (await userservice.getFavoriteGames(user_id: user.id))!;

    logs = (await userservice.getUserLogs(user_id: (user.id)!))!;

    logs.sort(((a, b) =>
        a!.gameLog!.createDate!.compareTo((b!.gameLog!.createDate)!)));

    if (authorizedUser.following!.contains(user_id)) {
      following = true;
    } else {
      following = false;
    }

    setState(() {
      this.user = user;
      this.authorizedUser = authorizedUser;
      this.name = user.username.toString();
      this.favoriteGames = favoriteGames;
      this.following = following;
      this.logs = logs;
      loading = false;
    });
  }

  void follow(String user_id) {
    setState(() {
      loading = true;
      userservice.followMember(user_id_to_follow: user_id).then((value) {
        if (value != null) {
          //set preferences daki user güncel değil, bu sayfa için gerekmeyebilir.
        } else {}
      });
      loading = false;
    });
  }

  void unfollow(String user_id) {
    setState(() {
      loading = true;
      userservice.unfollowMember(user_id_to_unfollow: user_id).then((value) {
        if (value != null) {
          //set preferences daki user güncel değil, bu sayfa için gerekmeyebilir.
        } else {}
      });
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Center(child: CircularProgressIndicator(),) :Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 35,
              ),
              Container(
                alignment: Alignment.center,
                height: 90,
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: (user.profileImage) != null
                        ? Image.memory(base64Decode((user.profileImage)!)).image
                        : const NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              user_id != authorizedUser.id ? const SizedBox(
                height: 10,
              ) : const SizedBox(),
              user_id != authorizedUser.id ? 
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50.0),
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: GestureDetector(
                      child: Center(
                        child: Text(
                          (following ? 'Unfollow' : 'Follow'),
                          style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          loading = true;
                          if (following == false) {
                            follow((user_id));
                            following = true;
                          } else {
                            unfollow(user_id);
                            following = false;
                          }
                          loading = false;
                        });
                      },
                    ),
                  ),
                ],
              ) : const SizedBox(height: 10,),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 13),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 100.0,
                    color: const Color(0xFFE9A6A6).withOpacity(0.05),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Favorites',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 170.0,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 0.0),
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              favoriteGames.length, //buradan games gelmeli
                          itemBuilder: (context, index) {
                            GameModel? game = favoriteGames[index];
                            return InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameDetailsPage(
                                              game_id: game!.id!,
                                            )));
                              },
                              child: SizedBox(
                                height: 140.0,
                                width: 100.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image.memory(
                                      base64Decode((game?.cover)!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Divider(
                  color: Colors.white.withOpacity(0.19),
                  thickness: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recently Played',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 170.0,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 0.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: logs.length, //buradan games gelmeli
                          itemBuilder: (context, index) {
                            GameModel? game = logs[index]!.game;
                            return InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameDetailsPage(
                                              game_id: game!.id!,
                                            )));
                              },
                              child: SizedBox(
                                height: 140.0,
                                width: 100.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image.memory(
                                      base64Decode((game?.cover)!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Divider(
                  color: Colors.white.withOpacity(0.19),
                  thickness: 1.2,
                ),
              ),
              ListTile(
                leading: Text(
                  "Played Games",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
                onTap: (() => {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlayedListPage(user_id: user_id,),
                      )),
                    }),
              ),
              ListTile(
                leading: Text(
                  "Diary",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DiaryPage(user_id: user_id,)));
                },
              ),
              ListTile(
                leading: Text(
                  "Followers",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FollowersPage(user_id: user_id,)));
                },
              ),
              ListTile(
                leading: Text(
                  "Following",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FollowingPage(user_id: user_id,)));
                },
              ),
              ListTile(
                leading: Text(
                  "Reviews",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserReviewsPage(
                                user_id: user_id,
                              )));
                },
              ),
              ListTile(
                leading: Text(
                  "To Play List",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ToPlayListPage(
                                user_id: user_id,
                              )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> favoriteGames2 = <Widget>[
  SizedBox(
    width: 95.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    width: 95.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    width: 95.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    width: 95.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
];

List<Widget> recentlyPlayedGames = <Widget>[
  SizedBox(
    width: 80.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    width: 80.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    width: 80.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    width: 80.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    width: 80.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
];
