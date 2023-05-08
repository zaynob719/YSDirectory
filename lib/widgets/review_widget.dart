import 'package:coveredncurly/models/review_model.dart';
import 'package:coveredncurly/utils/constants.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  const ReviewWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Column(
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
        Row(
          children: [
            SizedBox(
              width: screenSize.width / 4,
              child: FittedBox(
                  //child: RatingStarWidget(rating: review.rating),
                  ),
            ),
            Text(
              keysOfRating[review.rating - 1],
            ),
            Text(
              review.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            )
          ],
        )
      ],
    );
  }
}
