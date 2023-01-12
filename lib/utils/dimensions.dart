import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

//dynamic width
  static double width5 = screenWidth / 28.13;
  static double width10 = screenWidth / 84.4;
  static double width25 = screenWidth / 33.76;
  static double width20 = screenWidth / 33.76;
  static double width30 = screenWidth / 28.13;

//dynamic height
  static double height15 = screenHeight / 56.27;
  static double height45 = screenHeight / 18.76;
  static double height10 = screenHeight / 84.4;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height40 = screenHeight / 21.1;

  //font
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;

  //radious
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

  //icon size
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;

  //list view size
  static double ListViewImgSize = screenWidth / 2.78;
  static double listViewTextContsize = screenWidth / 3.54;

  //popular food
  static double PopularSalonImgSize = screenHeight / 2.41;

  //Tag and salon info
  static double salonTagInfoPage200 = screenHeight / 4.22;
  static double salonTagInfoPage240 = screenHeight / 3.51;
  static double salonTagInfoPage260 = screenHeight / 3.24;
  static double salonTagInfoPage180 = screenHeight / 4.68;
  static double salonTagInfoPage100 = screenHeight / 8.44;
}
