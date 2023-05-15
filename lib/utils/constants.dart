import 'package:coveredncurly/models/salon_model.dart';
import 'package:coveredncurly/screens/pages/addReviewPage.dart';
import 'package:coveredncurly/screens/pages/home_screen.dart';
import 'package:coveredncurly/screens/pages/profile_page.dart';
import 'package:coveredncurly/screens/pages/salon_page_body.dart';
import 'package:coveredncurly/screens/result_screen.dart';
import 'package:coveredncurly/screens/salon/main_salon_detail.dart';
import 'package:coveredncurly/screens/show_more.dart';
import 'package:coveredncurly/widgets/PopularSalonsWidget.dart';
import 'package:flutter/material.dart';

const double kAppBarHeight = 100;

const Color backgroundColor = Color(0xffebecee);

const List<String> categoryList = [
  "Hijabi space",
  "Kids space",
  "Afrocare",
  "Location",
  "Mobile",
  "Ratings",
  "Curls",
  "Last minute",
  "Essentials"
];

const List<String> categoryLogos = [
  //hijabi
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fhijabi.png?alt=media&token=3f4c8172-d060-465f-b1ad-252089fa4e6b",
  //kids space
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fkid%20friendly.png?alt=media&token=15a5e8b6-3ce3-462b-a5af-6b5ce94734b5",
  //afro care
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fafro.png?alt=media&token=c2227ddf-0d9e-40ed-b270-4ff5306ff1a2",
  //location
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Flocation.png?alt=media&token=66d8cbb2-3640-4337-8c3d-d5c1936b735a",
  //mobile
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fmobile.png?alt=media&token=ce9ece8b-2be4-4493-a648-49ce168ada7e",
  //ratings
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Frating.png?alt=media&token=6f92532a-6aa6-47c3-9e6a-1c93679df86f",
  //curls
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fcurls.png?alt=media&token=d372e898-9a0c-48ff-bb1c-19471767a0dd",
  //last minute
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Flast%20minute.png?alt=media&token=d802f984-6e5c-49ee-9951-c2dd2e2ac90c",
  //essential
  "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fessential.png?alt=media&token=71b2ba4c-799c-4126-9d45-c56e5e44efa7",
];

// app navigation bar pages
const List<Widget> screens = [
  HomeScreen(),
  AddReviewPage(),
  ProfilePage(),
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

List<String> keysOfRating = [
  "Very bad",
  "Poor",
  "Average",
  "Good",
  "Excellent"
];
