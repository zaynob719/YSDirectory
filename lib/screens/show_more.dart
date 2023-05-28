import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coveredncurly/screens/pages/salon_detail_screen.dart';
import 'package:coveredncurly/screens/result_screen.dart';
import 'package:coveredncurly/utils/constants.dart';
import 'package:coveredncurly/widgets/app_text.dart';
import 'package:coveredncurly/widgets/category_widget.dart';
import 'package:coveredncurly/widgets/result_widget.dart';
import 'package:coveredncurly/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class ShowMore extends StatefulWidget {
  const ShowMore({Key? key}) : super(key: key);

  @override
  State<ShowMore> createState() => _ShowMoreState();
}

class _ShowMoreState extends State<ShowMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'All Categories',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'GentiumPlus',
              fontWeight: FontWeight.w500,
              fontSize: 24),
        ),
        leading: IconButton(
          icon: Icon(
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
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      body: GestureDetector(
        onTap: (() {}),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.2 / 3.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemCount: categoryList.length,
            itemBuilder: (context, index) => CategoryWidget(index: index),
          ),
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
          return Center(child: CircularProgressIndicator());
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
