import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/pages/change_password_page.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

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
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: (_user.profileImage) != null
                              ? Image.memory(
                                      base64Decode((_user.profileImage)!))
                                  .image
                              : NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                                ),
                        ),
                      ),
                    ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.5,
            ),
            child: IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.camera_alt,
                color: Colors.white.withOpacity(0.5),
                size: 21,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => photoSellect()),
                );
              },
            ),
          ),
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
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PasswordPage(),
        ));
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Sellect Your Profile Picture',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    'Gallery',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      pickImage();
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                children: [
                  const Text(
                    'Camera',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera),
                    onPressed: () {
                      takePhoto();
                    },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File imageFile = File(image.path);
    Uint8List imagebytes = await imageFile.readAsBytes(); //convert to bytes
    String base64string = base64.encode(imagebytes);
    _user.profileImage = base64string;

    UserModel? returned_user =
        await UserService().updateUser(user_to_update: _user);

    if (returned_user != null) {
      Navigator.pop(context);
      getUser();
    }
  }

  Future takePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    File imageFile = File(image.path);
    Uint8List imagebytes = await imageFile.readAsBytes(); //convert to bytes
    String base64string = base64.encode(imagebytes);
    _user.profileImage = base64string;

    UserModel? returned_user =
        await UserService().updateUser(user_to_update: _user);

    if (returned_user != null) {
      Navigator.pop(context);
      getUser();
    }
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
      loading = true;
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
