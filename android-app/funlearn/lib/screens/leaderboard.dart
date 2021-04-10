import 'package:flutter/material.dart';
import 'package:funlearn/constants/text.dart';
import 'package:funlearn/model/leaderboard_model.dart';
import 'package:funlearn/server/leaderboard_gql.dart';

class Leaderboard extends StatelessWidget {
  Widget leaderboardchild(LeaderboardClass obj, int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 90,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 15),
          BoldText(text: "$index", color: Colors.black, size: 20),
          SizedBox(width: 15),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey[400], spreadRadius: 1, blurRadius: 3)
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(obj.image),
                  radius: 30,
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(text: "${obj.name}", color: Colors.grey[700], size: 18),
                    RegularText(
                      text: "${obj.rollNo}",
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(
                        text: "Score : ${obj.score}", color: Colors.grey[700], size: 15),
                    RegularText(
                      text: "Game : ${obj.gameScore}",
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.leaderboard,
                    size: 33,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15),
                  BoldText(text: "Leaderboard", size: 36, color: Colors.black),
                ],
              )),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: (leaders.length != null) ? leaders.length : 0,
              itemBuilder: (context, index) {
                LeaderboardClass obj = leaders[index];
                return leaderboardchild(obj,index+1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
