//import 'dart:html';
import 'package:coveredncurly/models/salon_model.dart';
import 'package:coveredncurly/screens/pages/salon_detail_screen.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/widgets/review_rating_location.dart';
import 'package:coveredncurly/widgets/salon_information_widget.dart';
import 'package:coveredncurly/widgets/salon_summary_widget.dart';
import 'package:flutter/material.dart';

class PopularSalonsWidget extends StatelessWidget {
  final SalonModel salonModel;
  const PopularSalonsWidget({Key? key, required this.salonModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SalonDetailScreen(
                          salonModel: salonModel,
                        )));
          },
          child: Container(
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
                      salonModel.url,
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
                          salonName: salonModel.salonName,
                        ),
                        SalonSummaryWidget(summary: salonModel.summary),
                        SizedBox(height: 5.0),
                        ReviewRatingLocation(
                          noOfRating: salonModel.noOfRating,
                          salonDistance: salonModel.salonDistance,
                          noOfReview: salonModel.noOfReview,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
