import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/service/review_vote_service.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game_details.page.dart';
import '../model/game_model.dart';
import 'package:gameinn/service/search_service.dart';

class DiaryPage extends StatelessWidget {
  final String user_id;
  const DiaryPage({Key? key, required this.user_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Diary',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 23.0),
        ),
      ),
      body: ShowDiaryPage(user_id: user_id,),
    );
  }
}

class ShowDiaryPage extends StatefulWidget {
  final String user_id;
  ShowDiaryPage({Key? key, required this.user_id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowDiaryState(user_id);
}

class _ShowDiaryState extends State<ShowDiaryPage> {
  late final user_id;
  _ShowDiaryState(this.user_id);
  
  final searchservice = SearchService();

  List<GameModel?> games = [];
  String _userid = "";
  UserModel _user = UserModel(id: "");
  bool loading = true;

  @override
  void initState() {
    getUser();
    super.initState();

    getList();
  }

  void getUser() async {
    UserModel user = (await UserService().getUser(user_id: user_id))!;

    setState(() {
      _userid = user.id!;
      _user = user;
    });
  }

  void getList() {
    List<GameModel> tempList = [];
    searchservice.gameSearch(searched_name: "d").then((value) {
      if (value != null) {
        tempList = value;
      }

      setState(() {
        games = tempList;
      loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Center(child: CircularProgressIndicator(),) : Scaffold(
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
                      color: const Color(0xFFC4C4C4).withOpacity(0.35),
                      child: ListTile(
                        title: Text(
                          (game?.name)!,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  (game?.firstReleaseDate)! * 1000)
                              .toString()
                              .split(' ')
                              .first,
                        ),
                        leading: Image.memory(base64Decode((game?.cover)!)),
                        trailing: Icon(Icons.arrow_forward_rounded),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameDetailsPage(
                                        game_id: game!.id!,
                                      )));
                        },
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
