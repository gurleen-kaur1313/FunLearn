import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:funlearn/constants/text.dart';
import 'package:funlearn/model/assignments.dart';
import 'package:file_picker/file_picker.dart';

class MyAssignment extends StatefulWidget {
  final Assignments obj;

  MyAssignment({Key key, this.obj}) : super(key: key);

  @override
  _MyAssignmentState createState() => _MyAssignmentState();
}

class _MyAssignmentState extends State<MyAssignment> {
  final storage = FirebaseStorage.instance;
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BoldText(text: widget.obj.name),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: BoldText(text: "Subject : ${widget.obj.subject}", size: 30),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: RegularText(
                text: "Maximum marks : ${widget.obj.totalmarks}", size: 25),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: RegularText(
                text: "Duedate : ${widget.obj.duedate.substring(0, 10)}",
                size: 23),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: BoldText(text: "Submitted : ${widget.obj.ontime}", size: 16),
          ),
          (widget.obj.ontime == "Y")
              ? Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.cyan),
                      ),
                      onPressed: () {},
                      child: BoldText(
                        text: "View submitted file",
                        color: Colors.black,
                        size: 20,
                      )),
                )
              : SizedBox(),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: BoldText(
                      text:
                          (widget.obj.ontime == "Y") ? "Update : " : "Submit :",
                      size: 20),
                ),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.cyan),
                    ),
                    onPressed: () async {
                      setState(() {
                        clicked = true;
                      });
                      FilePickerResult result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        File file = File(result.files.single.path);
                      } else {}
                    },
                    child: BoldText(
                      text: "Upload file",
                      color: Colors.black,
                      size: 16,
                    )),
              ],
            ),
          ),
          (clicked)
              ? Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: BoldText(text: "File : ", size: 20),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
