import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gameinn/model/game_with_reviews.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/pages/profile_page.dart';
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
  UserModel _user = UserModel(id: "");
  GameWithReviews gameR = GameWithReviews(game: GameModel(id: ""));
  final reviewVoteService = ReviewVoteService();

  List<ReviewLogModel> reviews = [];
  List<ReviewLogModel> mostPopularReviews = [];
  List<ReviewLogModel> friendsReviews = [];
  bool review_found = false;
  ReviewLogModel review = ReviewLogModel(id: "");
  int game_index = -1;
  bool loading = true;
  Map<String, bool> liked = {};

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
      loading = true;
      _userid = user.id!;
      _user = user;
    });
  }

  void getList() async {
    GameWithReviews _game =
        (await SearchService().gameFound(game_id: game_id))!;
    List<ReviewLogModel> _reviews = (await ReviewVoteService()
            .reviewLogGet(ctx: context, gameId: game_id) ??
        []);
    _reviews.sort((a, b) => b.likeCount!.compareTo(a.likeCount!));
    List<ReviewLogModel?> _friendsReviews = _game.followedFriendsReviews ?? [];

    if (_friendsReviews != []) {
      for (int i = 0; i < _friendsReviews.length; i++) {
        if (_friendsReviews[i]!.likedUsers != null) {
          if ((_friendsReviews[i]!.likedUsers)!.contains(_userid)) {
            liked[(_friendsReviews[i]!.id)!] = true; //if not already exist, add
          } else {
            liked[(_friendsReviews[i]!.id)!] = false;
          }
        }
      }
    }

    if (_reviews != []) {
      for (int i = 0; i < _reviews.length; i++) {
        if (_reviews[i].likedUsers != null) {
          if ((_reviews[i].likedUsers)!.contains(_userid)) {
            liked[(_reviews[i].id)!] = true; //if not already exist, add
          } else {
            liked[(_reviews[i].id)!] = false;
          }
        }
      }
    }

    mostPopularReviews = [];
    friendsReviews = [];

    setState(() {
      review_found = false;
      gameR = _game;
      log(gameR.game!.id!);
      reviews = _reviews;

      for (int i = 0; i < (_reviews.length <= 3 ? _reviews.length : 3); i++) {
        mostPopularReviews.add(_reviews[i]);
      }

      for (int i = 0;
          i < (_friendsReviews.length <= 3 ? _friendsReviews.length : 3);
          i++) {
        friendsReviews.add(_friendsReviews[i]!);
      }

      if (reviews.isNotEmpty) {
        review = reviews.firstWhere(
          (element) => element.user!.id! == _userid,
          orElse: () => ReviewLogModel(id: ""),
        );
        review_found = review.id == "" ? false : true;
      }

      if (_user.toPlayList != null) {
        game_index = _user.toPlayList!
            .indexWhere((element) => element == gameR.game!.id);
      }
      this.liked = liked;
      loading = false;
    });
  }

  FutureOr onGoBack(dynamic value) {
    getUser();
    getList();
  }

  void like(String review_id) async {
    setState(() {
      loading = true;
      reviewVoteService.likeReview(review_id: review_id).then((value) {
        if (value != null) {
          //set preferences daki user güncel değil, bu sayfa için gerekmeyebilir.
        } else {}
      });

      int review_index =
          friendsReviews.indexWhere((element) => element.id == review_id);

      if (review_index != -1) {
        friendsReviews[review_index].likeCount =
            friendsReviews[review_index].likeCount! + 1;
      }

      review_index =
          mostPopularReviews.indexWhere((element) => element.id == review_id);

      if (review_index != -1) {
        mostPopularReviews[review_index].likeCount =
            mostPopularReviews[review_index].likeCount! + 1;
      }

      getList();
    });
  }

  void dislike(String review_id) {
    setState(() {
      loading = true;
      reviewVoteService.dislikeReview(review_id: review_id).then((value) {
        if (value != null) {
          //set preferences daki user güncel değil, bu sayfa için gerekmeyebilir.
        } else {}
      });

      int review_index =
          friendsReviews.indexWhere((element) => element.id == review_id);

      if (review_index != -1) {
        friendsReviews[review_index].likeCount =
            friendsReviews[review_index].likeCount! - 1;
      }

      review_index =
          mostPopularReviews.indexWhere((element) => element.id == review_id);

      if (review_index != -1) {
        mostPopularReviews[review_index].likeCount =
            mostPopularReviews[review_index].likeCount! - 1;
      }

      getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                                  flex: 3,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      (gameR.game!.name ?? 'Unknown'),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      (gameR.game!.summary ?? ''),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
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
                                  UserModelLogs found_log = _user.logs!
                                      .firstWhere(
                                          (element) =>
                                              element!.gameId == gameR.game!.id,
                                          orElse: () =>
                                              UserModelLogs(gameId: ""))!;
                                  bool log_found = _user.logs != null
                                      ? (_user.logs != []
                                          ? (found_log.gameId == ""
                                              ? false
                                              : true)
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
                                              ))).then(onGoBack);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        (review_found ||
                                                (_user.logs != null
                                                    ? (_user.logs != []
                                                        ? (_user.logs!
                                                                    .firstWhere(
                                                                        (element) =>
                                                                            element!.gameId ==
                                                                            gameR
                                                                                .game!.id,
                                                                        orElse: () =>
                                                                            UserModelLogs(gameId: ""))!
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
                                                (_user.logs != null
                                                    ? (_user.logs != []
                                                        ? (_user.logs!
                                                                    .firstWhere(
                                                                        (element) =>
                                                                            element!.gameId ==
                                                                            gameR
                                                                                .game!.id,
                                                                        orElse: () =>
                                                                            UserModelLogs(gameId: ""))!
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
                                      if (_user.toPlayList != null) {
                                        _user.toPlayList!.add(gameR.game!.id);
                                      } else {
                                        _user.toPlayList = [gameR.game!.id];
                                      }
                                      setState(() {
                                        game_index = _user.toPlayList!
                                            .indexWhere((element) =>
                                                element == gameR.game!.id);
                                      });
                                    } else {
                                      _user.toPlayList!.remove(gameR.game!.id);
                                      setState(() {
                                        game_index = _user.toPlayList!
                                            .indexWhere((element) =>
                                                element == gameR.game!.id);
                                      });
                                    }
                                    UserService()
                                        .updateUser(user_to_update: _user);
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                (gameR.game!
                                                        .firstReleaseDate!) *
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
                    const SizedBox(
                      height: 30,
                    ),
                    mostPopularReviews.isEmpty
                        ? const SizedBox()
                        : const Text(
                            "Most Popular Reviews",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                    mostPopularReviews.isEmpty
                        ? const SizedBox()
                        : const SizedBox(
                            width: 250.0,
                            child: Divider(
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                    SizedBox(
                      height: 160 * (mostPopularReviews.length.toDouble()),
                      child: ListView.builder(
                          itemCount: mostPopularReviews != null
                              ? mostPopularReviews.length
                              : 0,
                          itemBuilder: (context, index) {
                            ReviewLogModel? review_log =
                                mostPopularReviews[index];
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(29.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 140.0,
                                    color: const Color(0xFFE9A6A6)
                                        .withOpacity(0.05),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: (review_log.user
                                                                ?.profileImage) !=
                                                            null
                                                        ? Image.memory(base64Decode(
                                                                (review_log.user
                                                                    ?.profileImage)!))
                                                            .image
                                                        : const NetworkImage(
                                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: const SizedBox(),
                                        ),
                                        Expanded(
                                          flex: 25,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          (gameR.game!.name ??
                                                              "None"),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Review by ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontSize:
                                                                      13.0),
                                                            ),
                                                            InkWell(
                                                              child: Text(
                                                                (review_log
                                                                    .user!
                                                                    .username)!,
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFFE9A6A6),
                                                                    fontSize:
                                                                        13.0),
                                                              ),
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ProfilePage(user_id: (_user.id)!)));
                                                              },
                                                            ),
                                                          ])),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          (review_log.context ??
                                                              "None"),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      13.5),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          icon: (liked[
                                                                  (review_log
                                                                      .id)])!
                                                              ? Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  size: 30.0,
                                                                  color: Colors
                                                                      .red)
                                                              : Icon(
                                                                  Icons
                                                                      .favorite_outline_outlined,
                                                                  size: 30.0,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                          onPressed: () {
                                                            setState(() {
                                                              loading = true;
                                                              if ((liked[(review_log
                                                                      .id)]) ==
                                                                  false) {
                                                                like((review_log
                                                                    .id)!);
                                                                liked[(review_log
                                                                        .id)!] =
                                                                    true;
                                                              } else {
                                                                dislike(
                                                                    (review_log
                                                                        .id)!);
                                                                liked[(review_log
                                                                        .id)!] =
                                                                    false;
                                                              }
                                                              loading = false;
                                                            });
                                                          },
                                                        ),
                                                        Text(
                                                          " ${review_log.likeCount}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.5)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    friendsReviews.isEmpty
                        ? const SizedBox()
                        : const Text(
                            "Friends' Reviews",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                    friendsReviews.isEmpty
                        ? const SizedBox()
                        : const SizedBox(
                            width: 250.0,
                            child: Divider(
                              thickness: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                    Column(
                      children: [
                        SizedBox(
                          height: 160 * (friendsReviews.length.toDouble()),
                          child: ListView.builder(
                              itemCount: friendsReviews != null
                                  ? friendsReviews.length
                                  : 0,
                              itemBuilder: (context, index) {
                                ReviewLogModel? review_log =
                                    friendsReviews[index];
                                return ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(29.0),
                                      topRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0)),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 140.0,
                                        color: const Color(0xFFE9A6A6)
                                            .withOpacity(0.05),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: AspectRatio(
                                                  aspectRatio: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: (review_log.user
                                                                    ?.profileImage) !=
                                                                null
                                                            ? Image.memory(base64Decode(
                                                                    (review_log
                                                                        .user
                                                                        ?.profileImage)!))
                                                                .image
                                                            : const NetworkImage(
                                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 1,
                                              child: const SizedBox(),
                                            ),
                                            Expanded(
                                              flex: 25,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              (gameR.game!
                                                                      .name ??
                                                                  "None"),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Review by ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.5),
                                                                      fontSize:
                                                                          13.0),
                                                                ),
                                                                InkWell(
                                                                  child: Text(
                                                                    (review_log
                                                                        .user!
                                                                        .username)!,
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xFFE9A6A6),
                                                                        fontSize:
                                                                            13.0),
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                ProfilePage(user_id: (_user.id)!)));
                                                                  },
                                                                ),
                                                              ])),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              (review_log
                                                                      .context ??
                                                                  "None"),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      13.5),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                              icon: (liked[
                                                                      (review_log
                                                                          .id)])!
                                                                  ? Icon(
                                                                      Icons
                                                                          .favorite,
                                                                      size:
                                                                          30.0,
                                                                      color: Colors
                                                                          .red)
                                                                  : Icon(
                                                                      Icons
                                                                          .favorite_outline_outlined,
                                                                      size:
                                                                          30.0,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  loading =
                                                                      true;
                                                                  if ((liked[(review_log
                                                                          .id)]) ==
                                                                      false) {
                                                                    like((review_log
                                                                        .id)!);
                                                                    liked[(review_log
                                                                            .id)!] =
                                                                        true;
                                                                  } else {
                                                                    dislike(
                                                                        (review_log
                                                                            .id)!);
                                                                    liked[(review_log
                                                                            .id)!] =
                                                                        false;
                                                                  }
                                                                  loading =
                                                                      false;
                                                                });
                                                              },
                                                            ),
                                                            Text(
                                                              " ${review_log.likeCount}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.5)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
