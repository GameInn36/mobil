import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/game_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../service/review_vote_service.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class LogPage extends StatefulWidget {
  final GameModel game;
  final bool review_logged;
  final ReviewLogModel review;

  LogPage(
      {super.key,
      required this.game,
      required this.review_logged,
      required this.review});

  @override
  State<StatefulWidget> createState() =>
      _LogPageState(game, review_logged, review);
}

class _LogPageState extends State<LogPage> {
  late final GameModel game;
  late final bool review_logged;
  late final ReviewLogModel review;
  String _userid = "";

  TextEditingController _startdate = TextEditingController();
  TextEditingController _enddate = TextEditingController();
  TextEditingController _context = TextEditingController();
  double _rating = 1;

  _LogPageState(this.game, this.review_logged, this.review);

  DateTime? startDate;
  DateTime? endDate;

  List<String> items = ['Unfinished', 'Finised', 'Still Playing'];
  String selectedItem = 'Unfinished';

  final format = DateFormat('yyyy-MM-dd');

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
                                  child: DateTimeField(
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      format: format,
                                      resetIcon:
                                          Icon(Icons.close, color: Colors.grey),
                                      decoration: const InputDecoration(
                                        enabled: false,
                                        prefixIcon: const Icon(
                                          Icons.calendar_today,
                                          size: 15.0,
                                          color: Colors.white,
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'YY/MM/DD',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      onShowPicker:
                                          (context, currentValue) async {
                                        final date = await showDatePicker(
                                            context: context,
                                            initialDate:
                                                currentValue ?? DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100));

                                        if (date != null) {
                                          startDate = date;
                                          return date;
                                        } else {
                                          startDate = currentValue;
                                          return currentValue;
                                        }
                                      }),
                                ),
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
                                  child: DateTimeField(
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      format: format,
                                      resetIcon:
                                          Icon(Icons.close, color: Colors.grey),
                                      decoration: const InputDecoration(
                                        enabled: false,
                                        prefixIcon: const Icon(
                                          Icons.calendar_today,
                                          size: 15.0,
                                          color: Colors.white,
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'YY/MM/DD',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      onShowPicker:
                                          (context, currentValue) async {
                                        final date = await showDatePicker(
                                            context: context,
                                            initialDate:
                                                currentValue ?? DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100));
                                        if (date != null) {
                                          startDate = date;
                                          return date;
                                        } else {
                                          startDate = currentValue;
                                          return currentValue;
                                        }
                                      }),
                                ),
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
                            child: Center(
                              child: DropdownButton<String>(
                                value: selectedItem,
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 17.0,
                                              )),
                                        ))
                                    .toList(),
                                onChanged: (item) => setState(() {
                                  selectedItem = item!;
                                }),
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
              Text(
                !review_logged ? 'Give your rating' : 'Edit your rating',
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
                initialRating: review_logged ? review.vote!.toDouble() : 1,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                itemSize: 22,
                unratedColor: Colors.grey.shade800,
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                height: 325,
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: !review_logged
                          ? 'Write down your review...'
                          : 'Write down your new review...',
                      hintStyle: const TextStyle(
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
