import 'package:flutter/material.dart';
import 'package:funlearn/screens/leaderboard.dart';
import 'package:funlearn/screens/profileandAssignment.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController controller = new PageController();
  int page = 0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.cyan[800],
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          currentIndex: page,
          onTap: (value) {
            setState(() {
              page = value;
            });
            controller.animateToPage(page,
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: "My Class",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: "Leaderboard",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ]),
      body: PageView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        onPageChanged: (val){
          setState(() {
            page = val;
          });
        },
        children: [
          MainScreen(),
          Leaderboard(),
          Container(),
        ],
      ),
    );
  }
}
