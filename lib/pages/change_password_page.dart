import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  UserModel _user = UserModel(id: "");
  bool loading = true;
  TextEditingController _oldPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _newPasswordAgain = TextEditingController();


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
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                      width: 150,
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3D3B54),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        obscureText: true,
                        controller: _oldPassword,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Old Password',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3D3B54),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        obscureText: true,
                        controller: _newPassword,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'New Password',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3D3B54),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        obscureText: true,
                        controller: _newPasswordAgain,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'New Password',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 35,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Color(0xffE9A6A6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1F1D36)),
                                ),
                              ),
                            ),
                            onTap: () async {
                              if(_newPassword.text != "" && _newPassword.text == _newPasswordAgain.text){
                                UserModel? returned_user = await UserService()
                                  .changePassword(user_id: _user.id!, password: _newPassword.text);

                                if (returned_user != null) {
                                  Navigator.pop(context);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
