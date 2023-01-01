import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gameinn/model/display_games_model.dart';
import 'package:gameinn/model/display_reviews_model.dart';
import 'package:gameinn/model/review_model.dart';
import 'package:gameinn/pages/followers_page.dart';
import 'package:gameinn/pages/game_details.page.dart';
import 'package:gameinn/model/game_model.dart';
import 'package:gameinn/pages/profile_page.dart';
import 'package:gameinn/pages/search_page.dart';
import 'package:gameinn/service/game_service.dart';
import 'package:gameinn/service/review_vote_service.dart';
import 'package:gameinn/service/search_service.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:gameinn/view/sidebar.dart';
import 'package:gameinn/pages/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/navigator_key.dart';
import 'model/review_log_model.dart';
import 'model/review_with_game_model.dart';
import 'model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameInn',
      routes: {
        '/': (context) => AuthPage(),
        '/home': (context) => MyHomePage(title: "GameInn"),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1F1D36),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFC4C4C4).withOpacity(0.35),
        ),
      ),
      navigatorKey: navigatorKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _username = "";
  String user_id = "";
  String _user_email = "";
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

    setState(() {
      _username = user.username.toString();
      _user_email = user.email.toString();
      user_id = user.id.toString();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              drawer: SidebarDrawerWidget(),
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  widget.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 23.0),
                ),
                bottom: const TabBar(
                  tabs: [Tab(text: 'Games'), Tab(text: 'Reviews')],
                  indicatorColor: Color(0xFFAC32F6),
                  indicatorWeight: 3.0,
                  labelStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: [
                  // Navigate to the Search Screen
                  IconButton(
                      padding: EdgeInsets.only(right: 10.0),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const SearchPage())),
                      icon: const Icon(Icons.search))
                ],
              ),
              body: const TabBarView(
                children: [HomeGames(), HomeReviews()],
              ),
            ),
          );
  }
}

class HomeGames extends StatefulWidget {
  const HomeGames({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DisplayGamesState();
}

class _DisplayGamesState extends State<HomeGames> {
  final searchservice = SearchService();
  final gameservice = GameService();

  List<GameModel?> games = [];
  String _userid = "";
  UserModel _user = UserModel(id: "");
  DisplayGamesModel? displayGames = DisplayGamesModel();
  bool loading = true;

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

  void getList() async {
    //List<GameModel> tempList = [];
    displayGames = await gameservice.displayGamesPage();

    //searchservice.gameSearch(searched_name: "d").then((value) {
    //if (value != null) {
    //tempList = value;
    //}

    setState(() {
      this.displayGames = displayGames;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: ListView(scrollDirection: Axis.vertical, children: [
          Container(
            margin: const EdgeInsets.only(
              top: 50.0,
              left: 13,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'New From Friends',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 170.0,
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 0.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: displayGames?.newsFromFriends?.length,
                          itemBuilder: (context, index) {
                            GameModel? game =
                                displayGames?.newsFromFriends?[index]!.game;
                            return InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameDetailsPage(
                                              game_id: (game?.id)!,
                                            )));
                              },
                              child: SizedBox(
                                height: 140.0,
                                width: 100.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: game?.cover != null
                                        ? Image.memory(
                                            base64Decode((game?.cover)!),
                                            fit: BoxFit.fill,
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                              ),
                            );
                          }),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 25.0,
              left: 13,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Popular Games',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 170.0,
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 0.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: displayGames?.mostPopularGames
                              ?.length, //buradan games gelmeli
                          itemBuilder: (context, index) {
                            GameModel? game =
                                displayGames?.mostPopularGames?[index];
                            return InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameDetailsPage(
                                              game_id: (game?.id)!,
                                            )));
                              },
                              child: SizedBox(
                                height: 140.0,
                                width: 100.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: game?.cover != null
                                        ? Image.memory(
                                            base64Decode((game?.cover)!),
                                            fit: BoxFit.fill,
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                              ),
                            );
                          }),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 25.0,
              left: 13,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'New Games',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 170.0,
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 0.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: displayGames
                              ?.newGames?.length, //buradan games gelmeli
                          itemBuilder: (context, index) {
                            GameModel? game = displayGames?.newGames?[index];
                            return InkWell(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameDetailsPage(
                                              game_id: (game?.id)!,
                                            )));
                              },
                              child: SizedBox(
                                height: 140.0,
                                width: 100.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: game?.cover != null
                                        ? Image.memory(
                                            base64Decode((game?.cover)!),
                                            fit: BoxFit.fill,
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                              ),
                            );
                          }),
                ),
              ],
            ),
          ),
        ]),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.;
  }
}

