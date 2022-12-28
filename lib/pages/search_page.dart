import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/pages/game_details.page.dart';
import 'package:gameinn/service/review_vote_service.dart';
import 'package:gameinn/service/search_service.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/game_model.dart';
import '../widgets/show_custom_loginerror_dialog.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Games'),
              Tab(text: 'Member'),
              Tab(text: 'Studio')
            ],
            indicatorColor: Color(0xFFAC32F6),
            indicatorWeight: 3.0,
            labelStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: TabBarView(
          children: [SearchGames(), SearchMember(), SearchStudio()],
        ),
      ),
    );
  }
}

class SearchGames extends StatefulWidget {
  SearchGames({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchGameState();
}

class _SearchGameState extends State<SearchGames> {
  final searchservice = SearchService();

  List<GameModel?> games = [];
  String _userid = "";

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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameDetailsPage(
                                        game: game,
                                        reviews: reviews != null ? reviews : [],
                                        review_found: review_found,
                                        review: review,
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

class SearchStudio extends StatefulWidget {
  SearchStudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchStudioState();
}

class _SearchStudioState extends State<SearchStudio> {
  final searchservice = SearchService();

  List<GameModel?> games = [];
  String _userid = "";

  void updateList(String searched) {
    setState(() {
      searchservice.studioSearch(searched_name: searched).then((value) {
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
              onChanged: (value) => updateList(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFC4C4C4).withOpacity(0.35),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                //hintText: "eg: Last of Us",
                //hintStyle: TextStyle(
                //  color: Colors.grey
                //),
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
                          (game?.publisher)!,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameDetailsPage(
                                        game: game,
                                        reviews: reviews != null ? reviews : [],
                                        review_found: review_found,
                                        review: review,
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

class SearchMember extends StatefulWidget {
  SearchMember({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchMemberState();
}

class _SearchMemberState extends State<SearchMember> {
  final searchservice = SearchService();
  final userservice = UserService();
  late UserModel user;

  String name = " ";
  Map<String, bool> followed = {};
  List<UserModel?> members = [];
  List<String> user_followings = []; //nerede clear yapmalıyız?

  @override
  void initState() {
    getUser();

    super.initState();
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

    setState(() {
      userservice.getUser(user_id: user.id!).then((value) {
        log(value.toString());
        if (value != null) {
          user = value;
        }
      });
      name = user.username.toString();
      if (user.following != null) {
        for (int i = 0; i < (user.following)!.length; i++) {
          String user_id = user.following![i]!;
          if (!user_followings.contains(user_id)) {
            user_followings.add(user_id); //if not already exist, add
          }
        }
      }
    });
  }

  void updateList(String searched) {
    log(searched);
    setState(() {
      searchservice.memberSearch(searched_name: searched).then((value) {
        if (value != null) {
          members = value;

          for (var i = 0; i < value.length; i++) {
            if (user_followings.contains(value[i].id)) {
              followed[(value[i].id)!] = true;
            } else {
              followed[(value[i].id)!] = false;
            }
          }
          log(value.length.toString());
          log(followed.toString());
        } else {}
      });
    });
  }

  void follow(String user_id) {
    setState(() {
      userservice.followMember(user_id_to_follow: user_id).then((value) {
        if (value != null) {
          //set preferences daki user güncel değil, bu sayfa için gerekmeyebilir.
        } else {}
      });
    });
  }

  void unfollow(String user_id) {
    setState(() {
      userservice.unfollowMember(user_id_to_unfollow: user_id).then((value) {
        if (value != null) {
          //set preferences daki user güncel değil, bu sayfa için gerekmeyebilir.
        } else {}
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
            SizedBox(
              height: 50.0,
            ),
            TextField(
              onChanged: (value) => updateList(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFC4C4C4).withOpacity(0.35),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                //hintText: "eg: Last of Us",
                //hintStyle: TextStyle(
                //  color: Colors.grey
                //),
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
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    UserModel? member = members[index];
                    return Card(
                      color: const Color(0xFF1F1D36),
                      child: ListTile(
                          title: Text(
                            (member?.username)!,
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
                                image: (member?.profileImage) != null
                                    ? Image.memory(base64Decode(
                                            (member?.profileImage)!))
                                        .image
                                    : NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                                      ),
                              ),
                            ),
                          ),
                          trailing: (member?.username)! != name
                              ? IconButton(
                                  icon: ((followed[member?.id])!)
                                      ? Icon(
                                          Icons.check_circle_outline_outlined,
                                          size: 30.0,
                                          color: Colors.green)
                                      : Icon(
                                          Icons.add_circle,
                                          size: 30.0,
                                          color: Colors.grey,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      if ((followed[member?.id]) == false) {
                                        follow((member?.id)!);
                                        followed[(member?.id)!] = true;
                                      } else {
                                        unfollow((member?.id)!);
                                        followed[(member?.id)!] = false;
                                      }
                                    });
                                  },
                                )
                              : null),
                    );
                  }),
            ),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.;
  }
}
