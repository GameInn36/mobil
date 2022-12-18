import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gameinn/pages/search_page.dart';
import 'package:gameinn/view/sidebar.dart';
import 'package:gameinn/pages/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/navigator_key.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameInn',
      routes: {
        '/': (context) => AuthPage(),
        '/home': (context) => MyHomePage(title: 'GameInn'),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1F1D36),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFC4C4C4).withOpacity(0.35),
        ),
      ),
      navigatorKey: navigatorKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _username = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = (prefs.getString('username') ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SidebarDrawerWidget(username: _username,),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 23.0),
          ),
          bottom: const TabBar(
            tabs: [Tab(text: 'Games'), Tab(text: 'Reviews')],
            indicatorColor: Color(0xFFAC32F6),
            indicatorWeight: 3.0,
            labelStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: const TabBarView(
          children: [HomeGames(), HomeReviews()],
        ),
      ),
    );
  }
}

class HomeGames extends StatelessWidget {
  const HomeGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: ListView(scrollDirection: Axis.vertical, children: [
          Container(
            margin: const EdgeInsets.only(
              top: 50.0,
              left: 13,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'New From Friends',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 170.0,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 0.0),
                    scrollDirection: Axis.horizontal,
                    children: mostPopularGames,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 25.0,
              left: 13,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Popular Games',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 170.0,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 0.0),
                    scrollDirection: Axis.horizontal,
                    children: mostPopularGames,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 25.0,
              left: 13,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'New Games',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  height: 170.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 0.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: mostPopularGames,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.;
  }
}

class HomeReviews extends StatelessWidget {
  const HomeReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 50.0,
                left: 13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Friends\' Reviews',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: mostPopularReviews,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 25.0,
                left: 13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Most Popular Reviews',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: mostPopularReviews,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

List<Widget> mostPopularGames = <Widget>[
  SizedBox(
    height: 140.0,
    width: 100.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    height: 140.0,
    width: 100.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    height: 140.0,
    width: 100.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    height: 140.0,
    width: 100.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    height: 140.0,
    width: 100.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    height: 140.0,
    width: 100.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    height: 140.0,
    width: 100.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  const SizedBox(
    width: 6.0,
  ),
  SizedBox(
    height: 140.0,
    width: 100.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
        fit: BoxFit.fill,
      ),
    ),
  ),
];

List<Widget> mostPopularReviews = <Widget>[
  Container(
    margin: const EdgeInsets.only(
      right: 13,
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(29.0), topRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
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
                            )
                        )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 25,
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Forgotton Anne",
                              style: TextStyle(color: Colors.white, fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:[
                            Text(
                              "Review by ",
                              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13.0),
                            ),
                            const Text(
                              "Faruk",
                              style: TextStyle(color: Color(0xFFE9A6A6), fontSize: 13.0),
                            )
                          ]
                        )
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Amazing. Best game ever.",
                              style: TextStyle(color: Colors.white, fontSize: 13.5),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            Text(
                              " 2",
                              style: TextStyle(color: Colors.white.withOpacity(0.5)),
                            )
                          ],
                        )
                      ),
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
                  borderRadius: BorderRadius.circular(10.0),
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
  Container(
    margin: const EdgeInsets.only(
      right: 13,
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(29.0), topRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
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
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                            )
                        )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 25,
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Valorant",
                              style: TextStyle(color: Colors.white, fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Text(
                                  "Review by ",
                                  style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13.0),
                                ),
                                const Text(
                                  "Ayşe",
                                  style: TextStyle(color: Color(0xFFE9A6A6), fontSize: 13.0),
                                )
                              ]
                          )
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Catchy!",
                              style: TextStyle(color: Colors.white, fontSize: 13.5),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              Text(
                                " 2",
                                style: TextStyle(color: Colors.white.withOpacity(0.5)),
                              )
                            ],
                          )
                      ),
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
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
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
  Container(
    margin: const EdgeInsets.only(
      right: 13,
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(29.0), topRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
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
                            "https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg",
                          )
                      )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 25,
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "CS GO",
                              style: TextStyle(color: Colors.white, fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Text(
                                  "Review by ",
                                  style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13.0),
                                ),
                                const Text(
                                  "Doğa",
                                  style: TextStyle(color: Color(0xFFE9A6A6), fontSize: 13.0),
                                )
                              ]
                          )
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Hard to play...",
                              style: TextStyle(color: Colors.white, fontSize: 13.5),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              Text(
                                " 2",
                                style: TextStyle(color: Colors.white.withOpacity(0.5)),
                              )
                            ],
                          )
                      ),
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
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
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
];
