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
  final String user_id;
  UserReviewsPage({super.key, required this.user_id});

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
      body: ShowUserReviewsPage(user_id: user_id),
    );
  }
}

class ShowUserReviewsPage extends StatefulWidget {
  final String user_id;
  ShowUserReviewsPage({super.key, required this.user_id});

  @override
  State<StatefulWidget> createState() => _ShowUserReviewsState(user_id);
}

class _ShowUserReviewsState extends State<ShowUserReviewsPage> {
  late String user_id;
  _ShowUserReviewsState(this.user_id);
  late UserModel user;
  late UserModel authorizedUser;
  final reviewVoteService = ReviewVoteService();
  final userservice = UserService();

  List<ReviewWithGame?> userReviews = [];

  Map<String, bool> liked = {};

  String username = "";

  @override
  void initState() {
    super.initState();

    getList();
  }

  void getList() async {
    user = (await userservice.getUser(user_id: user_id))!;

    authorizedUser = (await userservice.getAuthorizedUser())!;

    userReviews = (await reviewVoteService.getUserReviews(user_id: user.id!))!;

    if (userReviews != null) {
      for (int i = 0; i < userReviews.length; i++) {
        if ((userReviews[i]?.review?.likedUsers)!.contains(authorizedUser.id)) {
          liked[(userReviews[i]?.review?.id)!] =
              true; //if not already exist, add
        } else {
          liked[(userReviews[i]?.review?.id)!] = false;
        }
      }
    }

    setState(() {
      this.authorizedUser = authorizedUser;
      this.user = user;
      this.user_id = user.id!;
      this.userReviews = userReviews;
      this.username = user.username!;
      this.liked = liked;
    });
  }

  void like(String review_id) async {
    setState(() {
      reviewVoteService.likeReview(review_id: review_id).then((value) {
        //userReviews = (await reviewVoteService.getUserReviews(user_id: user.id!))!;
      });
    });
  }

  void dislike(String review_id) {
    setState(() {
      reviewVoteService.dislikeReview(review_id: review_id).then((value) {
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
              Expanded(
                child: ListView.builder(
                  itemCount: userReviews.length,
                  itemBuilder: (context, index) {
                    ReviewWithGame? review = userReviews[index];
                    int likeCount = (review?.review?.likeCount)!;
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
                                                    IconButton(
                                                      icon: (liked[(review
                                                              ?.review?.id)])!
                                                          ? Icon(Icons.favorite,
                                                              size: 30.0,
                                                              color: Colors.red)
                                                          : Icon(
                                                              Icons
                                                                  .favorite_outline_outlined,
                                                              size: 30.0,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                      onPressed: () {
                                                        setState(() {
                                                          if ((liked[(review
                                                                  ?.review
                                                                  ?.id)]) ==
                                                              false) {
                                                            like((review
                                                                ?.review?.id)!);
                                                            liked[(review
                                                                ?.review
                                                                ?.id)!] = true;
                                                            likeCount =
                                                                likeCount + 1;
                                                          } else {
                                                            dislike((review
                                                                ?.review?.id)!);
                                                            liked[(review
                                                                ?.review
                                                                ?.id)!] = false;
                                                            likeCount =
                                                                likeCount - 1;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      likeCount.toString(),
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
                                        child: InkWell(
                                          child: Image.memory(base64Decode(
                                              (review?.game?.cover)!)),
                                          onTap: () async {
                                            bool review_found = false;
                                            ReviewLogModel review_log =
                                                ReviewLogModel(id: "");
                                            List<ReviewLogModel>? reviews =
                                                await ReviewVoteService()
                                                    .reviewLogGet(
                                                        ctx: context,
                                                        gameId: (review
                                                            ?.game?.id)!);
                                            if (reviews != null) {
                                              review_log = reviews.firstWhere(
                                                (element) =>
                                                    element.user!.id! ==
                                                    authorizedUser.id,
                                                orElse: () =>
                                                    ReviewLogModel(id: ""),
                                              );
                                              review_found = review_log.id == ""
                                                  ? false
                                                  : true;
                                            }
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GameDetailsPage(
                                                          game: (review?.game)!,
                                                          reviews:
                                                              reviews != null
                                                                  ? reviews
                                                                  : [],
                                                          review_found:
                                                              review_found,
                                                          review: review_log,
                                                        )));
                                          },
                                        ), //check adding navigation
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
