import 'package:coveredncurly/screens/pages/home_screen.dart';
import 'package:coveredncurly/screens/pages/salon_page_body.dart';
import 'package:coveredncurly/screens/salon/main_salon_detail.dart';
import 'package:coveredncurly/screens/search_screen.dart';
import 'package:flutter/material.dart';

const double kAppBarHeight = 100;

const List<String> categoryList = [
  "Hijaby space",
  "Kids space",
  "Afrocare",
  "Location",
  "Mobile",
  "Ratings",
  "Curls",
  "Essentials",
  "Reservations",
  "Last minute",
];

const List<Widget> screens = [
  HomeScreen(),
  Center(
    child: Text("add review"),
  ),
  SearchScreen(),
  Center(
    child: Text("profile"),
  ),
];

const List<String> newSalonAdd = [
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds002.png?alt=media&token=7b4dc2c1-b277-4652-bc2b-c7243070b379",
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds003.png?alt=media&token=6b4ca5bd-99b4-441a-8bb9-998a1ace3e38",
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds002.png?alt=media&token=7b4dc2c1-b277-4652-bc2b-c7243070b379",
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds003.png?alt=media&token=6b4ca5bd-99b4-441a-8bb9-998a1ace3e38",
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds002.png?alt=media&token=7b4dc2c1-b277-4652-bc2b-c7243070b379",
];

const List<String> appOffersHomePage = [
  "images/add_reviews.png",
  "images/get_discounts.png",
  "images/save_salons.png",
  "images/socials.png",
  "images/send_to_friend.png",
  "images/about_YSD.png",
];

const List<String> appOffersHomePageNames = [
  "Add reviews", // link to add review page. When add review is sent it should direct to the review page so they can read other reviews left there
  "Discounts", // link to YSD discounts
  "Saved", //link to profile
  "Socials", //share to YSD insta
  "Share", // about YSD page on app
  "About us", // link to social media
];

const List<String> favouriteSalonShowcase = [
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds002.png?alt=media&token=7b4dc2c1-b277-4652-bc2b-c7243070b379",
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds003.png?alt=media&token=6b4ca5bd-99b4-441a-8bb9-998a1ace3e38",
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds002.png?alt=media&token=7b4dc2c1-b277-4652-bc2b-c7243070b379",
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds003.png?alt=media&token=6b4ca5bd-99b4-441a-8bb9-998a1ace3e38",
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds002.png?alt=media&token=7b4dc2c1-b277-4652-bc2b-c7243070b379",
];

// const List<String> favouriteSalonShowcaseNames = [
//   "Add reviews", // link to add review page
//   "Discounts", // link to YSD discounts
//   "Reservations", //link to salons that require reservations before you go
//   "Read reviews", //link to list of salons that have reviews
//   "Save", //link to profile
//   "Share", // link to social media
// ];