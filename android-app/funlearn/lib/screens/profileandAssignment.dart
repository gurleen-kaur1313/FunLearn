import 'package:flutter/material.dart';
import 'package:funlearn/constants/text.dart';
import 'package:funlearn/model/assignments.dart';
import 'package:funlearn/model/test.dart';
import 'package:funlearn/screens/assignmentscreen.dart';
import 'package:funlearn/server/assignment_gql.dart';
import 'package:funlearn/server/login_gql.dart';
import 'package:funlearn/server/test_gql.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  Widget testChild(TestClass obj) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoldText(
            text: obj.subject,
            color: Colors.black,
            size: 23,
          ),
          RegularText(
            text: "Total marks : " + obj.totalmarks.toString(),
            color: Colors.grey[700],
            size: 20,
          ),
          RegularText(
            text: "Date : " + obj.date.toString(),
            color: Colors.grey[700],
            size: 16,
          )
        ],
      ),
    );
  }

  Widget assignmentChild(Assignments obj) {
    return InkWell(
      onTap: () {
        Get.to(MyAssignment(obj: obj));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
        height: 100,
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(spreadRadius: 0, blurRadius: 3, color: Colors.grey[700]),
          ],
        ),
        child: Stack(
          children: [
            Container(
                height: 130,
                width: 130,
                child: Image.asset(
                  "lib/assets/back.webp",
                  fit: BoxFit.cover,
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RegularText(
                    text: "${obj.name}",
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(height: 4),
                  BoldText(
                    text: "${obj.duedate.substring(0, 10)}",
                    color: Colors.white,
                    size: 12,
                  ),
                  SizedBox(height: 4),
                  BoldText(
                    text: "Total marks : ${obj.totalmarks}",
                    color: Colors.white,
                    size: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.school,
                  size: 33,
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                BoldText(text: "My Classroom", size: 36, color: Colors.black),
              ],
            ),
          ),
          Divider(),
          Container(
            height: 150,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profile.image),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegularText(
                      text: "${profile.name}",
                      size: 20,
                      color: Colors.black,
                    ),
                    RegularText(
                      text: "${profile.rollno}",
                      size: 16,
                      color: Colors.grey[700],
                    ),
                    RegularText(
                      text: "Class Score : ${profile.score}",
                      size: 14,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      icon: Icon(
                        Icons.play_circle_outline,
                      ),
                      iconSize: 45,
                      color: Colors.cyan[700],
                      splashRadius: 30,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 20,
                        ),
                        SizedBox(width: 7),
                        RegularText(
                          text: "${profile.life}",
                          size: 16,
                          color: Colors.grey[700],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                BoldText(
                    text: "My pending assignments : ",
                    size: 16,
                    color: Colors.black),
                Expanded(child: SizedBox()),
                BoldText(text: "$pendingA", size: 16, color: Colors.red),
              ],
            ),
          ),
          Container(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (listA.length != null) ? listA.length : 0,
              itemBuilder: (context, index) {
                Assignments obj = listA[index];
                return assignmentChild(obj);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                BoldText(
                    text: "Announcements : ", size: 16, color: Colors.black),
                Expanded(child: SizedBox()),
                BoldText(text: "$pendingT", size: 16, color: Colors.green),
              ],
            ),
          ),
          Container(
            height: 300,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: (listT != null || listT.isNotEmpty) ? listT.length : 1,
              itemBuilder: (context, index) {
                if (listT.isEmpty || listT == null) {
                  return Center(
                    child: Text("No new announcements"),
                  );
                } else {
                  TestClass obj = listT[index];
                  return testChild(obj);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
