import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:funlearn/constants/text.dart';
import 'package:funlearn/screens/homescreen.dart';
import 'package:funlearn/server/login_gql.dart';
import 'package:get/get.dart';

class ButtonLogin extends GetxController {
  RxInt buttonState = 0.obs;
}

// ignore: must_be_immutable
class LoginSreen extends StatefulWidget {
  @override
  _LoginSreenState createState() => _LoginSreenState();
}

class _LoginSreenState extends State<LoginSreen> {
  String name = "";
  final TextEditingController uName = new TextEditingController();
  final TextEditingController ucity = new TextEditingController();
  String city = "";
  bool sError = false;
  bool nError = false;
  final btnState = Get.put(ButtonLogin());
  @override
  void initState() {
    uName.addListener(() {
      name = uName.text;
    });
    ucity.addListener(() {
      city = ucity.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    uName.dispose();
    ucity.dispose();
    super.dispose();
  }

  Widget logChild() {
    switch (btnState.buttonState.value) {
      case 0:
        {
          return Container(
            child: BoldText(text: "Continue", color: Colors.white, size: 20),
          );
        }
        break;
      case 1:
        {
          return SpinKitDoubleBounce(
            color: Colors.white,
            size: 50.0,
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
                "Success!",
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
                "Check Credentials",
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
            "LogIn",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        // Get.off(() => Login());
                      })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ShadowBoldText(
                text: "Fun Learn",
                size: 39,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: RegularText(
                text: "Welcome back.\nYou've been missed!",
                size: 28,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: BoldText(
                text: "Let's sign you in.",
                size: 20,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: TextField(
                controller: uName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: (sError) ? "Can't be empty!" : null,
                  labelText: "Username",
                  prefixIcon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: ucity,
                keyboardType: TextInputType.text,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  errorText: (nError) ? "Can't be empty" : null,
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Container(
                height: 60,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Obx(() {
                    return ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                      ),
                      onPressed: () async {
                        if (city.isBlank && name.isBlank) {
                          setState(() {
                            nError = true;
                            sError = true;
                          });
                          Timer(Duration(seconds: 2), () {
                            setState(() {
                              sError = false;
                              nError = false;
                            });
                          });
                        } else if (name.isBlank) {
                          setState(() {
                            sError = true;
                          });

                          Timer(Duration(seconds: 2), () {
                            setState(() {
                              sError = false;
                              nError = false;
                            });
                          });
                        } else if (city.isBlank) {
                          setState(() {
                            nError = true;
                          });
                          Timer(Duration(seconds: 2), () {
                            setState(() {
                              sError = false;
                              nError = false;
                            });
                          });
                        } else {
                          btnState.buttonState.value = 1;
                          if (await login(name, city)) {
                            btnState.buttonState.value = 2;
                            Timer(Duration(seconds: 1), () {
                              print("pressed");
                              Get.off(() => HomeScreen());
                            });
                          } else {
                            btnState.buttonState.value = 3;
                            Timer(Duration(seconds: 1), () {
                              btnState.buttonState.value = 0;
                            });
                          }
                        }
                      },
                      child: Container(
                        child: logChild(),
                      ),
                    );
                  }),
                )),
          ],
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class Registerscreen extends StatefulWidget {
  @override
  _RegisterscreenState createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  String name = "";

  String state = "";

  String city = "";

  bool sEr = false;

  bool nEr = false;

  bool cEr = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        //
                      })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: BoldText(
                text: "Hello there,",
                size: 37,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: RegularText(
                text: "Register yourself here and connect with your friends.",
                size: 28,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: (sEr) ? "Please enter this field" : null,
                  labelText: "Username",
                  prefixIcon: Icon(Icons.alternate_email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: (cEr) ? "Please enter this field" : null,
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) {
                  state = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  errorText: (nEr) ? "Please enter this field" : null,
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) {
                  city = value;
                },
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                  ),
                  onPressed: () async {
                    if (name == "" && city == "" && state == "") {
                      setState(() {
                        nEr = true;
                        cEr = true;
                        sEr = true;
                        Timer(Duration(seconds: 1), () {
                          nEr = false;
                          cEr = false;
                          sEr = false;
                        });
                      });
                    } else if (name == "") {
                      setState(() {
                        sEr = true;
                      });
                      Timer(Duration(seconds: 1), () {
                        setState(() {
                          nEr = false;
                          cEr = false;
                          sEr = false;
                        });
                      });
                    } else if (state == "") {
                      setState(() {
                        cEr = true;
                      });
                      Timer(Duration(seconds: 1), () {
                        setState(() {
                          nEr = false;
                          cEr = false;
                          sEr = false;
                        });
                      });
                    } else if (city == "") {
                      setState(() {
                        nEr = true;
                      });
                      Timer(Duration(seconds: 1), () {
                        setState(() {
                          nEr = false;
                          cEr = false;
                          sEr = false;
                        });
                      });
                    } else {
                      Get.to(() => Profilescreen(
                            username: name,
                            password: city,
                            email: state,
                          ));
                    }
                  },
                  child: Container(
                    child:
                        BoldText(text: "Next", color: Colors.white, size: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class RegisterButtonState extends GetxController {
  RxInt state = 0.obs;
}

// ignore: must_be_immutable
class Profilescreen extends StatefulWidget {
  final String username;
  final String password;
  final String email;

  const Profilescreen({Key key, this.username, this.password, this.email})
      : super(key: key);
  @override
  _ProfilescreenState createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  String name = "";
  String dropdownValue = "";
  String city = "";
  String state = "";

  int _value = 1;

  bool nEr = false;
  bool cEr = false;
  bool sEr = false;

  final btnState = Get.put(RegisterButtonState());

  Widget registerChild() {
    switch (btnState.state.value) {
      case 0:
        {
          return Container(
            child: BoldText(text: "Register", color: Colors.white, size: 20),
          );
        }
        break;
      case 1:
        {
          return SpinKitDoubleBounce(
            color: Colors.white,
            size: 50.0,
          );
        }
        break;
      case 2:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified),
              SizedBox(
                width: 7,
              ),
              Text(
                "Success!",
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
              Icon(Icons.error),
              SizedBox(
                width: 7,
              ),
              Text(
                "Username or email taken!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ],
          );
        }
        break;
      default:
        {
          return Text(
            "LogIn",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        Get.offAll(() => Registerscreen());
                      })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: BoldText(
                text: "My Profile",
                size: 37,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: RegularText(
                text: "Build up your profile and showcase to others.",
                size: 28,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: (nEr) ? "Please enter this field" : null,
                  labelText: "Name",
                  prefixIcon: Icon(Icons.supervisor_account),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey[500])),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      hint: Text("Select Gender"),
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Text("Male"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Female"),
                          value: 2,
                        ),
                        DropdownMenuItem(child: Text("Others"), value: 3),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          if (value == 1) {
                            dropdownValue = "M";
                          }
                          if (value == 2) {
                            dropdownValue = "F";
                          }
                          if (value == 3) {
                            dropdownValue = "O";
                          }
                        });
                      }),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: (cEr) ? "Please enter this field" : null,
                  labelText: "City",
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) {
                  city = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: (sEr) ? "Please enter this field" : null,
                  labelText: "State",
                  prefixIcon: Icon(Icons.location_pin),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) {
                  state = value;
                },
              ),
            ),
            Container(
                height: 60,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Obx(() {
                      return ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                        ),
                        onPressed: () async {
                          if (name == "" && city == "" && state == "") {
                            setState(() {
                              nEr = true;
                              cEr = true;
                              sEr = true;
                            });
                            setState(() {
                              Timer(Duration(seconds: 1), () {
                                nEr = false;
                                cEr = false;
                                sEr = false;
                              });
                            });
                          } else if (name == "") {
                            setState(() {
                              nEr = true;
                            });
                            setState(() {
                              Timer(Duration(seconds: 1), () {
                                setState(() {
                                  nEr = false;
                                  cEr = false;
                                  sEr = false;
                                });
                              });
                            });
                          } else if (state == "") {
                            setState(() {
                              sEr = true;
                            });
                            setState(() {
                              Timer(Duration(seconds: 1), () {
                                setState(() {
                                  nEr = false;
                                  cEr = false;
                                  sEr = false;
                                });
                              });
                            });
                          } else if (city == "") {
                            setState(() {
                              cEr = true;
                            });
                            setState(() {
                              Timer(Duration(seconds: 1), () {
                                setState(() {
                                  nEr = false;
                                  cEr = false;
                                  sEr = false;
                                });
                              });
                            });
                          } else {
                            btnState.state.value = 1;
                            // if (await register(
                            //     widget.username,
                            //     widget.email,
                            //     widget.password,
                            //     name,
                            //     dropdownValue,
                            //     city,
                            //     state)) {
                            //   btnState.state.value = 2;
                            //   Timer(Duration(seconds: 1), () {
                            //     Get.offAll(() => HomeScreen());
                            //   });
                            // } else {
                            //   btnState.state.value = 3;
                            //   Timer(Duration(seconds: 2), () {
                            //     btnState.state.value = 0;
                            //   });
                            // }
                          }
                        },
                        child: Container(
                          child: registerChild(),
                        ),
                      );
                    }))),
          ],
        ),
      )),
    );
  }
}
