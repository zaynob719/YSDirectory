import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

//dynamic width
  static double width10 = screenWidth / 84.4;
  static double width25 = screenWidth / 33.76;
  static double width20 = screenWidth / 42.2;
  static double width30 = screenWidth / 28.13;

//dynamic height
  static double height15 = screenHeight / 56.27;
  static double height45 = screenHeight / 18.76;
  static double height10 = screenHeight / 84.4;
  static double height30 = screenHeight / 28.13;
  static double height40 = screenHeight / 21.1;
  static double font20 = screenHeight / 42.2;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

  //icon size
  static double iconSize24 = screenHeight / 35.17;
}
