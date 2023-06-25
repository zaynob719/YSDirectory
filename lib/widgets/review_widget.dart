import 'package:coveredncurly/models/review_model.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/constants.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:coveredncurly/widgets/rating_star_widget.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  const ReviewWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.senderName,
            style: const TextStyle(
              fontFamily: 'GentiumPlus',
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Text(
                  keysOfRating[keysOfRating.indexOf(review.rating)],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GentiumPlus',
                      color: Colors.brown),
                ),
              ],
            ),
          ),
          Text(
            review.reviewController,
            style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Visited on ${review.attendanceDate}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: 'GentiumPlus',
                fontStyle: FontStyle.italic,
                letterSpacing: 0.6),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
