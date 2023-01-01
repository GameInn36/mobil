import 'dart:convert';

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:gameinn/model/game_model.dart';
import 'package:gameinn/model/log_model.dart';
import 'package:gameinn/model/user_model.dart';
import 'package:gameinn/pages/game_details.page.dart';
import 'package:gameinn/service/log_service.dart';
import 'package:gameinn/service/search_service.dart';
import 'package:gameinn/service/user_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'selected_filter_controller.dart';

class PlayedListPage extends StatefulWidget {
  final String user_id;
  const PlayedListPage({Key? key, required this.user_id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayedListPageState(user_id);
}

class _PlayedListPageState extends State<PlayedListPage> {
  late final user_id;
  _PlayedListPageState(this.user_id);
  
  List<GameModel?> games = [];
  List<GameModel?> defaultGames = [];
  String _userid = "";
  UserModel _user = UserModel(id: "");
  List<String> items = [
    'Filter By Platform',
    'Sort Alphabetically',
    'Sort By Average Vote',
    'Sort By Release Date',
    'Default'
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
  bool loading = true;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    UserModel user = (await UserService().getUser(user_id: user_id))!;

    List<GameModel> tempList = [];
    (await LogService().LogGet(userId: user.id!))!
        .where((element) => element.gameLog!.finished == true)
        .forEach((element) {
      tempList.add(element.game!);
    });

    setState(() {
      _userid = user.id!;
      _user = user;
      games = tempList;
      defaultGames = games;
      loading = false;
    });
  }

  void sortAlphabetically() {
    setState(() {
      loading = true;
      games.sort(
          ((a, b) => a!.name!.toLowerCase().compareTo(b!.name!.toLowerCase())));
      loading = false;
    });
  }

  void sortByAverageVote() {
    setState(() {
      loading = true;
      games.sort(((b, a) => a!.vote!.compareTo((b!.vote!))));
      loading = false;
    });
  }

  void sortByReleaseDate() {
    setState(() {
      loading = true;
      games.sort(
          ((b, a) => a!.firstReleaseDate!.compareTo((b!.firstReleaseDate!))));
      loading = false;
    });
  }

  void getdefaultGames() {
    setState(() {
      loading = true;
      games = defaultGames;
      loading = false;
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
          setState(() {
            loading = true;
            games = games
                .where((x) =>
                    list.every((element) => x!.platforms!.contains(element)))
                .toList();
            loading = false;
          });

          Navigator.of(context).pop();
        });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                                child: Text(
                                  'Played Games',
                                  style: TextStyle(
                                    fontSize: 19.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
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
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item,
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10.0,
                                                    )),
                                              ))
                                          .toList(),
                                      onChanged: (item) => setState(() {
                                        loading = true;
                                        if (item == 'Sort Alphabetically') {
                                          sortAlphabetically();
                                        } else if (item ==
                                            'Sort By Average Vote') {
                                          sortByAverageVote();
                                        } else if (item ==
                                            'Sort By Release Date') {
                                          sortByReleaseDate();
                                        } else if (item ==
                                            'Filter By Platform') {
                                          openFilterDialog(context);
                                        } else if (item == 'Default') {
                                          getdefaultGames();
                                        }
                                        loading = false;
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
