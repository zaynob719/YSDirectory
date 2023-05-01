//import 'dart:html';
import 'package:coveredncurly/models/salon_model.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/widgets/review_rating_location.dart';
import 'package:coveredncurly/widgets/salon_information_widget.dart';
import 'package:coveredncurly/widgets/salon_summary_widget.dart';
import 'package:flutter/material.dart';

class PopularSalonsWidget extends StatelessWidget {
  final SalonModel salon;
  const PopularSalonsWidget({Key? key, required this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              Container(
                width: 110,
                height: 110,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    salon.url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Text and icons section
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: lightBrown,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SalonInformationWidget(
                        salonName: salon.salonName,
                      ),
                      SalonSummaryWidget(summary: salon.summary),
                      SizedBox(height: 5.0),
                      ReviewRatingLocation(
                        noOfRating: salon.noOfRating,
                        noOfReview: salon.noOfReview,
                        //rating: salon.rating,
                        //review: salon.review,
                        salonDistance: salon.salonDistance,
                      )
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Icon(
                      //           Icons.comment,
                      //           color: Colors.black,
                      //           size: 17,
                      //         ),
                      //         SizedBox(width: 5.0),
                      //         Text(
                      //           '$index reviews',
                      //           style: TextStyle(
                      //               fontSize: 12.0, fontFamily: 'GentiumPlus'),
                      //         ),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Icon(
                      //           Icons.star,
                      //           color: Colors.black,
                      //           size: 17,
                      //         ),
                      //         SizedBox(width: 5.0),
                      //         Text(
                      //           '$index ratings',
                      //           style: TextStyle(
                      //               fontSize: 12.0, fontFamily: 'GentiumPlus'),
                      //         ),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Icon(
                      //           Icons.location_on,
                      //           size: 17,
                      //         ),
                      //         SizedBox(width: 5.0),
                      //         Text(
                      //           '1.5 mi',
                      //           style: TextStyle(
                      //               fontSize: 13.0, fontFamily: 'GentiumPlus'),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
