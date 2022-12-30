import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gameinn/components/navigator_key.dart';
import 'package:gameinn/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gameinn/model/user_model.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const LoginPage({Key? key, required this.showSignUpPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  final loginservice = AutherizationService();
  List<String> followers = [];
  List<String> following = [];
  List<String> to = [];

  void fetch() {
    loginservice
        .loginCall(
            ctx: navigatorKey.currentContext!,
            email: _email.text,
            password: _password.text)
        .then((value) async {
      if (value != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', '${value.jwtToken}');
        String a = jsonEncode((value.user)!.toJson());
        prefs.setString('user', a);
        log("user id: ${value.user!.id!}");
        log("token: ${value.jwtToken}");

        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D36),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'GameInn',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 250.0,
                  child: Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 35.0,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'Please sign in to continue.',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 15.0,
                            color: Colors.grey.shade200,
                          ),
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: 15.0,
                            color: Colors.grey.shade200,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 10, color: Color(0xffE9A6A6)),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 135.0),
                  child: GestureDetector(
                    onTap: () => fetch(),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: Color(0xffE9A6A6),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'Don\'t have an account? Please ',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Color(0xffE9A6A6),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showSignUpPage,
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9C4A8B),
                        ),
                      ),
                    ),
                    const Text(
                      ' first.',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Color(0xffE9A6A6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
