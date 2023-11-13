import 'package:YSDirectory/widgets/compound_query_A.dart';
import 'package:YSDirectory/widgets/compound_query_H.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/screens/pages/salon_detail_screen.dart';
import 'package:YSDirectory/screens/show_more.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/widgets/PopularSalonsWidget.dart';
import 'package:YSDirectory/widgets/banner_add_widget.dart';
import 'package:YSDirectory/widgets/category_chip_widget.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;

  void resetSelectedCategory() {
    setState(() {
      selectedCategory = null;
    });
  }

  void onNoOfReviewUpdated(int noOfReviews) {}
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Your Salon Directory",
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'InknutAntiqua',
              color: Colors.black,
              wordSpacing: 0.10,
              letterSpacing: 0.7),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: DataSearch(
                      onNoOfReviewUpdated: onNoOfReviewUpdated,
                    ));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CategoryChipWidget(),
            const BannerAddWidget(),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: 430,
                child: PopularSalonswidget(
                  onNoOfReviewUpdated: onNoOfReviewUpdated,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hijabi friendly",
                  style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: CompoundQueryH(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Afro + Curly care",
                  style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: CompoundQueryA(),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShowMore()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orengy,
              ),
              child: const Text(
                'Show more',
                style: TextStyle(
                    fontFamily: 'GentiumPlus',
                    fontSize: 16,
                    wordSpacing: 0.6,
                    letterSpacing: 0.7),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final Function(int) onNoOfReviewUpdated;

  DataSearch({required this.onNoOfReviewUpdated});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show the results based on the query
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('salons').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CupertinoActivityIndicator());
        }

        final List<DocumentSnapshot> suggestions = snapshot.data!.docs
            .where((doc) => doc['salonName']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final salon = Salon.fromJson(
                suggestions[index].data() as Map<String, dynamic>);
            return ListTile(
              leading: const Icon(Icons.search),
              title: Text(
                salon.salonName,
                style: const TextStyle(fontFamily: 'GentiumPlus'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SalonDetailScreen(
                      salon: salon,
                      onNoOfReviewUpdated: onNoOfReviewUpdated,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