class HomeReviews extends StatefulWidget {
  const HomeReviews({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DisplayReviewsState();
}

class _DisplayReviewsState extends State<HomeReviews> {
  late UserModel user;
  late UserModel authorizedUser;
  final reviewVoteService = ReviewVoteService();
  final userservice = UserService();
  bool loading = true;

  List<ReviewWithGame?> userReviews = [];

  DisplayReviewsModel? displayReviews = DisplayReviewsModel();

  List<ReviewsTabReviewModel?> friendReviews = [];
  List<ReviewsTabReviewModel?> mostPopularReviews = [];

  Map<String, bool> liked = {};

  String username = "";

  String user_id = "";

  @override
  void initState() {
    super.initState();

    getList();
  }

  void getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

    displayReviews = await reviewVoteService.displayReviewsTab();

    friendReviews = (displayReviews?.friendReviews) ?? [];
    mostPopularReviews = (displayReviews?.mostPopularReviews) ?? [];

    if (friendReviews != []) {
      for (int i = 0; i < friendReviews.length; i++) {
        if ((friendReviews[i]?.review?.likedUsers)!.contains(user.id)) {
          liked[(friendReviews[i]?.review?.id)!] =
              true; //if not already exist, add
        } else {
          liked[(friendReviews[i]?.review?.id)!] = false;
        }
      }
    }

    if (mostPopularReviews != []) {
      for (int i = 0; i < mostPopularReviews.length; i++) {
        if ((mostPopularReviews[i]?.review?.likedUsers)!.contains(user.id)) {
          liked[(mostPopularReviews[i]?.review?.id)!] =
              true; //if not already exist, add
        } else {
          liked[(mostPopularReviews[i]?.review?.id)!] = false;
        }
      }
    }

    setState(() {
      this.user = user;
      this.displayReviews = displayReviews;
      this.friendReviews = friendReviews;
      this.mostPopularReviews = mostPopularReviews;
      this.liked = liked;
      loading = false;
    });
  }

  void like(String review_id) async {
    setState(() {
      loading = true;
      reviewVoteService.likeReview(review_id: review_id).then((value) {
        if (value != null) {
          //set preferences daki user güncel değil, bu sayfa için gerekmeyebilir.
        } else {}
      });

      int review_index = friendReviews
          .indexWhere((element) => element!.review!.id == review_id);

      if (review_index != -1) {
        friendReviews[review_index]!.review!.likeCount =
            friendReviews[review_index]!.review!.likeCount! + 1;
      }

      review_index = mostPopularReviews
          .indexWhere((element) => element!.review!.id == review_id);

      if (review_index != -1) {
        mostPopularReviews[review_index]!.review!.likeCount =
            mostPopularReviews[review_index]!.review!.likeCount! + 1;
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

      int review_index = friendReviews
          .indexWhere((element) => element!.review!.id == review_id);

      if (review_index != -1) {
        friendReviews[review_index]!.review!.likeCount =
            friendReviews[review_index]!.review!.likeCount! - 1;
      }

      review_index = mostPopularReviews
          .indexWhere((element) => element!.review!.id == review_id);

      if (review_index != -1) {
        mostPopularReviews[review_index]!.review!.likeCount =
            mostPopularReviews[review_index]!.review!.likeCount! - 1;
      }

      getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 50.0,
                left: 13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (!loading && friendReviews.isEmpty) ? SizedBox() : const Text(
                    'Recent Friends\' Reviews',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: friendReviews.isEmpty
                        ? 150
                        : friendReviews.length * 160,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 0.0),
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: friendReviews.length,
                                  itemBuilder: (context, index) {
                                    ReviewModel? review =
                                        friendReviews[index]?.review;

                                    UserModel? user =
                                        friendReviews[index]?.user;

                                    GameModel? game =
                                        friendReviews[index]?.game;
                                    return Column(children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          right: 13,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(29.0),
                                              topRight: Radius.circular(10.0),
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0)),
                                          child: Container(
                                            height: 140.0,
                                            color: const Color(0xFFE9A6A6)
                                                .withOpacity(0.05),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: (user?.profileImage) !=
                                                                    null
                                                                ? Image.memory(
                                                                        base64Decode(
                                                                            (user?.profileImage)!))
                                                                    .image
                                                                : NetworkImage(
                                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 25,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                  (game?.name)!,
                                                                  style: TextStyle(
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
                                                                          color: Colors.white.withOpacity(
                                                                              0.5),
                                                                          fontSize:
                                                                              13.0),
                                                                    ),
                                                                    InkWell(
                                                                      child:
                                                                          Text(
                                                                        (user
                                                                            ?.username)!,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Color(0xFFE9A6A6),
                                                                            fontSize: 13.0),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => ProfilePage(user_id: (user?.id)!)));
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
                                                                  (review
                                                                      ?.context)!,
                                                                  style: TextStyle(
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
                                                                    icon: (liked[(review
                                                                            ?.id)])!
                                                                        ? Icon(
                                                                            Icons
                                                                                .favorite,
                                                                            size:
                                                                                30.0,
                                                                            color:
                                                                                Colors.red)
                                                                        : Icon(
                                                                            Icons.favorite_outline_outlined,
                                                                            size:
                                                                                30.0,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        if ((liked[(review?.id)]) ==
                                                                            false) {
                                                                          like((review
                                                                              ?.id)!);
                                                                          liked[(review?.id)!] =
                                                                              true;
                                                                        } else {
                                                                          dislike(
                                                                              (review?.id)!);
                                                                          liked[(review?.id)!] =
                                                                              false;
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                  Text(
                                                                    (review!
                                                                        .likeCount
                                                                        .toString()),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.5)),
                                                                  )
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 9,
                                                  child: SizedBox(
                                                    height: double.infinity,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: Image.memory(
                                                                  base64Decode((game
                                                                      ?.cover)!)).image,
                                                                      fit: BoxFit.fill
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          GameDetailsPage(
                                                                            game_id:
                                                                                game!.id!,
                                                                          )));
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                    ]);
                                  },
                                ),
                              ),
                            ],
                          ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 25.0,
                left: 13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (!loading && mostPopularReviews.isEmpty) ? SizedBox() : const Text(
                    'Most Popular Reviews',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: mostPopularReviews.isEmpty
                        ? 150
                        : mostPopularReviews.length * 160,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 0.0),
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: friendReviews.length,
                                  itemBuilder: (context, index) {
                                    ReviewModel? review =
                                        mostPopularReviews[index]?.review;

                                    UserModel? user =
                                        mostPopularReviews[index]?.user;

                                    GameModel? game =
                                        mostPopularReviews[index]?.game;
                                    return Column(children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          right: 13,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(29.0),
                                              topRight: Radius.circular(10.0),
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0)),
                                          child: Container(
                                            height: 140.0,
                                            color: const Color(0xFFE9A6A6)
                                                .withOpacity(0.05),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: (user?.profileImage) !=
                                                                    null
                                                                ? Image.memory(
                                                                        base64Decode(
                                                                            (user?.profileImage)!))
                                                                    .image
                                                                : NetworkImage(
                                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 25,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                                  (game?.name)!,
                                                                  style: TextStyle(
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
                                                                          color: Colors.white.withOpacity(
                                                                              0.5),
                                                                          fontSize:
                                                                              13.0),
                                                                    ),
                                                                    InkWell(
                                                                      child:
                                                                          Text(
                                                                        (user
                                                                            ?.username)!,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Color(0xFFE9A6A6),
                                                                            fontSize: 13.0),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => ProfilePage(user_id: (user?.id)!)));
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
                                                                  (review
                                                                      ?.context)!,
                                                                  style: TextStyle(
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
                                                                    icon: (liked[(review
                                                                            ?.id)])!
                                                                        ? Icon(
                                                                            Icons
                                                                                .favorite,
                                                                            size:
                                                                                30.0,
                                                                            color:
                                                                                Colors.red)
                                                                        : Icon(
                                                                            Icons.favorite_outline_outlined,
                                                                            size:
                                                                                30.0,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        if ((liked[(review?.id)]) ==
                                                                            false) {
                                                                          like((review
                                                                              ?.id)!);
                                                                          liked[(review?.id)!] =
                                                                              true;
                                                                        } else {
                                                                          dislike(
                                                                              (review?.id)!);
                                                                          liked[(review?.id)!] =
                                                                              false;
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                  Text(
                                                                    (review!
                                                                        .likeCount
                                                                        .toString()),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.5)),
                                                                  )
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 9,
                                                  child: SizedBox(
                                                    height: double.infinity,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: Image.memory(
                                                                  base64Decode((game
                                                                      ?.cover)!)).image,
                                                                      fit: BoxFit.fill
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () async {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          GameDetailsPage(
                                                                            game_id:
                                                                                game!.id!,
                                                                          )));
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                    ]);
                                  },
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
