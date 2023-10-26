import 'dart:async';
import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/widgets/app_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/models/review_model.dart';
import 'package:YSDirectory/screens/pages/addReviewPage.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:YSDirectory/widgets/review_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SalonDetailScreen extends StatefulWidget {
  final Function(int) onNoOfReviewUpdated;
  final Salon salon;

  const SalonDetailScreen({
    Key? key,
    required this.salon,
    required this.onNoOfReviewUpdated,
  }) : super(key: key);

  @override
  State<SalonDetailScreen> createState() => _SalonDetailScreenState();
}

class _SalonDetailScreenState extends State<SalonDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _reviewsSubscription;
  int _noOfReview = 0;

  List<Salon> salons = [];
  //double selectedStarRating = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
//review count feature
    _updateReviewCount();

    _reviewsSubscription = FirebaseFirestore.instance
        .collection("salons")
        .doc(widget.salon.id)
        .collection("reviews")
        .snapshots()
        .listen((snapshot) {
      _updateReviewCount();
    });
  }

  void _updateReviewCount() {
    FirebaseFirestore.instance
        .collection("salons")
        .doc(widget.salon.id)
        .collection("reviews")
        .get()
        .then((querySnapshot) {
      setState(() {
        _noOfReview = querySnapshot.docs.length;
      });
      widget.onNoOfReviewUpdated(_noOfReview);
    });

    db.collection('salons').doc(widget.salon.id).get().then((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final salon = Salon.fromJson(data);

        setState(() {
          salons = [salon];
        });
      }
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Bookings',
      }),
    );
    final String emailLaunchString = Uri.encodeFull(emailLaunchUri.toString());
    _launchURL(emailLaunchString);
  }

  void _launchPhone(String phoneNumber) async {
    final Uri _phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    final String _phoneLaunchString = _phoneLaunchUri.toString();
    _launchURL(_phoneLaunchString);
  }

  void _launchMaps(double latitude, double longitude) async {
    final url = 'https://maps.google.com/maps?q=$latitude,$longitude';
    //'https://maps.google.com?q=$latitude,$longitude'; // Google Maps URL (website)
    //final appleMapsurl = 'http://maps.apple.com/?q=$location'; // Apple Maps URL (for iOS)

    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reviewsSubscription.cancel();
    super.dispose();
  }

  void _toggleBookmark() {
    final UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context, listen: false).userDetails;
    final String salonId = widget.salon.id;
    final bool isBookmarked = userDetails.bookmarkedSalonIds.contains(salonId);

    if (isBookmarked) {
      Provider.of<UserDetailsProvider>(context, listen: false)
          .removeBookmark(salonId);
    } else {
      Provider.of<UserDetailsProvider>(context, listen: false)
          .addBookmark(salonId);
    }
    setState(() {
      _isBookmarked = !isBookmarked;
    });
  }

  String mapToString(Map<dynamic, dynamic> map) {
    final buffer = StringBuffer();
    map.forEach((key, value) {
      buffer.write('$key: $value, ');
    });
    final result = buffer.toString();
    return result.isNotEmpty ? result.substring(0, result.length - 2) : '{}';
  }

  List<String> daysOfTheWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: lightBrown,
              pinned: true,
              expandedHeight: 250.0,
              floating: true,
              automaticallyImplyLeading: false,
              iconTheme: const IconThemeData(color: Colors.black),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Chip(
                    label: Text(
                      widget.salon.salonName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'GentiumPlus',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    backgroundColor: brown),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.salon.url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      backgroudColor: tagColor,
                      iconColor: Colors.black,
                      size: 40,
                      iconSize: 20,
                    ),
                  ),
                  GestureDetector(
                      onTap: _toggleBookmark,
                      child: AppIcon(
                        icon: _isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_add_outlined,
                        backgroudColor: tagColor,
                        iconColor: Colors.black,
                        size: 40,
                        iconSize: 20,
                      )),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicator: CircleTabindicator(color: brown, radius: 5),
                tabs: [
                  const Tab(
                    child: Text(
                      "Guide",
                      style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Reviews ($_noOfReview)",
                      style: const TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                  const Tab(
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          Chip(
                            label: Text(
                              widget.salon.category,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'GentiumPlus',
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: tagColor,
                          ),
                          Text(
                            widget.salon.summary,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontFamily: 'GentiumPlus',
                                wordSpacing: 0.6,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                letterSpacing: 0.7),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "General Description",
                            style: TextStyle(
                                fontFamily: 'GentiumPlus',
                                wordSpacing: 0.6,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.salon.salonGeneralDescription,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontFamily: 'GentiumPlus',
                                wordSpacing: 0.6,
                                fontSize: 15,
                                letterSpacing: 0.7),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Services",
                            style: TextStyle(
                              fontFamily: 'GentiumPlus',
                              wordSpacing: 0.6,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  widget.salon.services.entries.map((entry) {
                                final valueText = entry.value is Map
                                    ? mapToString(entry.value)
                                    : entry.value.toString();
                                return RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontFamily: 'GentiumPlus',
                                      wordSpacing: 0.6,
                                      letterSpacing: 0.7,
                                      fontSize: 15,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: entry.key,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'GentiumPlus',
                                        ),
                                      ),
                                      TextSpan(
                                        text: ": $valueText",
                                        style: const TextStyle(
                                          fontFamily: 'GentiumPlus',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 30)
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomMainButton(
                          color: brown,
                          isLoading: false,
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddReviewPage()));
                          }),
                          child: const Text(
                            'Leave a review',
                            style: TextStyle(
                              fontFamily: 'GentiumPlus',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Customer reviews",
                          style: TextStyle(
                              fontFamily: 'GentiumPlus',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.7,
                              wordSpacing: 0.6,
                              fontSize: 16),
                        ),
                        Text(
                          "${widget.salon.totalRating.toStringAsFixed(1)} out of 5",
                          style: const TextStyle(
                            fontFamily: 'GentiumPlus',
                            fontWeight: FontWeight.w500,
                            wordSpacing: 0.6,
                            letterSpacing: 0.6,
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: widget.salon.totalRating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemSize: 20,
                          ignoreGestures: true,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection("salons")
                                .doc(widget.salon.id)
                                .collection("reviews")
                                .orderBy('timestamp', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              } else if (snapshot.hasData) {
                                final data = snapshot.data!;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.docs.length,
                                  itemBuilder: (context, index) {
                                    ReviewModel model = ReviewModel.fromJson(
                                      data.docs[index].data()
                                          as Map<String, dynamic>,
                                    );
                                    return ReviewWidget(
                                      review: model,
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                return const Center(
                                  child: Text('No reviews found.'),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 10, right: 10)),
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.location_on),
                            ),
                            const SizedBox(width: 20.0),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'GentiumPlus',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.salon.location,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 7, 93, 163),
                                      fontFamily: 'GentiumPlus',
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _launchMaps(widget.salon.latitude,
                                            widget.salon.longitude);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 40,
                          thickness: 3,
                          color: lightBrown,
                          indent: 30,
                          endIndent: 30,
                        ),
                        const Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 20, right: 10)),
                            Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.access_time_filled_sharp),
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              'Open Hours:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: 'GentiumPlus'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.only(left: 75, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: daysOfTheWeek.map((day) {
                              String openHours =
                                  widget.salon.openHours[day] ?? "Closed";
                              return RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: 'GentiumPlus',
                                    wordSpacing: 0.6,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '$day:  ',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'GentiumPlus',
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: openHours,
                                      style: const TextStyle(
                                        fontFamily: 'GentiumPlus',
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const Divider(
                          height: 40,
                          thickness: 3,
                          color: lightBrown,
                          indent: 30,
                          endIndent: 30,
                        ),
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 20, right: 5)),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/instagramb.png',
                                width: 24,
                                height: 24,
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'GentiumPlus',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: " Follow:  ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.salon.salonName,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 7, 93, 163),
                                      fontFamily: 'GentiumPlus',
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _launchURL(widget.salon.instagram);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 40,
                          thickness: 3,
                          color: lightBrown,
                          indent: 30,
                          endIndent: 30,
                        ),
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 20, right: 5)),
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.public_rounded),
                            ),
                            const SizedBox(width: 20.0),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'GentiumPlus',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.salon.website,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 7, 93, 163),
                                      fontFamily: 'GentiumPlus',
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _launchURL(widget.salon.website);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 40,
                          thickness: 3,
                          color: lightBrown,
                          indent: 30,
                          endIndent: 30,
                        ),
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 20, right: 5)),
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.phone_rounded),
                            ),
                            const SizedBox(width: 20.0),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'GentiumPlus',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "Call:  ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.salon.number,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'GentiumPlus',
                                      fontSize: 16,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _launchPhone(widget.salon.number);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 40,
                          thickness: 3,
                          color: lightBrown,
                          indent: 30,
                          endIndent: 30,
                        ),
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 20, right: 5)),
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.markunread_rounded),
                            ),
                            const SizedBox(width: 20.0),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontFamily: 'GentiumPlus',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.salon.email,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 7, 93, 163),
                                      fontFamily: 'GentiumPlus',
                                      fontSize: 16,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _launchEmail(widget.salon.email);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          height: 40,
                          thickness: 3,
                          color: lightBrown,
                          indent: 30,
                          endIndent: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 20, right: 10),
                          child: const Text(
                              'This app serves as guidance not as a source of truth.\nPlease make sure you double check with the salons any of the information mentioned here, such as pricing, location and open hours before booking. Lastly, if you do make a booking with of the salons listed let a sis know, i.e. leave a review.',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: 'GentiumPlus')),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleTabindicator extends Decoration {
  final Color color;
  double radius;

  CircleTabindicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cgf) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cgf.size!.width / 2, cgf.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
