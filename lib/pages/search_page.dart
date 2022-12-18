import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gameinn/pages/search_service.dart';

import 'game_model.dart';

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
            tabs: [Tab(text: 'Games'), Tab(text: 'Member'), Tab(text: 'Studio')],
            indicatorColor: Color(0xFFAC32F6),
            indicatorWeight: 3.0,
            labelStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body:  TabBarView(
          children: [SearchGames(), SearchGames(), SearchGames()],
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

    void updateList(String searched) {
      log(searched);
      setState(() {
        searchservice.gameSearch(searched_name: searched).then((value) {
          if (value != null) {
            games = value;
          }
          else {

          }
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
                  hintText: "eg: Last of Us",
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Expanded(
                child: ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            (games[index]?.name)!,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),

        ),
      ); // This trailing comma makes auto-formatting nicer for build methods.;
    }
  }
