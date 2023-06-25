//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coveredncurly/models/review_model.dart';
import 'package:coveredncurly/screens/pages/addReviewPage.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:coveredncurly/widgets/custom_main_button.dart';
import 'package:coveredncurly/widgets/rating_star_widget.dart';
import 'package:coveredncurly/widgets/result_widget.dart';
import 'package:coveredncurly/widgets/review_widget.dart';
import 'package:flutter/material.dart';

class SalonDetailScreen extends StatefulWidget {
  final Salon salon;

  const SalonDetailScreen({Key? key, required this.salon}) : super(key: key);

  @override
  State<SalonDetailScreen> createState() => _SalonDetailScreenState();
}

class _SalonDetailScreenState extends State<SalonDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<Salon> salons = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    db.collection('salons').doc(widget.salon.id).get().then((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final salon =
            Salon.fromJson(data); // Convert the snapshot data to a Salon object

        setState(() {
          salons = [salon];
        });
      }
    });
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: _toggleBookmark,
                    child: Icon(
                      _isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_add_outlined,
                    ),
                  ),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Reviews (${widget.salon.noOfReview})",
                      style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Socials",
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
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        top: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          Chip(
                            label: Text(
                              widget.salon.category,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'GentiumPlus',
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: tagColor,
                          ),
                          Text(
                            widget.salon.summary,
                            style: TextStyle(
                                fontFamily: 'GentiumPlus',
                                wordSpacing: 0.6,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "General Description",
                            style: TextStyle(
                                fontFamily: 'GentiumPlus',
                                wordSpacing: 0.6,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.salon.salonGeneralDescription,
                            style: TextStyle(
                              fontFamily: 'GentiumPlus',
                              wordSpacing: 0.6,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Services",
                            style: TextStyle(
                              fontFamily: 'GentiumPlus',
                              wordSpacing: 0.6,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: widget.salon.services.entries
                                .map((entry) => RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontFamily: 'GentiumPlus',
                                            wordSpacing: 0.6),
                                        children: [
                                          TextSpan(
                                            text: entry.key,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: 'GentiumPlus'),
                                          ),
                                          TextSpan(
                                            text: ": ${entry.value}",
                                            style: TextStyle(
                                                fontFamily: 'GentiumPlus',
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      CustomMainButton(
                        child: Text(
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
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection("salons")
                                .doc(widget.salon.id)
                                .collection("reviews")
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
                                return Center(
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
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 20, right: 10),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'GentiumPlus',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Instagram: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.salon.instagram,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'GentiumPlus',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 20, right: 10),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'GentiumPlus',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Website: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.salon.website,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'GentiumPlus',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 20, right: 10),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'GentiumPlus',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Contact Details: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.salon.number,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'GentiumPlus',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 20, right: 10),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'GentiumPlus',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Email: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.salon.email,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'GentiumPlus',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 20, right: 10),
                          child: const Text(
                            'Open Hours:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'GentiumPlus'),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                widget.salon.openHours.entries.map((entry) {
                              return RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'GentiumPlus',
                                    wordSpacing: 0.6,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${entry.key}: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'GentiumPlus',
                                      ),
                                    ),
                                    TextSpan(
                                      text: entry.value,
                                      style: TextStyle(
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
