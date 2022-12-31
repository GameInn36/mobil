import 'dart:convert';

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:gameinn/model/game_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/pages/game_details.page.dart';
import 'package:gameinn/pages/selected_filter_controller.dart';
import 'package:gameinn/service/search_service.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToPlayListPage extends StatefulWidget {
  const ToPlayListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToPlayListPageState();
}

class _ToPlayListPageState extends State<ToPlayListPage> {
  List<GameModel?> games = [];
  String _userid = "";
  UserModel _user = UserModel(id: "");
  List<String> items = [
    'Filter By Platform',
    'Sort Alphabetically',
    'Sort By Average Vote',
    'Sort By Release Date'
  ];
  String? selectedItem;

  List<String> platforms = [
    'PC',
    'Playstation 4',
    'Xbox One',
    'Android',
    'iOS',
    'Playstation 5',
    'Xbox Series X|S'
  ];

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel.fromJson(jsonDecode((prefs.getString('user'))!));

    List<GameModel> tempList =
        (await UserService().toPlayList(user_id: user.id!))!;

    setState(() {
      _userid = user.id!;
      _user = user;
      games = tempList;
    });
  }

  void sortAlphabetically() {
    setState(() {
      games.sort(
          ((a, b) => a!.name!.toLowerCase().compareTo(b!.name!.toLowerCase())));
    });
  }

  void sortByAverageVote() {
    setState(() {
      games.sort(((b, a) => a!.vote!.compareTo((b!.vote!))));
    });
  }

  void sortByReleaseDate() {
    setState(() {
      games.sort(
          ((b, a) => a!.firstReleaseDate!.compareTo((b!.firstReleaseDate!))));
    });
  }

  var controller = Get.put(SelectedFiltercontroller());

  void openFilterDialog(context) async {
    await FilterListDialog.display(context,
        listData: platforms,
        selectedListData: controller.getSelectedList(),
        headlineText: 'Filter Games By Platform',
        choiceChipLabel: (item) => item,
        validateSelectedItem: ((list, val) => list!.contains(val)),
        onItemSearch: (list, text) {
          return list.toLowerCase().contains(text.toLowerCase());
        },
        onApplyButtonClick: (list) {
          controller.setSelectedList(List<String>.from(list!));
          games = games
              .where((x) =>
                  list.every((element) => x!.platforms!.contains(element)))
              .toList();
          Navigator.of(context).pop();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1F1D36),
        alignment: Alignment.center,
        child: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              'To Play List',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.filter_alt_outlined,
                                  color: Colors.white,
                                ),
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.0,
                                              )),
                                        ))
                                    .toList(),
                                onChanged: (item) => setState(() {
                                  if (item == 'Sort Alphabetically') {
                                    sortAlphabetically();
                                  } else if (item == 'Sort By Average Vote') {
                                    sortByAverageVote();
                                  } else if (item == 'Sort By Release Date') {
                                    sortByReleaseDate();
                                  } else if (item == 'Filter By Platform') {
                                    openFilterDialog(context);
                                  }
                                }),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                height: 60,
                child: Divider(
                  color: Colors.white.withOpacity(0.19),
                  thickness: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    GameModel? game = games[index];
                    return InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameDetailsPage(
                                      game_id: game.id!,
                                    )));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.memory(
                                base64Decode((game?.cover)!),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                (game!.name!),
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
