import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/pages/game_details.page.dart';
import 'package:gameinn/pages/profile_page.dart';
import 'package:gameinn/pages/settings_page.dart';
import 'package:gameinn/service/review_vote_service.dart';
import 'package:gameinn/service/search_service.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/game_model.dart';
import '../widgets/show_custom_loginerror_dialog.dart';

class FavoriteGameAddPage extends StatelessWidget {
  const FavoriteGameAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Search',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 23.0),
          ),
        ),
        body: SearchGameToAdd(),
      ),
    );
  }
}

class SearchGameToAdd extends StatefulWidget {
  SearchGameToAdd({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchGameToAddState();
}

class _SearchGameToAddState extends State<SearchGameToAdd> {
  final searchservice = SearchService();
  final userservice = UserService();

  List<GameModel?> games = [];
  String _userid = "";
  UserModel _user = UserModel(id: "");

  void updateList(String searched) {
    setState(() {
      searchservice.gameSearch(searched_name: searched).then((value) {
        if (value != null) {
          games = value;
        } else {}
      });
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

    setState(() {
      _userid = user.id!;
      _user = user;
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
            SizedBox(
              height: 50.0,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (value) => updateList(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFC4C4C4).withOpacity(0.35),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "eg: Last of Us",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
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
                              .split('-')
                              .first,
                        ),
                        leading: Image.memory(base64Decode((game?.cover)!)),
                        onTap: () async {
                          _user.favoriteGames?.add(game?.id);
                          UserModel? returnedUser = await userservice
                              .updateUser(user_to_update: _user);
                          if (returnedUser != null) {
                            Navigator.pop(context);
                          }
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
