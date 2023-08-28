import 'package:YSDirectory/screens/pages/salon_detail_screen.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/review_rating_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:YSDirectory/main.dart';

class ResultWidget extends StatefulWidget {
  final List<Salon> salons;
  final Function(int) onNoOfReviewUpdated;

  const ResultWidget({
    Key? key,
    required this.salons,
    required this.onNoOfReviewUpdated,
  }) : super(key: key);

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  double? distanceInMeter = 0.0;
  Position? _currentUserPosition;

  Future _getDistance() async {
    Position? _currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(_currentUserPosition.latitude);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.salons.isEmpty) {
      return const Center(
        child: CupertinoActivityIndicator(color: brown),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: widget.salons.length,
        itemBuilder: (context, index) {
          return StreamBuilder<int>(
            stream: widget.salons[index].noOfReviewStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int noOfReview = snapshot.data!;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalonDetailScreen(
                          salon: widget.salons[index],
                          onNoOfReviewUpdated: widget.onNoOfReviewUpdated,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SalonDetailScreen(
                                  salon: widget.salons[index],
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
                                image: NetworkImage(widget.salons[index].url),
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
                                    salon: widget.salons[index],
                                    onNoOfReviewUpdated:
                                        widget.onNoOfReviewUpdated,
                                  ),
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
                                    color: lightBrown,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.salons[index].salonName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'GentiumPlus',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.salons[index].summary,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontFamily: 'GentiumPlus'),
                                  ),
                                  ReviewRatingLocation(
                                    noOfRating: widget.salons[index].noOfRating,
                                    salonDistance:
                                        widget.salons[index].distance,
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
  //final String address;
  final String location;
  final double latitude;
  final double longitude;
  final String summary;
  final int noOfRating;
  final double distance;
  final int rating;
  final String salonGeneralDescription;
  final Map services;
  final String id;
  final String category;
  final String website;
  final String instagram;
  final String number;
  final String email;
  final Map openHours;
  Stream<int> get noOfReviewStream => FirebaseFirestore.instance
      .collection('salons')
      .doc(id)
      .collection('reviews')
      .snapshots()
      .map((snapshot) => snapshot.docs.length);

  Salon({
    required this.salonName,
    //required this.address,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.summary,
    required this.salonGeneralDescription,
    required this.id,
    required this.url,
    required this.category,
    required this.distance,
    required this.noOfRating,
    required this.rating,
    required this.website,
    required this.services,
    required this.instagram,
    required this.number,
    required this.email,
    required this.openHours,
  });

  factory Salon.fromJson(Map<String, dynamic> json) {
    return Salon(
      salonName: json['salonName'] as String? ?? '',
      //address: json['address'] as String? ?? '',
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
      rating: json['rating'] as int? ?? 0,
      distance: json['distance'] != null
          ? double.parse(json['distance'].toString())
          : 0.0,
      id: json['id'] as String? ?? '',
      website: json['website'] as String? ?? '',
      instagram: json['instagram'] as String? ?? '',
      number: json['number'] as String? ?? '',
      email: json['email'] as String? ?? '',
      openHours: json['openHours'] as Map<dynamic, dynamic>? ?? {},
      services: json['services'] as Map<dynamic, dynamic>? ?? {},
    );
  }
}
