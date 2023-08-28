import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/firestore/cloudfirestore_methods.dart';
import 'package:YSDirectory/screens/pages/addReviewPage.dart';
import 'package:YSDirectory/screens/pages/home_screen.dart';
import 'package:YSDirectory/screens/pages/profile_page.dart';
import 'package:YSDirectory/utils/constants.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  //final Salon salon;
  const ScreenLayout({
    Key? key,
    //required this.salon,
  }) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;
  Salon? selectedSalon;
  List<Salon> salons = [];

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // changePage(int page) {
  //   pageController.jumpToPage(page);
  //   setState(() {
  //     currentPage = page;
  //   });
  // }

  changePage(int page) {
    if (page == 1) {
      // Navigate to AddReviewPage with the selected salon information
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddReviewPage(
              // salonId: widget.salon.id,
              // selectedSalon: widget.salon.salonName,
              ),
        ),
      );
    } else {
      pageController.jumpToPage(page);
      setState(() {
        currentPage = page;
      });
    }
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
          decoration: const BoxDecoration(
              color: Colors.white10,
              border:
                  Border(top: BorderSide(color: Colors.white10, width: 0.5))),
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
                    size: currentPage == 2 ? 33 : 24,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
