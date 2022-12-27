import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'game_details.page.dart';
import '../model/game_model.dart';
import 'package:gameinn/service/search_service.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Followers',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 23.0),
        ),
      ),
      body: ShowFollowersPage(),
    );
  }
}

class ShowFollowersPage extends StatefulWidget {
  ShowFollowersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowFollowersState();
}

class _ShowFollowersState extends State<ShowFollowersPage> {
  final searchservice = SearchService();

  List<GameModel?> games = [];
  List<bool?> selected = [];

  @override
  void initState() {
    super.initState();

    getList();
  }

  void getList() {
    List<GameModel> tempList = [];
    searchservice.gameSearch(searched_name: "d").then((value) {
      if (value != null) {
        tempList = value;

        for (var i = 0; i < value.length; i++) {
          selected.add(false);
        }

        setState(() {
          games = tempList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    GameModel? game = games[index];
                    return Card(
                      color: const Color(0xFF1F1D36),
                      child: ListTile(
                        title: Text(
                          (game?.name)!,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        leading: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: Image.memory(base64Decode((game?.cover)!))
                                  .image,
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: (selected.elementAt(index))!
                              ? Icon(Icons.check_circle_outline_outlined,
                                  size: 30.0, color: Colors.green)
                              : Icon(
                                  Icons.add_circle,
                                  size: 30.0,
                                  color: Colors.grey,
                                ),
                          onPressed: () {
                            setState(() {
                              selected[index] = !(selected.elementAt(index))!;
                            });
                          },
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.;
  }
}
