import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gameinn/model/game_with_reviews.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/service/review_vote_service.dart';
import 'package:gameinn/service/search_service.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/game_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gameinn/pages/log_page.dart';

class GameDetailsPage extends StatefulWidget {
  final String game_id;
  GameDetailsPage({super.key, required this.game_id});

  @override
  State<StatefulWidget> createState() => _GameDetailsPageState(game_id);
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  late final String game_id;
  _GameDetailsPageState(this.game_id);

  String _userid = "";
  UserModel user = UserModel(id: "");
  GameWithReviews gameR = GameWithReviews(game: GameModel(id: ""));

  List<ReviewLogModel> reviews = [];
  bool review_found = false;
  ReviewLogModel review = ReviewLogModel(id: "");
  int game_index = -1;

  @override
  void initState() {
    getUser();
    super.initState();
    getList();
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

    setState(() {
      _userid = user.id!;
    });
  }

  void getList() async {
    GameWithReviews _game =
        (await SearchService().gameFound(game_id: game_id))!;
    List<ReviewLogModel> _reviews =
        await ReviewVoteService().reviewLogGet(ctx: context, gameId: game_id) ??
            [];

    setState(() {
      gameR = _game;
      reviews = _reviews;
      if (reviews != null) {
        review = reviews.firstWhere(
          (element) => element.user!.id! == _userid,
          orElse: () => ReviewLogModel(id: ""),
        );
        review_found = review.id == "" ? false : true;
      }

      if (user.toPlayList != null) {
        game_index =
            user.toPlayList!.indexWhere((element) => element == gameR.game!.id);
      }
    });
  }

