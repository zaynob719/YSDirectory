import 'package:YSDirectory/models/user_details_model.dart';
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
import 'package:YSDirectory/utils/constants.dart';
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

  void resetSelectedCategory() {
    setState(() {
      selectedCategory = null;
    });
  }

  @override
  void initState() {
    super.initState(); // Call the method to disable screenshots
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
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'InknutAntiqua',
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'YS',
                style: TextStyle(
                  color: brown,
                ),
              ),
              TextSpan(
                text: 'Directory',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CategoryChipWidget(),
            BannerAddWidget(),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Trending Salons ",
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
              child: Container(
                height: 430,
                child: PopularSalonswidget(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowMore()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orengy,
              ),
              child: Text(
                'Show more',
                style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                  TextSpan(
                    text:
                        'Disclaimer: The information displayed may not be accurate. Please contact the salon specifically for updated information. Read our ',
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontFamily: 'GentiumPlus'),
                    children: [
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(
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

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
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
          return Center(child: CupertinoActivityIndicator());
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
              leading: Icon(Icons.search),
              title: Text(
                salon.salonName,
                style: TextStyle(fontFamily: 'GentiumPlus'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SalonDetailScreen(salon: salon),
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
