import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/dimensions.dart';
import 'package:coveredncurly/widgets/app_icon.dart';
import 'package:coveredncurly/widgets/big_text.dart';
import 'package:coveredncurly/widgets/expandable_text_widget.dart';
import 'package:coveredncurly/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainSalonDetail extends StatelessWidget {
  const MainSalonDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 100,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                Positioned(
                  child: (Column(
                    children: [
                      BigText(
                        text: "Salon Name",
                        color: Colors.white,
                      ),
                    ],
                  )),
                ),
                AppIcon(icon: Icons.bookmark_add_outlined),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //guide
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.width30),
                        padding: EdgeInsets.only(
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.secondBrownColor),
                        child: Row(
                          children: [
                            Icon(
                              Icons.note,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            SmallText(
                              text: "Guide",
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      //reviews
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.tagColor),
                        child: Row(
                          children: [
                            Icon(
                              Icons.reviews_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            SmallText(text: "Reviews")
                          ],
                        ),
                      ),
                      //socials
                      Container(
                        margin: EdgeInsets.only(right: Dimensions.width30),
                        padding: EdgeInsets.only(
                            top: Dimensions.height10 / 2,
                            bottom: Dimensions.height10 / 2,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.tagColor),
                        child: Row(
                          children: [
                            Icon(
                              Icons.link_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            SmallText(text: "Socials")
                          ],
                        ),
                      ),
                    ]),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20)),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.secondBrownColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
              "images/blacksalon.jpeg",
              width: double.maxFinite,
              fit: BoxFit.cover,
            )),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: BigText(text: "General information"),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: SmallText(
                    text:
                        "Committed to providing first class service Afro Hair Care and Maintenance.Owner Charlotte Mensah Manketti (specialises in Afro hair), trained at London College of Fashion, has been crowned ‘Afro Hairdresser of the Year’.\nBooking via email, found on their website and deposit is required. Charlotte has an Oil hair care range designed for Afro, mixed and all curly hair types (Organic, Ethical, and sustainable sourced oils)."),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: BigText(text: "Price & service"),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: SmallText(
                    text:
                        "Committed to providing first class service Afro Hair Care and Maintenance.Owner Charlotte Mensah Manketti (specialises in Afro hair), trained at London College of Fashion, has been crowned ‘Afro Hairdresser of the Year’.\nBooking via email, found on their website and deposit is required. Charlotte has an Oil hair care range designed for Afro, mixed and all curly hair types (Organic, Ethical, and sustainable sourced oils)."),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: BigText(text: "More"),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: SmallText(
                    text:
                        "Committed to providing first class service Afro Hair Care and Maintenance. Owner Charlotte Mensah Manketti (specialises in Afro hair), trained at London College of Fashion, has been crowned ‘Afro Hairdresser of the Year’.\nBooking via email, found on their website and deposit is required. Charlotte has an Oil hair care range designed for Afro, mixed and all curly hair types (Organic, Ethical, and sustainable sourced oils)."),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: BigText(text: "Disclaimer"),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: SmallText(
                    text:
                        "Committed to providing first class service Afro Hair Care and Maintenance. Owner Charlotte Mensah Manketti (specialises in Afro hair), trained at London College of Fashion, has been crowned ‘Afro Hairdresser of the Year’."),
              ),
              SizedBox(
                height: 30,
              )
            ]),
          )
        ],
      ),
    );
  }
}
