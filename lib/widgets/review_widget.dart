import 'package:YSDirectory/models/review_model.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;

  const ReviewWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                backgroundImage: NetworkImage(review.profilePicture),
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
              child: IgnorePointer(
                ignoring: true,
                child: RatingBar.builder(
                  initialRating: review.reviewRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              )),
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
