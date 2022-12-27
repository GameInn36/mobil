import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gameinn/service/user_service.dart';

import '../model/user_model.dart';
import 'game_details.page.dart';
import '../model/game_model.dart';
import 'package:gameinn/service/search_service.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Followers',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 23.0),
        ),
      ),
      body: ShowFollowersPage(),
    );
  }
}

class ShowFollowersPage extends StatefulWidget {
  ShowFollowersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowFollowersState();
}

class _ShowFollowersState extends State<ShowFollowersPage> {
  final searchservice = SearchService();
  final userservice = UserService();

  bool _isLoading = false;

  List<UserModel?> followers = [];
  late UserModel user;
  Map<String, bool> followed = {};
  List<String> user_followings = [];

  @override
  void initState() {
    super.initState();

    getList();
  }

  void getList() async {
    user = (await userservice.getAuthorizedUser())!;

    if (user.following != null) {
      for (int i = 0; i < (user.following)!.length; i++) {
        String user_id = user.following![i]!;
        if (!user_followings.contains(user_id)) {
          user_followings.add(user_id); //if not already exist, add
        }
      }
    }

    followers = (await userservice.getFollowers(user_id: user.id))!;

    for (var i = 0; i < followers.length; i++) {
      if (user_followings.contains(followers[i]?.id)) {
        followed[(followers[i]?.id)!] = true;
      } else {
        followed[(followers[i]?.id)!] = false;
      }
    }

    setState(() {
      this.user = user;
      this.followers = followers;
      this.user_followings = user_followings;
      this.followed = followed;
    });
  }

  void follow(String user_id) async {
    setState(() {
      userservice.followMember(user_id_to_follow: user_id);
    });
  }

  void unfollow(String user_id) async {
    setState(() {
      userservice.unfollowMember(user_id_to_unfollow: user_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: followers.length,
                  itemBuilder: (context, index) {
                    UserModel? follower = followers[index];
                    return Card(
                      color: const Color(0xFF1F1D36),
                      child: ListTile(
                          title: Text(
                            (follower?.username)!,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          leading: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: (follower?.profileImage) != null
                                    ? Image.memory(base64Decode(
                                            (follower?.profileImage)!))
                                        .image
                                    : NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                                      ),
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: ((followed[follower?.id])!)
                                ? Icon(Icons.check_circle_outline_outlined,
                                    size: 30.0, color: Colors.green)
                                : Icon(
                                    Icons.add_circle,
                                    size: 30.0,
                                    color: Colors.grey,
                                  ),
                            onPressed: () {
                              setState(() {
                                if ((followed[follower?.id]) == false) {
                                  follow((follower?.id)!);
                                  followed[(follower?.id)!] = true;
                                } else {
                                  unfollow((follower?.id)!);
                                  followed[(follower?.id)!] = false;
                                }
                              });
                            },
                          )),
                    );
                  }),
            ),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.;
  }
}
