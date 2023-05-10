//import 'dart:html';

import 'package:coveredncurly/models/review_model.dart';
import 'package:coveredncurly/models/salon_model.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:coveredncurly/widgets/app_icon.dart';
import 'package:coveredncurly/widgets/custom_main_button.dart';
import 'package:coveredncurly/widgets/rating_star_widget.dart';
import 'package:coveredncurly/widgets/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:coveredncurly/widgets/review_rating_location.dart';

class SalonDetailScreen extends StatefulWidget {
  final SalonModel salonModel;

  const SalonDetailScreen({Key? key, required this.salonModel})
      : super(key: key);

  @override
  State<SalonDetailScreen> createState() => _SalonDetailScreenState();
}

class _SalonDetailScreenState extends State<SalonDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final String _imageUrl;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.salonModel.url;
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
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
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  widget.salonModel.salonName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: 'GentiumPlus',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(_imageUrl), fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                        top: screenSize.height / 4.3,
                        left: 70,
                        child: Chip(
                          label: Text(
                            'Hijaby space',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'GentiumPlus',
                                fontSize: 12),
                          ),
                          backgroundColor: tagColor,
                        )),
                    Positioned(
                      top: screenSize.height / 6.3,
                      right: screenSize.width / 24.0,
                      child: RatingStarWidget(
                        rating: widget.salonModel.rating,
                        isVertical: true,
                      ),
                    )
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: _toggleBookmark,
                      child: Icon(_isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_add_outlined)),
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
                  Tab(
                      child: Text(
                    "Guide",
                    style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
                  Tab(
                      child: Text(
                    "Reviews (${widget.salonModel.noOfReview})",
                    style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
                  Tab(
                      child: Text(
                    "Socials",
                    style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontFamily: 'GentiumPlus',
                                fontSize: 16,
                                color: Colors.black),
                            children: [
                              TextSpan(text: 'The salon is located in: '),
                              TextSpan(
                                  text: widget.salonModel.location,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              //TextSpan(text: 'Click on socials for directions')
                            ]),
                      )),
                  Column(
                    children: [
                      CustomMainButton(
                          child: Text(
                            'Add salon review ',
                            style: TextStyle(
                                fontFamily: 'GentiumPlus', fontSize: 14),
                          ),
                          color: brown,
                          isLoading: false,
                          onPressed: (() {})),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 40),
                                child: ReviewWidget(
                                  review: ReviewModel(
                                    description:
                                        'Great salon, the staff were friedly and my hair looks beautiful now. Went in for a silk press, will definetly be coming back!',
                                    senderName: 'Zaynob',
                                    attendanceDate: '09/05/2023',
                                    rating: 3,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Add your widgets here for the Socials tab
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontFamily: 'GentiumPlus',
                              fontSize: 16,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: "Booking: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "social media link",
                                style: TextStyle(color: Colors.black)),
                          ]),
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
