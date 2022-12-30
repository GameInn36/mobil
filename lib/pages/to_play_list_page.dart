import 'package:flutter/material.dart';

class ToPlayListPage extends StatelessWidget {
  const ToPlayListPage({Key? key}) : super(key: key);

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
              const SizedBox(height: 25,),
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
                            'To Play List',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.filter_alt,
                              color: Colors.white,
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
                child: GridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                  children: toPlayList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> toPlayList = <Widget>[
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
          child: Center(
            child: Text(
              "Forgotton Anne",
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.white,
              ),
            ),
          ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Valorant",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "CS GO",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Forgotton Anne",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Valorant",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "CS GO",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Forgotton Anne",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Valorant",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "CS GO",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Forgotton Anne",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Valorant",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "CS GO",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Forgotton Anne",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Valorant",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "CS GO",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Forgotton Anne",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Valorant",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "CS GO",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Forgotton Anne",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Valorant",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "CS GO",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Forgotton Anne",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "Valorant",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://static.wikia.nocookie.net/cswikia/images/0/0c/Csgo-payback-icon.png/revision/latest/smart/width/250/height/250?cb=20141112151119',
            fit: BoxFit.fill,
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: Center(
          child: Text(
            "CS GO",
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  ),
];