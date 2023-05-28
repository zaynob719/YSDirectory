//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coveredncurly/screens/pages/salon_detail_screen.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/widgets/result_widget.dart';
import 'package:coveredncurly/widgets/review_rating_location.dart';
import 'package:flutter/material.dart';

class PopularSalonswidget extends StatefulWidget {
  const PopularSalonswidget({Key? key}) : super(key: key);

  @override
  State<PopularSalonswidget> createState() => _PopularSalonswidgetState();
}

class _PopularSalonswidgetState extends State<PopularSalonswidget> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<Salon> salons = [];

  @override
  void initState() {
    super.initState();

    db.collection('salons').get().then((snapshot) {
      setState(() {
        salons =
            snapshot.docs.map((doc) => Salon.fromJson(doc.data())).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (salons.isEmpty) {
      return Center(
        child: CircularProgressIndicator(color: brown),
      );
    } else {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SalonDetailScreen(salon: salons[index]),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SalonDetailScreen(salon: salons[index]),
                        ),
                      );
                    },
                    child: Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(salons[index].url),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1.0,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SalonDetailScreen(salon: salons[index]),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 2.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: lightBrown,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1.0,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              salons[index].salonName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'GentiumPlus',
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              salons[index].summary,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontFamily: 'GentiumPlus'),
                            ),
                            ReviewRatingLocation(
                                noOfRating: salons[index].noOfRating,
                                salonDistance: salons[index].distance,
                                noOfReview: salons[index].noOfReview),
                          ],
                        ),
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
}
