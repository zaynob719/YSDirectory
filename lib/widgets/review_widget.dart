import 'dart:typed_data';

import 'package:YSDirectory/models/review_model.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/utils/constants.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;

  ReviewWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: lightBrown,
                backgroundImage: NetworkImage(
                  userDetailsModel.profilePicture ??
                      "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fprofileb.png?alt=media&token=91b54dc7-cb7c-4d3e-bf09-5f1247219255&_gl=1*1e0fxe9*_ga*MzE1NDgyMTQyLjE2NzE1NzQ2OTI.*_ga_CW55HF8NVT*MTY5NjUxNDM5Ny4xNzguMS4xNjk2NTIxMjA1LjQ5LjAuMA..",
                ),
              ),
              const SizedBox(width: 10),
              Text(
                review.senderName,
                style: const TextStyle(
                  fontFamily: 'GentiumPlus',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Text(
                  keysOfRating[keysOfRating.indexOf(review.rating)],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GentiumPlus',
                    color: Colors.brown,
                  ),
                ),
              ],
            ),
          ),
          Text(
            review.reviewController,
            style: const TextStyle(fontFamily: 'GentiumPlus', fontSize: 16),
          ),
          const SizedBox(height: 3),
          Text(
            "Visited on ${review.attendanceDate}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: 'GentiumPlus',
              fontStyle: FontStyle.italic,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
