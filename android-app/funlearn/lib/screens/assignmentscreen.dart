import 'package:flutter/material.dart';
import 'package:funlearn/constants/text.dart';
import 'package:funlearn/model/assignments.dart';
import 'package:file_picker/file_picker.dart';

class MyAssignment extends StatelessWidget {
  final Assignments obj;
  const MyAssignment({Key key, this.obj}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BoldText(text:obj.name),
      ),
    );
  }
}
