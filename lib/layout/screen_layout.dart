import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:YSDirectory/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

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
      length: 3,
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: screens,
        ),
        bottomNavigationBar: Container(
          height: 65,
          decoration: BoxDecoration(
              color: AppColors.tagColor,
              border: Border(
                  top: BorderSide(color: AppColors.tagColor, width: 0.5))),
          child: TabBar(
              indicator: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: AppColors.secondBrownColor,
                  width: 3,
                ),
              )),
              onTap: changePage,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Icon(
                    Icons.home_filled,
                    color: currentPage == 0
                        ? AppColors.secondBrownColor
                        : Colors.black,
                    size: currentPage == 0 ? 33 : 24,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.edit,
                    color: currentPage == 1
                        ? AppColors.secondBrownColor
                        : Colors.black,
                    size: currentPage == 1 ? 33 : 24,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.person,
                    color: currentPage == 2
                        ? AppColors.secondBrownColor
                        : Colors.black,
                    size: currentPage == 3 ? 33 : 24,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
