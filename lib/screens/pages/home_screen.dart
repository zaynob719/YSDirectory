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
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;
  late Position _currentPosition;
  //String userLocation = '';
  double userLat = 0.0;
  double userLng = 0.0;

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
        title: Text(
          "Your Salon Directory",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'InknutAntiqua',
            color: Colors.black,
            wordSpacing: 0.10,
          ),
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
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Salons near you ",
                  style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
                style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                  TextSpan(
                    text:
                        'Disclaimer: The information displayed may not be accurate. Please contact the salon specifically for updated information. Read our ',
                    style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontFamily: 'GentiumPlus'),
                    children: [
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Add your logic here for what happens when the user taps the button
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center),
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
