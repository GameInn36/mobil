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
                          flex: 1,
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
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: 60,
                child: Divider(
                  color: Colors.white.withOpacity(0.19),
                  thickness: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 4,
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
  SizedBox(
    height: 100,
    width: 95.0,
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
    width: 95.0,
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
    width: 95.0,
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
    width: 95.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://assets-prd.ignimgs.com/2021/12/21/valorant-1640045685890.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
  SizedBox(
    width: 80.0,
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
    width: 80.0,
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
    width: 80.0,
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
    width: 80.0,
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
    width: 80.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Image.network(
        'https://static.tvtropes.org/pmwiki/pub/images/fasplash_2018_sec_portrait_xbox_0.jpg',
        fit: BoxFit.fill,
      ),
    ),
  ),
];