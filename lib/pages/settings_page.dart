import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _userid = "";
  UserModel _user = UserModel(id: "");
  bool loading = true;
  String urlImage =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU";

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(
                    urlImage,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 27,
                  width: 27,
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white.withOpacity(0.5),
                      size: 21,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: Column(
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
            ),
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
    return Column(
      children: [
        ListTile(
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
        ),
        SizedBox(
          child: Divider(
            color: Colors.white.withOpacity(0.5),
            thickness: 0.8,
          ),
        )
      ],
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => ProfilePage(user_id: user_id),
        // ));
        break;
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => DiaryPage(user_id: user_id,),
        // ));
        break;
    }
  }

  Widget photoSellect() {
    return Container(
      height: 150,
      width: double.infinity,
    );
  }

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
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  buildHeader(
                    urlImage: urlImage,
                    name: _user.username!,
                    email: _user.email!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildMenuItem(
                    text: 'Change Password',
                    icon: Icons.key_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  buildMenuItem(
                    text: 'Add To Favorite Games',
                    icon: Icons.playlist_add,
                    onClicked: () => selectedItem(context, 1),
                  ),
                ],
              ),
            ),
          );
  }
}
