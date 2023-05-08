//import 'dart:html';

import 'package:coveredncurly/models/salon_model.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/widgets/app_icon.dart';
import 'package:flutter/material.dart';

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
                        top: 200,
                        left: 70,
                        child: Chip(
                          label: Text(
                            'Hijaby space',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'GentiumPlus',
                                fontSize: 14),
                          ),
                          backgroundColor: tagColor,
                        ))
                  ],
                ),
              ),
              title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                    onTap: _toggleBookmark,
                    child: Icon(_isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_add_outlined)),
              ]),
            ),
            SliverToBoxAdapter(
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Guide"),
                  Tab(text: "Reviews"),
                  Tab(text: "Socials"),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Add your widgets here for the Gallery tab
                  Container(
                    child: Center(
                      child: Text("Guide"),
                    ),
                  ),
                  // Add your widgets here for the Reviews tab
                  Container(
                    child: Center(
                      child: Text("Reviews"),
                    ),
                  ),
                  // Add your widgets here for the Socials tab
                  Container(
                    child: Center(
                      child: Text("Socials"),
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
