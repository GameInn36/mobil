import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/service/review_vote_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/game_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gameinn/pages/log_page.dart';

class GameDetailsPage extends StatefulWidget {
  final GameModel game;
  final List<ReviewLogModel> reviews;
  final ReviewLogModel review;
  final bool review_found;
  GameDetailsPage(
      {super.key,
      required this.game,
      required this.reviews,
      required this.review_found,
      required this.review});

  @override
  State<StatefulWidget> createState() =>
      _GameDetailsPageState(game, reviews, review_found, review);
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  late final GameModel game;
  late final List<ReviewLogModel> reviews;
  late final bool review_found;
  late final ReviewLogModel review;
  _GameDetailsPageState(
      this.game, this.reviews, this.review_found, this.review);
  String _userid = "";

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
                          child: Image.memory(
                            base64Decode((game.cover) ?? ''),
                            fit: BoxFit.fill,
                          ),
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
                              (game.name ?? 'Unknown'),
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
                                (game.summary ?? ''),
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
                        (game.voteCount.toString()),
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
                        (game.voteCount.toString()),
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
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogPage(
                                        game: game,
                                        review_logged: review_found,
                                        review: review)))
                          },
                          child: Container(
                            height: 35,
                            width: 150,
                            decoration: const BoxDecoration(
                              color: Color(0xffE9A6A6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.library_add_outlined,
                                  color: Color(0xFF1F1D36),
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  review_found
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
                            onTap: () => {},
                            child: Container(
                              height: 35,
                              width: 150,
                              decoration: const BoxDecoration(
                                color: Color(0xffE9A6A6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.playlist_add,
                                    color: Color(0xFF1F1D36),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Add To Play List',
                                    style: TextStyle(
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
                          (game.vote.toString()),
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
                          initialRating: (game.vote!),
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
                              (game.firstReleaseDate != null &&
                                      game.firstReleaseDate != 0)
                                  ? DateTime.fromMillisecondsSinceEpoch(
                                          (game.firstReleaseDate!) * 1000)
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
                              (game.platforms != null &&
                                      game.platforms!.length != 0)
                                  ? (game.platforms!.join(', '))
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
                              (game.publisher ?? 'Unknown'),
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
                              (game.genres != null && game.genres!.length != 0)
                                  ? (game.genres!.join(', '))
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
