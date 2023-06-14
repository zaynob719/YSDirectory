import 'package:coveredncurly/models/review_model.dart';
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    width: screenSize.width / 4,
                    child: FittedBox(
                      //can add this to be on the right side of the screen (figma)
                      child: RatingStarWidget(
                        rating: review.rating,
                        isVertical: false,
                      ),
                    ),
                  ),
                ),
                Text(
                  keysOfRating[review.rating - 1],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'GentiumPlus'),
                ),
              ],
            ),
          ),
          Text(review.titleController),
          Text(
            review.reviewController,
            //maxLines: 3, should there be a mix line on the review?
            //overflow: TextOverflow.ellipsis,
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
        ],
      ),
    );
  }
}
