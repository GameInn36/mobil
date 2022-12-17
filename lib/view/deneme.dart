import 'package:flutter/material.dart';

class Deneme extends StatefulWidget {
  const Deneme({Key? key}) : super(key: key);

  @override
  State<Deneme> createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Anasayfa",
          style: TextStyle(),
        ),
      ),
    );
  }
}
