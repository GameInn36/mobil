import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/game_model.dart';

class GameDetailsPage extends StatelessWidget{

  late final GameModel game;

  GameDetailsPage(this.game);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((game.name)!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(base64Decode((game.cover)!)),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (game.summary)!,
                    //(game.summary)!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}