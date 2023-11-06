import 'package:YSDirectory/screens/pages/addReviewPage.dart';
import 'package:YSDirectory/screens/pages/home_screen.dart';
import 'package:YSDirectory/screens/pages/profile_page.dart';
import 'package:YSDirectory/screens/show_more.dart';
import 'package:YSDirectory/screens/view_all_screen.dart';
import 'package:flutter/material.dart';

const double kAppBarHeight = 100;

const Color backgroundColor = Color(0xffebecee);

const List<String> categoryList = [
  "Hijabi friendly",
  "Children friendly",
  "Afro + Curly",
  "Mobile",
  "All hair types",
  "Colour specialist",
  "Trichologist",
  "CURLDiD verified",
  "Male friendly",
  "Bridal services"
];

const List<String> categoryLogos = [
  //hijabi
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fhijabi-new.png?alt=media&token=6e3dba87-59b8-48ea-9d01-7770385cd213&_gl=1*t1qq4z*_ga*MzE1NDgyMTQyLjE2NzE1NzQ2OTI.*_ga_CW55HF8NVT*MTY5OTExNDA5My4yNDYuMS4xNjk5MTE0MTcxLjQyLjAuMA..",
  //Children space
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fkids-new.png?alt=media&token=793ba22e-4c48-4a2b-b945-6ddba6b2f6ff",
  //afro care
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fafro-new.png?alt=media&token=a71c3d5d-4b58-4a18-bb09-ef79f068e1ef",
  //mobile
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fmobile-new.png?alt=media&token=6f97ced8-e3e4-4877-9a01-24768b02f913",
  //all hair
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fall_hair.png?alt=media&token=a14beb23-8cbe-4c0b-8578-1fefb088da92",
  //color
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fcolour.png?alt=media&token=811c9445-7328-49f7-bbfd-70a7bd7164e6",
  //trichologist
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Ftrichologist.png?alt=media&token=0c9d6853-c879-465e-b430-f653e47df18c",
  //curlid
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fcurlid.png?alt=media&token=f17b59dd-9592-4809-bc6e-32e6bd18309a",
  //male
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fmale.png?alt=media&token=c4e9f95d-f3f5-4760-a0e2-79dcddc3fdfb",
  //brindal
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fbridal.png?alt=media&token=557ba21d-9493-4966-ba91-665424e173b8",
];

// app navigation bar pages
List<Widget> screens = [
  const HomeScreen(),
  const AddReviewPage(),
  const viewAllScreen(onNoOfReviewUpdated: onNoOfReviewUpdated),
  const ProfilePage(onNoOfReviewUpdated: onNoOfReviewUpdated),
];

// const List<String> appOffersHomePageNames = [
//   "Saved", //link to profile
//   "Contact us", //share to YSD insta
//   "Discounts", // link to YSD discounts
//   "About us", // link to social media
// ];

final daysOfWeek = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];
