import 'package:YSDirectory/utils/utils.dart';
import 'package:flutter/material.dart';

class ReviewRatingLocation extends StatelessWidget {
  final int noOfRating;
  final double? salonDistance;
  final int noOfReview;
  const ReviewRatingLocation(
      {Key? key,
      required this.noOfRating,
      this.salonDistance,
      required this.noOfReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    String distanceText = salonDistance != null
        ? "${salonDistance?.toStringAsFixed(2)} mi"
        : "Location disabled"; // Display "N/A" if salonDistance is null

    return SizedBox(
      width: screenSize.width / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.comment,
                  color: Colors.black,
                  size: 17,
                ),
                const SizedBox(width: 5.0),
                Text(
                  noOfReview.toString(),
                  style: const TextStyle(
                      fontSize: 12.0, fontFamily: 'GentiumPlus'),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.black,
                  size: 17,
                ),
                const SizedBox(width: 5.0),
                Text(
                  noOfRating.toString(),
                  style: const TextStyle(
                      fontSize: 12.0, fontFamily: 'GentiumPlus'),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 17,
                ),
                const SizedBox(width: 5.0),
                Text(
                  distanceText,
                  style: const TextStyle(
                      fontSize: 13.0, fontFamily: 'GentiumPlus'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
