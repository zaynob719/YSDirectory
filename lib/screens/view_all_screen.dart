import 'package:YSDirectory/calculateDistance.dart';
import 'package:YSDirectory/firestore/add_data_firestore.dart';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/screens/pages/salon_detail_screen.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:YSDirectory/widgets/review_rating_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class viewAllScreen extends StatefulWidget {
  final Salon? salon;
  final Function(int) onNoOfReviewUpdated;
  const viewAllScreen({
    Key? key,
    this.salon,
    required this.onNoOfReviewUpdated,
  }) : super(key: key);

  @override
  State<viewAllScreen> createState() => _viewAllScreenState();
}

class _viewAllScreenState extends State<viewAllScreen> {
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
    db.collection('salons').get().then((snapshot) {
      setState(() {
        salons =
            snapshot.docs.map((doc) => Salon.fromJson(doc.data())).toList();
        for (var salon in salons) {
          final calculatedDistance = calculateDistance(
            userDetails.userLat!,
            userDetails.userLng!,
            salon.latitude,
            salon.longitude,
          );
          salonDistances[salon.id] = calculatedDistance;
        }
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
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newDetails =
        Provider.of<UserDetailsProvider>(context, listen: false).userDetails;
    if (newDetails != userDetails) {
      userDetails = newDetails;
      if (userDetails.userLat != null && userDetails.userLng != null) {}
    }
  }

  Stream<int> _getReviewCountStream(String salonId) {
    return db
        .collection('salons')
        .doc(salonId)
        .collection('reviews')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<Position?> _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return newPosition;
    } catch (error) {
      // Handle the error
      print('Error determining position: $error');
      return null;
    }
  }

  Future<void> _updateUserPositionInFirestore(
      double newLat, double newLng) async {
    final userDoc = db.collection('users').doc(firebaseAuth.currentUser!.uid);

    await userDoc.update({
      'userLat': newLat,
      'userLng': newLng,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'View all salons',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'GentiumPlus',
              fontWeight: FontWeight.bold,
              wordSpacing: 0.6,
              letterSpacing: 0.7),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Colors.black38,
            ),
            tooltip:
                "Pull page to refresh. \nFeature measures the raw distance from salon to user, check Maps for added route info.",
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Position? newPosition = await _determinePosition();
          if (newPosition != null &&
              (newPosition.latitude != userDetails.userLat ||
                  newPosition.longitude != userDetails.userLng)) {
            Provider.of<UserDetailsProvider>(context, listen: false)
                .updateUserCity(
                    '${newPosition.latitude}, ${newPosition.longitude}');
            Provider.of<UserDetailsProvider>(context, listen: false)
                .updateUserLat(newPosition.latitude);
            Provider.of<UserDetailsProvider>(context, listen: false)
                .updateUserLng(newPosition.longitude);

            await _updateUserPositionInFirestore(
                newPosition.latitude, newPosition.longitude);
          }
          _fetchSalons();
        },
        child: ListView.builder(
            itemCount: salons.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(2.0),
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
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.3),
                                //     spreadRadius: 1.0,
                                //   )
                                // ],
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
                                  boxShadow: const [
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
                                          return const CupertinoActivityIndicator();
                                        }
                                        if (!snapshot.hasData) {
                                          return const Text(
                                              'No details available');
                                        }
                                        final data = snapshot.data!;
                                        int noOfReview = data.docs.length;
                                        return ReviewRatingLocation(
                                          salon: salon,
                                          totalRating: salon.totalRating,
                                          salonDistance:
                                              salonDistances[salons[index].id],
                                          noOfReview: noOfReview,
                                        );
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
            }),
      ),
    );
  }
}
