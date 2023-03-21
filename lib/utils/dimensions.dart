import 'package:get/get.dart';

class Dimensions {
  static double getScreenHeight() => Get.context?.height ?? 0;
  static double getScreenWidth() => Get.context?.width ?? 0;

  static double pageView = getScreenHeight() / 2.64;
  static double pageViewContainer = getScreenHeight() / 3.84;
  static double pageViewTextContainer = getScreenHeight() / 7.03;

//dynamic width
  static double width5 = getScreenWidth() / 28.13;
  static double width10 = getScreenWidth() / 84.4;
  static double width25 = getScreenWidth() / 33.76;
  static double width20 = getScreenWidth() / 33.76;
  static double width30 = getScreenWidth() / 28.13;

//dynamic height
  static double height15 = getScreenHeight() / 56.27;
  static double height45 = getScreenHeight() / 18.76;
  static double height10 = getScreenHeight() / 84.4;
  static double height20 = getScreenHeight() / 42.2;
  static double height30 = getScreenHeight() / 28.13;
  static double height40 = getScreenHeight() / 21.1;

  //font size
  static double font20 = getScreenHeight() / 42.2;
  static double font26 = getScreenHeight() / 32.46;
  static double font16 = getScreenHeight() / 52.75;

  //radious
  static double radius20 = getScreenHeight() / 42.2;
  static double radius30 = getScreenHeight() / 28.13;

  //icon size
  static double iconSize24 = getScreenHeight() / 35.17;
  static double iconSize16 = getScreenHeight() / 52.75;

  //list view size
  static double ListViewImgSize = getScreenWidth() / 2.78;
  static double listViewTextContsize = getScreenWidth() / 3.54;

  //popular food
  static double PopularSalonImgSize = getScreenHeight() / 2.41;

  //Tag and salon info
  static double salonTagInfoPage200 = getScreenHeight() / 4.22;
  static double salonTagInfoPage240 = getScreenHeight() / 3.51;
  static double salonTagInfoPage260 = getScreenHeight() / 3.24;
  static double salonTagInfoPage180 = getScreenHeight() / 4.68;
  static double salonTagInfoPage100 = getScreenHeight() / 8.44;
}
