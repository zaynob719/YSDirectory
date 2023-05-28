import 'package:coveredncurly/utils/utils.dart';
import 'package:flutter/material.dart';

class ReviewRatingLocation extends StatelessWidget {
  final int noOfRating;
  final double salonDistance;
  final int noOfReview;
  const ReviewRatingLocation(
      {Key? key,
      required this.noOfRating,
      required this.salonDistance,
      required this.noOfReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SizedBox(
      width: screenSize.width / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(
                  Icons.comment,
                  color: Colors.black,
                  size: 17,
                ),
                SizedBox(width: 5.0),
                Text(
                  noOfReview.toString(),
                  style: TextStyle(fontSize: 12.0, fontFamily: 'GentiumPlus'),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.black,
                  size: 17,
                ),
                SizedBox(width: 5.0),
                Text(
                  noOfRating.toString(),
                  style: TextStyle(fontSize: 12.0, fontFamily: 'GentiumPlus'),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 17,
                ),
                SizedBox(width: 5.0),
                Text(
                  "${salonDistance.toString()} mi",
                  style: TextStyle(fontSize: 13.0, fontFamily: 'GentiumPlus'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
