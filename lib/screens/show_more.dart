import 'package:YSDirectory/screens/view_all_screen.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/screens/pages/salon_detail_screen.dart';
import 'package:YSDirectory/screens/result_screen.dart';
import 'package:YSDirectory/utils/constants.dart';
import 'package:YSDirectory/widgets/app_text.dart';
import 'package:YSDirectory/widgets/category_widget.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:YSDirectory/widgets/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowMore extends StatefulWidget {
  const ShowMore({Key? key}) : super(key: key);

  @override
  State<ShowMore> createState() => _ShowMoreState();
}

void onNoOfReviewUpdated(int noOfReviews) {}

class _ShowMoreState extends State<ShowMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'All categories',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'GentiumPlus',
              fontWeight: FontWeight.w500,
              fontSize: 24),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (() {}),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.1 / 2.2,
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 9),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) => CategoryWidget(index: index),
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.all(4.0),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const viewAllScreen(
          //                   onNoOfReviewUpdated: onNoOfReviewUpdated)),
          //         );
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: orengy,
          //       ),
          //       child: const Text(
          //         'View all salons',
          //         style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 16),
          //       ),
          //     ),
          //   ),
          // ),
        ],
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
