import 'package:flutter/material.dart';
import 'package:funlearn/constants/text.dart';
import 'package:funlearn/model/assignments.dart';
import 'package:file_picker/file_picker.dart';

class MyAssignment extends StatelessWidget  {
  final Assignments obj;
   MyAssignment({Key key, this.obj}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BoldText(text: obj.name),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: BoldText(text: "Subject : ${obj.subject}", size: 30),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: RegularText(text: "Maximum marks : ${obj.totalmarks}", size: 25),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: RegularText(text: "Duedate : ${obj.duedate.substring(0,10)}", size: 23),

          ),
          Divider(),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: BoldText(text: "Submitted : ${obj.ontime}", size: 16),
          ),
        ],
      ),
    );
  }
}
