import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/pages/diary_page.dart';
import 'package:gameinn/pages/followers_page.dart';
import 'package:gameinn/pages/following_page.dart';
import 'package:gameinn/view/sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/user_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ProfilePage> {
  final userservice = UserService();
  late UserModel user;

  String name = " ";
  final urlImage =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU";

  @override
  void initState() {
    getUser();

    super.initState();
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

    setState(() {
      name = user.username.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1F1D36),
        alignment: Alignment.center,
        child: SafeArea(
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
                      image: NetworkImage(
                        urlImage,
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
                      height: 130,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: favoriteGames,
                      ),
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
                      height: 110,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: recentlyPlayedGames,
                      ),
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
                      MaterialPageRoute(builder: (context) => DiaryPage()));
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
                      MaterialPageRoute(builder: (context) => FollowersPage()));
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
                      MaterialPageRoute(builder: (context) => FollowingPage()));
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
              ),
              ListTile(
                leading: Text(
                  "To Play List",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> favoriteGames = <Widget>[
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
