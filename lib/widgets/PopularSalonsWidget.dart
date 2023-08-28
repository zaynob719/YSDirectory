import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/screens/pages/salon_detail_screen.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:YSDirectory/widgets/review_rating_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularSalonswidget extends StatefulWidget {
  final Salon? salon;
  final Function(int) onNoOfReviewUpdated;
  const PopularSalonswidget({
    Key? key,
    this.salon,
    required this.onNoOfReviewUpdated,
  }) : super(key: key);

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

  // void _listenToReviewsCount(Salon salon) {
  //   db
  //       .collection('salons')
  //       .doc(salon.id)
  //       .collection('reviews')
  //       .snapshots()
  //       .listen((snapshot) {
  //     setState(() {
  //       salon.noOfReview = snapshot.docs.length;
  //     });
  //     widget.onNoOfReviewUpdated(salon.noOfReview);
  //   });
  // }

  Stream<int> _getReviewCountStream(String salonId) {
    return db
        .collection('salons')
        .doc(salonId)
        .collection('reviews')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Widget build(BuildContext context) {
    // for (var salon in salons) {
    //   _listenToReviewsCount(salon);
    // }
    if (salons.isEmpty) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    } else {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          itemCount: 4,
          itemBuilder: (context, index) {
            final salon = salons[index];
            return StreamBuilder<int>(
              stream: _getReviewCountStream(salon.id),
              builder: (context, snapshot) {
                final noOfReview = snapshot.data ?? 0;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalonDetailScreen(
                          salon: salon,
                          onNoOfReviewUpdated: widget.onNoOfReviewUpdated,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SalonDetailScreen(
                                  salon: salons[index],
                                  onNoOfReviewUpdated:
                                      widget.onNoOfReviewUpdated,
                                ),
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
                                  builder: (context) => SalonDetailScreen(
                                      salon: salons[index],
                                      onNoOfReviewUpdated:
                                          widget.onNoOfReviewUpdated),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 2.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: lightBrown,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: lightBrown,
                                    spreadRadius: 1.0,
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
                                    style: const TextStyle(
                                        fontFamily: 'GentiumPlus',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    salons[index].summary,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'GentiumPlus'),
                                  ),
                                  StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseFirestore.instance
                                        .collection("salons")
                                        .doc(salons[index].id)
                                        .collection("reviews")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container();
                                      } else if (snapshot.hasData) {
                                        final data = snapshot.data!;
                                        int noOfReview = data.docs.length;
                                        return ReviewRatingLocation(
                                          noOfRating: salons[index].noOfRating,
                                          salonDistance: salons[index].distance,
                                          noOfReview: noOfReview,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
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
          });
    }
  }
}
