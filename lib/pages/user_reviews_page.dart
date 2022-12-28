import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  final searchservice = SearchService();

  List<GameModel?> games = [];

  @override
  void initState() {
    super.initState();

    getList();
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
                                    flex: 6,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAePHGk4zQacrlExygB4QUQlmSmCR9Qxd1Sw&usqp=CAU",
                                                  ))),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                                children: const [
                                                  Text(
                                                    "Forgotton Anne",
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
                                                      const Text(
                                                        "Faruk",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFE9A6A6),
                                                            fontSize: 13.0),
                                                      )
                                                    ])),
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "Amazing. Best game ever.",
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
                                                      " 2",
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
                                        child: Image.network(
                                          'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
                                          fit: BoxFit.fill,
                                        ),
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
