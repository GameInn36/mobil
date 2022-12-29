import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/service/review_vote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game_details.page.dart';
import '../model/game_model.dart';
import 'package:gameinn/service/search_service.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key}) : super(key: key);

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
      body: ShowDiaryPage(),
    );
  }
}

class ShowDiaryPage extends StatefulWidget {
  ShowDiaryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowDiaryState();
}

class _ShowDiaryState extends State<ShowDiaryPage> {
  final searchservice = SearchService();

  List<GameModel?> games = [];
  String _userid = "";
  UserModel _user = UserModel(id: "");

  @override
  void initState() {
    getUser();
    super.initState();

    getList();
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

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
      });
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
                          bool review_found = false;
                          ReviewLogModel review = ReviewLogModel(id: "");
                          List<ReviewLogModel>? reviews =
                              await ReviewVoteService().reviewLogGet(
                                  ctx: context, gameId: game!.id!);
                          if (reviews != null) {
                            review = reviews.firstWhere(
                              (element) => element.user!.id! == _userid,
                              orElse: () => ReviewLogModel(id: ""),
                            );
                            review_found = review.id == "" ? false : true;
                          }

                          int game_index = -1;
                          if (_user.toPlayList != null) {
                            game_index = _user.toPlayList!
                                .indexWhere((element) => element == game.id);
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameDetailsPage(
                                      game: game,
                                      reviews: reviews != null ? reviews : [],
                                      review_found: review_found,
                                      review: review,
                                      game_index: game_index)));
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
