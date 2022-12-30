import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gameinn/model/game_model.dart';
import 'package:gameinn/model/log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/pages/game_details.page.dart';
import 'package:gameinn/service/log_service.dart';
import 'package:gameinn/service/search_service.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayedListPage extends StatefulWidget {
  const PlayedListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayedListPageState();
}

class _PlayedListPageState extends State<PlayedListPage> {
  List<GameModel?> games = [];
  String _userid = "";
  UserModel _user = UserModel(id: "");

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

    List<GameModel> tempList = [];
    (await LogService().LogGet(userId: user.id!))!
        .where((element) => element.gameLog!.finished == true).forEach((element) {
          tempList.add(element.game!);
        });

    setState(() {
      _userid = user.id!;
      _user = user;
      games = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1F1D36),
        alignment: Alignment.center,
        child: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'Played Games',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.filter_alt,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                height: 60,
                child: Divider(
                  color: Colors.white.withOpacity(0.19),
                  thickness: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    GameModel? game = games[index];
                    return InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameDetailsPage(
                                      game_id: game.id!,
                                    )));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.memory(
                                base64Decode((game?.cover)!),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                (game!.name!),
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
