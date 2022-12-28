import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/review_with_game_model.dart';
import 'package:gameinn/pages/profile_page.dart';
import 'package:gameinn/service/review_vote_service.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import 'game_details.page.dart';
import '../model/game_model.dart';
import 'package:gameinn/service/search_service.dart';

class UserReviewsPage extends StatelessWidget {
  const UserReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Reviews',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 23.0),
        ),
      ),
      body: ShowUserReviewsPage(),
    );
  }
}

class ShowUserReviewsPage extends StatefulWidget {
  ShowUserReviewsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowUserReviewsState();
}

class _ShowUserReviewsState extends State<ShowUserReviewsPage> {
  final reviewVoteService = ReviewVoteService();
  final userservice = UserService();

  List<ReviewWithGame?> userReviews = [];
  String user_id = "";
  String username = "";

  @override
  void initState() {
    super.initState();

    getList();
  }

  void getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

    userReviews = (await reviewVoteService.getUserReviews(user_id: user.id!))!;

    setState(() {
      this.user_id = user.id!;
      this.userReviews = userReviews;
      this.username = user.username!;
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
                  itemCount: userReviews.length,
                  itemBuilder: (context, index) {
                    ReviewWithGame? review = userReviews[index];
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(29.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                            child: Container(
                              height: 140.0,
                              color: const Color(0xFFE9A6A6).withOpacity(0.05),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 25,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    (review?.game?.name)!,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12.0),
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
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 13.0),
                                                      ),
                                                      InkWell(
                                                        child: Text(
                                                          username,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFE9A6A6),
                                                              fontSize: 13.0),
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ProfilePage(
                                                                          user_id:
                                                                              user_id)));
                                                        },
                                                      )
                                                    ])),
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    (review?.review?.context)!,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                    ),
                                                    Text(
                                                      (review?.review
                                                              ?.likeCount)
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.5)),
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
                                            BorderRadius.circular(10.0),
                                        child: Image.memory(base64Decode((review
                                            ?.game
                                            ?.cover)!)), //check adding navigation
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
