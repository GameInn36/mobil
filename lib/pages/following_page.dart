import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gameinn/service/user_service.dart';

import '../model/user_model.dart';
import 'game_details.page.dart';
import '../model/game_model.dart';
import 'package:gameinn/service/search_service.dart';

class FollowingPage extends StatelessWidget {
  final String user_id;
  const FollowingPage({Key? key, required this.user_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Followings',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 23.0),
        ),
      ),
      body: ShowFollowingPage(user_id: user_id,),
    );
  }
}

class ShowFollowingPage extends StatefulWidget {
  final String user_id;
  ShowFollowingPage({Key? key, required this.user_id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowFollowingState(user_id);
}

class _ShowFollowingState extends State<ShowFollowingPage> {
  late final user_id;
  _ShowFollowingState(this.user_id);

  final userservice = UserService();

  List<UserModel?> followings = [];
  late UserModel user;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    getList();
  }

  void getList() async {
    user = (await UserService().getUser(user_id: user_id))!;

    followings = (await userservice.getFollowings(user_id: user.id))!;

    setState(() {
      this.user = user;
      this.followings = followings;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Center(child: CircularProgressIndicator(),) : Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: followings.length,
                  itemBuilder: (context, index) {
                    UserModel? following = followings[index];
                    return Card(
                      color: const Color(0xFF1F1D36),
                      child: ListTile(
                        title: Text(
                          (following?.username)!,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        leading: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: (following?.profileImage) != null
                                  ? Image.memory(base64Decode(
                                          (following?.profileImage)!))
                                      .image
                                  : NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
                                    ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.;
  }
}
