import 'dart:async';

import 'package:YSDirectory/widgets/app_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/models/review_model.dart';
import 'package:YSDirectory/screens/pages/addReviewPage.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:YSDirectory/widgets/custom_main_button.dart';
import 'package:YSDirectory/widgets/rating_star_widget.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:YSDirectory/widgets/review_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

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

  void _launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    final String _emailLaunchString =
        Uri.encodeFull(_emailLaunchUri.toString());
    _launchURL(_emailLaunchString);
  }

  void _launchPhone(String phoneNumber) async {
    final Uri _phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    final String _phoneLaunchString = _phoneLaunchUri.toString();
    _launchURL(_phoneLaunchString);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _reviewsSubscription.cancel();
    super.dispose();
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
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
                      ),
                    ),
                  ),
                  const Tab(
                    child: Text(
                      "Find Us",
                      style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
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
                                fontWeight: FontWeight.w600),
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
                            ),
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
                          const SizedBox(height: 25)
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      CustomMainButton(
                        child: const Text(
                          'Write a review',
                          style: TextStyle(
                            fontFamily: 'GentiumPlus',
                            fontSize: 16,
                          ),
                        ),
                        color: brown,
                        isLoading: false,
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddReviewPage(
                                        salonId: widget.salon.id,
                                        selectedSalon: widget.salon.salonName,
                                      )));
                        }),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection("salons")
                                .doc(widget.salon.id)
                                .collection("reviews")
                                .orderBy('attendanceDate', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              } else if (snapshot.hasData) {
                                final data = snapshot.data!;
                                return ListView.builder(
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
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 20, right: 10),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'GentiumPlus',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Instagram: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.salon.instagram,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'GentiumPlus',
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchURL(widget.salon.instagram);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 20, right: 10),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'GentiumPlus',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Website: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.salon.website,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'GentiumPlus',
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchURL(widget.salon.website);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 20, right: 10),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'GentiumPlus',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Contact Details: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.salon.number,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'GentiumPlus',
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchPhone(widget.salon.number);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 20, right: 10),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'GentiumPlus',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Email: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.salon.email,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'GentiumPlus',
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchEmail(widget.salon.email);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 20, right: 10),
                          child: const Text(
                            'Open Hours:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'GentiumPlus'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                widget.salon.openHours.entries.map((entry) {
                              return RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontFamily: 'GentiumPlus',
                                    wordSpacing: 0.6,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${entry.key}: ',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'GentiumPlus',
                                      ),
                                    ),
                                    TextSpan(
                                      text: entry.value,
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
