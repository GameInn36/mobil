import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<SignUpPage> createState() => _RegisterPageState();
}


class _RegisterPageState extends State<SignUpPage> {

  //text controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();


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
                Text(
                  'GameInn',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 250.0,
                  child: Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  'Sign Up',
                  style: TextStyle (
                    fontSize: 35.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'Create an account to continue.',
                  style: TextStyle (
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 35.0,
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
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            size: 15.0,
                            color: Colors.grey.shade200,
                          ),
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
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
                      child: TextField(
                        controller: _emailController,
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
                SizedBox(
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
                      child: TextField(
                        controller: _passwordController,
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
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 135.0),
                  child: GestureDetector(
                    //onTap:
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: Color(0xffE9A6A6),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
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
                  children:  [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Color(0xffE9A6A6),
                      ),
                    ),
                    Text(
                      'Go to the',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Color(0xffE9A6A6),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        ' Login Page.',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9C4A8B),
                        ),
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