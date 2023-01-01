import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gameinn/model/review_log_model.dart';
import 'package:gameinn/model/review_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/service/log_service.dart';
import 'package:gameinn/service/user_service.dart';
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
  final bool log_found;
  final UserModelLogs found_log;

  LogPage(
      {super.key,
      required this.game,
      required this.review_logged,
      required this.review,
      required this.log_found,
      required this.found_log});

  @override
  State<StatefulWidget> createState() =>
      _LogPageState(game, review_logged, review, log_found, found_log);
}

class _LogPageState extends State<LogPage> {
  late final GameModel game;
  late final bool review_logged;
  late final ReviewLogModel review;
  late final log_found;
  late final UserModelLogs found_log;
  String _userid = "";
  UserModel _user = UserModel(id: "");

  TextEditingController _context = TextEditingController();
  double _rating = 1;

  _LogPageState(this.game, this.review_logged, this.review, this.log_found,
      this.found_log);

  DateTime? startDate;
  DateTime? endDate;

  List<String> items = ['Unfinished', 'Finished', 'Still Playing'];
  String? selectedItem;
  bool ifStillPlaying = false;
  bool loading = true;

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
      _user = user;
      loading = false;
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 35, bottom: 20),
                      height: 275,
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
                                            initialValue: log_found
                                                ? DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        found_log.startDate!)
                                                : null,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                            format: format,
                                            resetIcon: Icon(Icons.close,
                                                color: Colors.grey),
                                            decoration: const InputDecoration(
                                              enabled: false,
                                              prefixIcon: const Icon(
                                                Icons.calendar_today,
                                                size: 15.0,
                                                color: Colors.white,
                                              ),
                                              border: InputBorder.none,
                                              hintText: 'YYYY-MM-DD',
                                              hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            onShowPicker:
                                                (context, currentValue) async {
                                              final date = await showDatePicker(
                                                  context: context,
                                                  initialDate: currentValue ??
                                                      DateTime.now(),
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
                                (selectedItem != null
                                        ? !ifStillPlaying
                                        : (log_found
                                            ? (found_log.stopDate != 0
                                                ? true
                                                : false)
                                            : true))
                                    ? const SizedBox(
                                        height: 20,
                                      )
                                    : const SizedBox(),
                                (selectedItem != null
                                        ? !ifStillPlaying
                                        : (log_found
                                            ? (found_log.stopDate != 0
                                                ? true
                                                : false)
                                            : true))
                                    ? const SizedBox(
                                        height: 20,
                                        child: Text(
                                          'End Date',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                (selectedItem != null
                                        ? !ifStillPlaying
                                        : (log_found
                                            ? (found_log.stopDate != 0
                                                ? true
                                                : false)
                                            : true))
                                    ? const SizedBox(
                                        height: 10,
                                      )
                                    : const SizedBox(),
                                (selectedItem != null
                                        ? !ifStillPlaying
                                        : (log_found
                                            ? (found_log.stopDate != 0
                                                ? true
                                                : false)
                                            : true))
                                    ? Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF3D3B54),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: DateTimeField(
                                                  initialValue: log_found
                                                      ? (found_log.stopDate != 0
                                                          ? DateTime
                                                              .fromMillisecondsSinceEpoch(
                                                                  found_log
                                                                      .stopDate!)
                                                          : null)
                                                      : null,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                  format: format,
                                                  resetIcon: Icon(Icons.close,
                                                      color: Colors.grey),
                                                  decoration:
                                                      const InputDecoration(
                                                    enabled: false,
                                                    prefixIcon: const Icon(
                                                      Icons.calendar_today,
                                                      size: 15.0,
                                                      color: Colors.white,
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText: 'YYYY-MM-DD',
                                                    hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                  onShowPicker: (context,
                                                      currentValue) async {
                                                    final date =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                currentValue ??
                                                                    DateTime
                                                                        .now(),
                                                            firstDate:
                                                                DateTime(1900),
                                                            lastDate:
                                                                DateTime(2100));
                                                    if (date != null) {
                                                      endDate = date;
                                                      return date;
                                                    } else {
                                                      endDate = currentValue;
                                                      return currentValue;
                                                    }
                                                  }),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
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
                                      value: selectedItem != null
                                          ? selectedItem
                                          : (log_found
                                              ? (found_log.stopDate != 0
                                                  ? (found_log.finished!
                                                      ? 'Finished'
                                                      : 'Unfinished')
                                                  : 'Still Playing')
                                              : 'Unfinished'),
                                      items: items
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17.0,
                                                    )),
                                              ))
                                          .toList(),
                                      onChanged: (item) => setState(() {
                                        if (item == 'Still Playing') {
                                          ifStillPlaying = true;
                                        } else {
                                          ifStillPlaying = false;
                                        }
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
                    GestureDetector(
                      onTap: () async {
                        if (!log_found) {
                          if (startDate != null) {
                            if (selectedItem == 'Still Playing' ||
                                endDate != null) {
                              UserModel? returned_user = await LogService()
                                  .LogCall(
                                      ctx: context,
                                      createDate:
                                          DateTime.now().millisecondsSinceEpoch,
                                      updateDate: 0,
                                      startDate:
                                          startDate!.millisecondsSinceEpoch,
                                      stopDate: selectedItem != 'Still Playing'
                                          ? endDate!.millisecondsSinceEpoch
                                          : 0,
                                      gameId: game.id!,
                                      finished: selectedItem == 'Finished',
                                      userId: _userid);

                              if (returned_user != null) {
                                Navigator.pop(context);
                              }
                            } else {
                              log("Error");
                            }
                          } else {
                            log("Error");
                          }
                        } else {
                          if (startDate != null ||
                              found_log.startDate != null) {
                            if (selectedItem == 'Still Playing' ||
                                endDate != null ||
                                found_log.stopDate != null &&
                                    found_log.stopDate != 0) {
                              int log_index = _user.logs!.indexWhere(
                                  (element) => element!.gameId == game.id);

                              UserModelLogs new_log = UserModelLogs(
                                createDate: found_log.createDate,
                                updateDate:
                                    DateTime.now().millisecondsSinceEpoch,
                                startDate: startDate != null
                                    ? startDate!.millisecondsSinceEpoch
                                    : found_log.startDate,
                                stopDate: selectedItem != 'Still Playing'
                                    ? (endDate != null
                                        ? endDate!.millisecondsSinceEpoch
                                        : found_log.stopDate)
                                    : 0,
                                gameId: game.id!,
                                finished: selectedItem == 'Finished',
                              );

                              _user.logs![log_index] = new_log;
                              UserModel? returned_user = await UserService()
                                  .updateUser(user_to_update: _user);

                              if (returned_user != null) {
                                Navigator.pop(context);
                              }
                            } else {
                              log('Error');
                            }
                          } else {
                            log('Error');
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xffE9A6A6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Center(
                              child: Text(
                                !log_found ? 'Log' : 'Edit Log',
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1F1D36)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      !review_logged
                          ? 'Give your rating'
                          : 'Edit your rating', //DÜZELT
                      style: const TextStyle(color: Colors.white, fontSize: 15),
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
                      initialRating:
                          review_logged ? review.vote!.toDouble() : 1,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                      itemSize: 22,
                      unratedColor: Colors.grey.shade800,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 280,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3D3B54),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
                                : review.context,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        review_logged
                            ? GestureDetector(
                                onTap: () async {
                                  if (review_logged) {
                                    ReviewModel? returned_review =
                                        await ReviewVoteService().reviewDelete(
                                            ctx: context,
                                            review_id: review.id!);
                                    if (returned_review != null) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEC2626),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Delete Review',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1F1D36)),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_context.text != null && _context.text != "") {
                              ReviewModel? returned_review;
                              if (!review_logged) {
                                returned_review = (await ReviewVoteService()
                                    .reviewVoteCall(
                                        ctx: context,
                                        userId: _userid,
                                        gameId: game.id!,
                                        context: _context.text,
                                        vote: _rating.toInt()))!;
                              } else {
                                returned_review = await ReviewVoteService().reviewVoteUpdate(
                                    ctx: context,
                                    userId: _userid,
                                    gameId: game.id!,
                                    context: _context.text,
                                    vote: _rating.toInt(),
                                    review_id: review.id!);
                              }
                              if(returned_review!=null){
                                Navigator.pop(context);
                              }
                            } else {
                              log("Review empty error.");
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xffE9A6A6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Center(
                              child: Text(
                                !review_logged ? 'Add Review' : 'Edit Review',
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1F1D36)),
                              ),
                            ),
                          ),
                        ),
                      ],
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
