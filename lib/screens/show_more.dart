import 'package:coveredncurly/screens/result_screen.dart';
import 'package:coveredncurly/utils/constants.dart';
import 'package:coveredncurly/widgets/app_text.dart';
import 'package:coveredncurly/widgets/category_widget.dart';
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
                showSearch(context: context, delegate: DataSerch());
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

class DataSerch extends SearchDelegate<String> {
  final salons = [
    "Curl Talk",
    "Lindsey Hughes",
    "Curly Hair London",
    "Topè Beesley",
    "The Curl Consultant",
    "Spring",
    "McCrory Hair",
    "Curl Confidence",
    "Belle & Blackley",
    "Curly Hair",
    "3Thirty",
    "The Curl Bar",
    "Cornwall Curl Specialist",
    "Ama Hair Salon",
    "The Curl Clinic",
    "Curl Truth",
    "The Curly Look",
    "Mulaax Hair",
    "Unruly Curls",
    "Beyond Curls",
    "Nuala Morey",
    "The Curl Artist",
    "The Curly Way",
    "Natural hair and Loc bar",
    "Faye lawless Hair",
    "Wilderness Hair",
    "Francesco Group",
    "Hair Lounge by Charlotte Mensah",
    "Adornment365",
    "Nayemah Beauty",
    "Elite Hair Lounge",
    "Qurts Hair",
    "Junior Green Hair",
    "Her Definition",
    "Mebu Salon",
    "Adeline Hair and beauty",
    "Purely Natural Hair",
    "André Pierre",
    "Moiso London",
  ];

  final recentSalons = [
    "Qurts Hair",
    "Junior Green Hair",
    "Her Definition",
    "Mebu Salon",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
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
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList = query.isEmpty
        ? recentSalons
        : salons
            .where((p) => p.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.search),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}
