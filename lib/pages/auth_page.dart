import 'package:gameinn/pages/login_page.dart';
import 'sign_up_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially, show login page
  bool showLoginPage = true;

  void toggleScreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return LoginPage(showSignUpPage:toggleScreens);
    }
    else {
      return SignUpPage(showLoginPage: toggleScreens);
    }
  }
}
