import 'package:flutter/material.dart';
import 'package:funlearn/constants/text.dart';
import 'package:funlearn/model/assignments.dart';
import 'package:file_picker/file_picker.dart';

class MyAssignment extends StatelessWidget {
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
            child: RegularText(
                text: "Maximum marks : ${obj.totalmarks}", size: 25),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: RegularText(
                text: "Duedate : ${obj.duedate.substring(0, 10)}", size: 23),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: BoldText(text: "Submitted : ${obj.ontime}", size: 16),
          ),
          (obj.ontime == "Y")
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
                  child: BoldText(text:(obj.ontime=="Y")? "Update : ":"Submit :", size: 20),
                ),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.cyan),
                    ),
                    onPressed: () {},
                    child: BoldText(
                      text: "Upload file",
                      color: Colors.black,
                      size: 16,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
