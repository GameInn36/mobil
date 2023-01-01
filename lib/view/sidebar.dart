import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/pages/diary_page.dart';
import 'package:gameinn/pages/profile_page.dart';
import 'package:gameinn/pages/settings_page.dart';
import 'package:gameinn/pages/to_play_list_page.dart';
import 'package:gameinn/pages/user_reviews_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SidebarDrawerWidget extends StatefulWidget {
  SidebarDrawerWidget({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SidebarDrawerWidgetState();
}

class _SidebarDrawerWidgetState extends State<SidebarDrawerWidget> {
  String? _userid;
  UserModel? _user;
  bool loading = true;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

    setState(() {
      _userid = user.id!;
      _user = user;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final urlImage =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU";

    return loading ? const Center(child: CircularProgressIndicator(),) : Drawer(
      backgroundColor: const Color(0xFF1F1D36),
      width: MediaQuery.of(context).size.width * 0.65,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: <Widget>[
            const SizedBox(height: 30),
            buildHeader(
              urlImage: urlImage,
              name: _user!.username!,
              email: _user!.email!,
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: 'Diary',
              icon: Icons.calendar_today_outlined,
              onClicked: () => selectedItem(context, 1),
            ),
            buildMenuItem(
              text: 'To Play List',
              icon: Icons.sports_esports_outlined,
              onClicked: () => selectedItem(context, 2),
            ),
            buildMenuItem(
              text: 'Reviews',
              icon: Icons.menu_book_sharp,
              onClicked: () => selectedItem(context, 3),
            ),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              onClicked: () => selectedItem(context, 4),
            ),
            const SizedBox(
              height: 60,
            ),
            buildMenuItem(
              text: 'Sign out',
              icon: Icons.logout,
              color: const Color(0xFFAC32F6),
              opacity: 0.8,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: (_user?.profileImage) != null
                        ? Image.memory(base64Decode((_user?.profileImage)!)).image
                        : NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                          ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                    color: const Color(0xFFAC32F6).withOpacity(0.8),
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    Color color = Colors.white,
    double opacity = 0.5,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -3),
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: color.withOpacity(opacity),
      ),
      title: Text(
        text,
        style: TextStyle(color: color.withOpacity(opacity)),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfilePage(user_id: _userid!),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DiaryPage(
            user_id: _userid!,
          ),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ToPlayListPage(
            user_id: _userid!,
          ),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserReviewsPage(
            user_id: _userid!,
          ),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingsPage(),
        ));
        break;
    }
  }
}
