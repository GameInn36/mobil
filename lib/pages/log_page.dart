import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../model/game_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../service/review_vote_service.dart';

class LogPage extends StatelessWidget {
  late final GameModel game;
  late final String _userid;

  TextEditingController _stratdate = TextEditingController();
  TextEditingController _enddate = TextEditingController();
  TextEditingController _context = TextEditingController();
  double _rating = 1;

  LogPage(this.game, this._userid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 35, bottom: 20),
                height: 285,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 19,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45,
                            child: Text(
                              (game.name ?? 'Unknown'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                            child: Text(
                              'Start Date',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3D3B54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: _stratdate,
                                    decoration: InputDecoration(
                                      enabled: false,
                                      prefixIcon: const Icon(
                                        Icons.calendar_today,
                                        size: 15.0,
                                        color: Colors.white,
                                      ),
                                      border: InputBorder.none,
                                      hintText: DateTime.now()
                                          .toString()
                                          .split(' ')
                                          .first,
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () => {},
                                    child: const Text(
                                      'Change',
                                      style: TextStyle(
                                        color: Color(0xFFE9A6A6),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                            child: Text(
                              'End Date',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3D3B54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: _enddate,
                                    decoration: InputDecoration(
                                      enabled: false,
                                      prefixIcon: const Icon(
                                        Icons.calendar_today,
                                        size: 15.0,
                                        color: Colors.white,
                                      ),
                                      border: InputBorder.none,
                                      hintText: DateTime.now()
                                          .toString()
                                          .split(' ')
                                          .first,
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () => {},
                                    child: const Text(
                                      'Change',
                                      style: TextStyle(
                                        color: Color(0xFFE9A6A6),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: 40,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3D3B54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: const Center(
                              child: Text(
                                'Finished',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 10,
                      child: SizedBox(
                        height: 170,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9.0),
                          child: Image.memory(
                            base64Decode((game.cover) ?? ''),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Give your rating',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(
                height: 5,
              ),
              RatingBar.builder(
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Color(0xFFEC2626),
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
                direction: Axis.horizontal,
                minRating: 1,
                initialRating: 1,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                itemSize: 22,
                unratedColor: Colors.grey.shade800,
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                height: 400,
                decoration: const BoxDecoration(
                  color: Color(0xFF3D3B54),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    controller: _context,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write down your review...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => {
                  ReviewVoteService().reviewVoteCall(
                      ctx: context,
                      userId: _userid,
                      gameId: game.id!,
                      context: _context.text,
                      vote: _rating.toInt())
                },
                child: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xffE9A6A6),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: const Center(
                    child: Text(
                      'Log',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F1D36)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
