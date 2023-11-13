import 'package:YSDirectory/calculateDistance.dart';
import 'package:YSDirectory/models/review_model.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/screens/pages/salon_detail_screen.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/review_rating_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultWidget extends StatefulWidget {
  final Salon? salon;
  final Function(int) onNoOfReviewUpdated;
  final String? query;

  const ResultWidget({
    Key? key,
    this.salon,
    this.query,
    required this.onNoOfReviewUpdated,
  }) : super(key: key);

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<Salon> salons = [];
  late UserDetailsModel userDetails;
  Map<String, double> salonDistances = {};

  @override
  void initState() {
    super.initState();
    userDetails =
        Provider.of<UserDetailsProvider>(context, listen: false).userDetails;
    if (userDetails.userLat != null && userDetails.userLng != null) {
      _fetchSalons();
    }
  }

  void _fetchSalons() {
    db
        .collection('salons')
        .where("category", isEqualTo: widget.query)
        .get()
        .then((snapshot) {
      setState(() {
        salons =
            snapshot.docs.map((doc) => Salon.fromJson(doc.data())).toList();
      });

      for (var salon in salons) {
        final calculatedDistance = calculateDistance(
          userDetails.userLat!,
          userDetails.userLng!,
          salon.latitude,
          salon.longitude,
        );
        salonDistances[salon.id] = calculatedDistance;
      }
      // Iterate through the salons to calculate totalRating
      for (var salon in salons) {
        salon.calculateTotalRating().then((_) {
          // Notify the widget that the totalRating has been updated
          setState(() {});
        }).catchError((error) {
          // Handle any errors that may occur during the calculation
          print("Error calculating totalRating: $error");
        });
      }
      salons.sort((a, b) => (salonDistances[a.id] ?? double.infinity)
          .compareTo(salonDistances[b.id] ?? double.infinity));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newDetails =
        Provider.of<UserDetailsProvider>(context, listen: false).userDetails;
    if (newDetails != userDetails) {
      userDetails = newDetails;
      if (userDetails.userLat != null && userDetails.userLng != null) {
        // _fetchSalons();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (salons.isEmpty) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: salons.length,
        itemBuilder: (context, index) {
          final salon = salons[index];
          return StreamBuilder<int>(
            stream: salons[index].noOfReviewStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int noOfReview = snapshot.data!;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalonDetailScreen(
                          salon: salons[index],
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
                                ),
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
                                        widget.onNoOfReviewUpdated,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 2.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: lightBrown,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: lightBrown,
                                    spreadRadius: 1.0,
                                  ),
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
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    salons[index].summary,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'GentiumPlus'),
                                  ),
                                  ReviewRatingLocation(
                                    totalRating:
                                        salon.totalRating, //average rating
                                    salon: salon,
                                    salonDistance:
                                        salonDistances[salons[index].id],
                                    noOfReview: noOfReview,
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
              } else {
                return Container();
              }
            },
          );
        },
      );
    }
  }
}

class Salon {
  final String url;
  final String salonName;
  final String location;
  final double latitude;
  final double longitude;
  final String summary;
  final int noOfRating;
  double totalRating;
  final String salonGeneralDescription;
  final Map services;
  final String id;
  final String category;
  final String website;
  final String instagram;
  final String number;
  final String email;
  final Map openHours;
  final int noOfReview;
  final Timestamp timestamp;

  Stream<int> get noOfReviewStream => FirebaseFirestore.instance
      .collection('salons')
      .doc(id)
      .collection('reviews')
      .snapshots()
      .map((snapshot) => snapshot.docs.length);

  Future<void> updateNoOfReview(int newReviewCount) async {
    await FirebaseFirestore.instance.collection('salons').doc(id).update({
      'noOfReview': newReviewCount,
    });
  }

  Future<void> calculateTotalRating() async {
    final reviewsSnapshot = await FirebaseFirestore.instance
        .collection('salons')
        .doc(id)
        .collection('reviews')
        .get();

    double totalRating = 0.0;

    for (final reviewDocument in reviewsSnapshot.docs) {
      final reviewData = reviewDocument.data();
      final reviewRating = reviewData['reviewRating'] as double?;
      if (reviewRating != null) {
        totalRating += reviewRating;
      }
    }

    if (reviewsSnapshot.docs.isNotEmpty) {
      totalRating /= reviewsSnapshot.docs.length;
    }

    this.totalRating = totalRating;

    await FirebaseFirestore.instance.collection('salons').doc(id).update({
      'totalRating': totalRating,
    });
  }

  Salon({
    required this.salonName,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.summary,
    required this.salonGeneralDescription,
    required this.id,
    required this.url, //image
    required this.category,
    required this.noOfRating,
    required this.noOfReview, //counts total reviews (salon detail page)
    required this.totalRating, //avarage rating (salon list view)
    required this.website,
    required this.services,
    required this.instagram,
    required this.number,
    required this.email,
    required this.openHours,
    required this.timestamp,
  });

  factory Salon.fromJson(Map<String, dynamic> json) {
    return Salon(
      salonName: json['salonName'] as String? ?? '',
      location: json['location'] as String? ?? '',
      latitude: json['latitude'] != null
          ? double.parse(json['latitude'].toString())
          : 0.0,
      longitude: json['longitude'] != null
          ? double.parse(json['longitude'].toString())
          : 0.0,
      summary: json['summary'] as String? ?? '',
      salonGeneralDescription: json['salonGeneralDescription'] as String? ?? '',
      url: json['url'] as String? ?? '',
      category: json['category'] as String? ?? '',
      noOfRating: json['noOfRating'] as int? ?? 0,
      totalRating: (json['totalRating'] as num?)?.toDouble() ?? 0.0,
      id: json['id'] as String? ?? '',
      website: json['website'] as String? ?? '',
      instagram: json['instagram'] as String? ?? '',
      number: json['number'] as String? ?? '',
      email: json['email'] as String? ?? '',
      openHours: json['openHours'] as Map<dynamic, dynamic>? ?? {},
      services: json['services'] as Map<dynamic, dynamic>? ?? {},
      timestamp: json['timestamp'] as Timestamp,
      noOfReview: json['noOfReview'] as int? ?? 0,
    );
  }
}