  FutureOr onGoBack(dynamic value) {
    GameWithReviews _game = GameWithReviews();
    SearchService()
        .gameFound(game_id: game_id)
        .then((value) => {_game = value!});
    List<ReviewLogModel> _reviews = [];
    ReviewVoteService()
        .reviewLogGet(ctx: context, gameId: game_id)
        .then((value) => _reviews = value!);

    setState(() {
      gameR = _game;
      reviews = _reviews;
      if (reviews != null) {
        review = reviews.firstWhere(
          (element) => element.user!.id! == _userid,
          orElse: () => ReviewLogModel(id: ""),
        );
        review_found = review.id == "" ? false : true;
      }

      if (user.toPlayList != null) {
        game_index =
            user.toPlayList!.indexWhere((element) => element == gameR.game!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                margin: EdgeInsets.only(top: 35, bottom: 20),
                height: 170,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 10,
                      child: Container(
                        height: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9.0),
                          child: gameR.game!.cover != null
                              ? Image.memory(
                                  base64Decode((gameR.game!.cover)!),
                                  fit: BoxFit.fill,
                                )
                              : SizedBox(),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              (gameR.game!.name ?? 'Unknown'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                (gameR.game!.summary ?? ''),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.sports_esports_outlined,
                        color: Colors.green,
                        size: 27,
                      ),
                      Text(
                        (gameR.game!.voteCount.toString()),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      const Icon(
                        Icons.menu_book_sharp,
                        color: Colors.blue,
                        size: 25,
                      ),
                      Text(
                        (gameR.game!.voteCount.toString()),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            child: GestureDetector(
                          onTap: () {
                            UserModelLogs found_log = user.logs!.firstWhere(
                                (element) => element!.gameId == gameR.game!.id,
                                orElse: () => UserModelLogs(gameId: ""))!;
                            bool log_found = user.logs != null
                                ? (user.logs != []
                                    ? (found_log.gameId == "" ? false : true)
                                    : false)
                                : false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogPage(
                                          game: gameR.game!,
                                          review_logged: review_found,
                                          review: review,
                                          log_found: log_found,
                                          found_log: found_log,
                                        ))).then((value) => {getList()});
                          },
                          child: Container(
                            height: 35,
                            width: 210,
                            decoration: const BoxDecoration(
                              color: Color(0xffE9A6A6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  (review_found ||
                                          (user.logs != null
                                              ? (user.logs != []
                                                  ? (user.logs!
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element!
                                                                          .gameId ==
                                                                      gameR
                                                                          .game!
                                                                          .id,
                                                                  orElse: () =>
                                                                      UserModelLogs(
                                                                          gameId:
                                                                              ""))!
                                                              .gameId ==
                                                          ""
                                                      ? false
                                                      : true)
                                                  : false)
                                              : false))
                                      ? Icons.edit_outlined
                                      : Icons.library_add_outlined,
                                  color: Color(0xFF1F1D36),
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  (review_found ||
                                          (user.logs != null
                                              ? (user.logs != []
                                                  ? (user.logs!
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element!
                                                                          .gameId ==
                                                                      gameR
                                                                          .game!
                                                                          .id,
                                                                  orElse: () =>
                                                                      UserModelLogs(
                                                                          gameId:
                                                                              ""))!
                                                              .gameId ==
                                                          ""
                                                      ? false
                                                      : true)
                                                  : false)
                                              : false))
                                      ? 'Edit Log or Review'
                                      : 'Log or Review',
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1F1D36)),
                                ),
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          child: GestureDetector(
                            onTap: () async {
                              if (game_index == -1) {
                                if (user.toPlayList != null) {
                                  user.toPlayList!.add(gameR.game!.id);
                                } else {
                                  user.toPlayList = [gameR.game!.id];
                                }
                                setState(() {
                                  game_index = user.toPlayList!.indexWhere(
                                      (element) => element == gameR.game!.id);
                                });
                              } else {
                                user.toPlayList!.remove(gameR.game!.id);
                                setState(() {
                                  game_index = user.toPlayList!.indexWhere(
                                      (element) => element == gameR.game!.id);
                                });
                              }
                              UserService().updateUser(user_to_update: user);
                            },
                            child: Container(
                              height: 35,
                              width: 210,
                              decoration: BoxDecoration(
                                color: game_index == -1
                                    ? const Color(0xffE9A6A6)
                                    : Color.fromARGB(255, 209, 44, 44),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    game_index == -1
                                        ? Icons.playlist_add
                                        : Icons.playlist_remove,
                                    color: Color(0xFF1F1D36),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    game_index == -1
                                        ? 'Add To Play List'
                                        : 'Remove From Play List',
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1F1D36)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Text(
                          (gameR.game!.vote.toString()),
                          style: const TextStyle(
                            fontSize: 35,
                            color: Color(0xFFE9A6A6),
                          ),
                        ),
                        RatingBar.builder(
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color(0xFFEC2626),
                          ),
                          onRatingUpdate: (rating) {},
                          direction: Axis.horizontal,
                          minRating: 0,
                          initialRating: (gameR.game!.vote) ?? 0,
                          itemCount: 5,
                          allowHalfRating: true,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0),
                          itemSize: 20,
                          ignoreGestures: true,
                          unratedColor: Colors.grey.shade800,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Text(
                            'Release Date',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Center(
                            child: Text(
                              (gameR.game!.firstReleaseDate != null &&
                                      gameR.game!.firstReleaseDate != 0)
                                  ? DateTime.fromMillisecondsSinceEpoch(
                                          (gameR.game!.firstReleaseDate!) *
                                              1000)
                                      .toString()
                                      .split(' ')
                                      .first
                                  : 'Unknown',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                      width: 30,
                      child: VerticalDivider(
                        thickness: 1.5,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Text(
                            'Platforms',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Center(
                            child: Text(
                              (gameR.game!.platforms != null &&
                                      gameR.game!.platforms!.length != 0)
                                  ? (gameR.game!.platforms!.join(', '))
                                  : 'Unknown',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                      width: 30,
                      child: VerticalDivider(
                        thickness: 1.5,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Text(
                            'Studio',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Center(
                            child: Text(
                              (gameR.game!.publisher ?? 'Unknown'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                      width: 30,
                      child: VerticalDivider(
                        thickness: 1.5,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Text(
                            'Genres',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Center(
                            child: Text(
                              (gameR.game!.genres != null &&
                                      gameR.game!.genres!.length != 0)
                                  ? (gameR.game!.genres!.join(', '))
                                  : 'Unknown',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
