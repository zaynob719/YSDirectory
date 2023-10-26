import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:YSDirectory/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  changePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    CloudFirestoreClass().getNameAndCity();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsProvider>(context).getData();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: screens,
        ),
        bottomNavigationBar: Container(
          height: 65,
          decoration: const BoxDecoration(
              color: Colors.white10,
              border:
                  Border(top: BorderSide(color: Colors.white10, width: 0.5))),
          child: TabBar(
              indicator: const BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              )),
              onTap: changePage,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Icon(
                    Icons.home_filled,
                    color: currentPage == 0 ? Colors.black : Colors.grey,
                    size: currentPage == 0 ? 33 : 24,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.edit,
                    color: currentPage == 1 ? Colors.black : Colors.grey,
                    size: currentPage == 1 ? 33 : 24,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.format_list_bulleted_rounded,
                    color: currentPage == 2 ? Colors.black : Colors.grey,
                    size: currentPage == 2 ? 33 : 24,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.person,
                    color: currentPage == 3 ? Colors.black : Colors.grey,
                    size: currentPage == 3 ? 33 : 24,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
