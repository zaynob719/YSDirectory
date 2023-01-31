import 'package:coveredncurly/screens/pages/add_review_page.dart';
import 'package:coveredncurly/screens/pages/home_salon_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:coveredncurly/screens/pages/my_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [HomeSalonPage(), AddReviewPage(), MyPage()];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 0,
          selectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 240, 240, 240),
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Color.fromARGB(255, 224, 167, 35),
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_rounded,
                  size: 60,
                ),
                label: 'Add review'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: 'My'),
          ]),
    );
  }
}
