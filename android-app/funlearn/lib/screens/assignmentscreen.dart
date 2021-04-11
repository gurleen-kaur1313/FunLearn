import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:funlearn/constants/text.dart';
import 'package:funlearn/model/assignments.dart';
import 'package:file_picker/file_picker.dart';
import 'package:funlearn/server/upload.dart';

class MyAssignment extends StatefulWidget {
  final Assignments obj;

  MyAssignment({Key key, this.obj}) : super(key: key);

  @override
  _MyAssignmentState createState() => _MyAssignmentState();
}

class ButtonUpload extends GetxController {
  RxInt buttonState = 0.obs;
}

class _MyAssignmentState extends State<MyAssignment> {
  final storage = FirebaseStorage.instance;
  bool clicked = false;
  String name = "Not selected";
  File file;
  final btnState = Get.put(ButtonUpload());
  Widget uploadChild() {
    switch (btnState.buttonState.value) {
      case 0:
        {
          return Container(
            child: BoldText(text: "Submit File", color: Colors.white, size: 20),
          );
        }
        break;
      case 1:
        {
          return SpinKitDoubleBounce(
            color: Colors.white,
            size: 40.0,
          );
        }
        break;
      case 2:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified,
                color: Colors.white,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                "Uploaded!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ],
          );
        }
        break;
      case 3:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(
                width: 7,
              ),
              Text(
                "Upload Failed!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ],
          );
        }
        break;
      default:
        {
          return Text(
            "Upload file!",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          );
        }
    }
  }

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
                      FilePickerResult result = await FilePicker.platform
                          .pickFiles(type: FileType.custom, allowedExtensions: [
                        'pdf',
                        'docx',
                        'txt',
                        'docs'
                      ]);
                      if (result != null) {
                        file = File(result.files.single.path);
                        setState(() {
                          name = file.path.substring(52);
                        });
                      } else {
                        setState(() {
                          name = "Not selected";
                        });
                      }
                    },
                    child: BoldText(
                      text: "Choose file",
                      color: Colors.black,
                      size: 16,
                    )),
              ],
            ),
          ),
          (clicked)
              ? Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: BoldText(text: "File : $name", size: 20),
                )
              : SizedBox(),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () async {
                setState(() {
                  btnState.buttonState.value = 1;
                });
                String fileName = basename(file.path);
                var firebaseStorageRef =
                    FirebaseStorage.instance.ref().child('uploads/$fileName');
                var uploadTask = firebaseStorageRef.putFile(file);
                var taskSnapshot = await uploadTask.whenComplete(() {});
                taskSnapshot.ref.getDownloadURL().then(
                  (value) async {
                    widget.obj.submissionurl = value;
                    await uploadAssignment(
                        widget.obj.id, widget.obj.submissionurl);
                  },
                );
                setState(() {
                  btnState.buttonState.value = 2;
                });
              },
              child: uploadChild(),
            ),
          ),
        ],
      ),
    );
  }
}
