import 'package:coveredncurly/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:coveredncurly/utils/colors.dart';

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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
                  width: 4,
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
                    Icons.search,
                    color: currentPage == 2
                        ? AppColors.secondBrownColor
                        : Colors.black,
                    size: currentPage == 2 ? 33 : 24,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.person,
                    color: currentPage == 3
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
