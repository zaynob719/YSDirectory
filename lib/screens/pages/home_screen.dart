import 'package:coveredncurly/models/salon_model.dart';
import 'package:coveredncurly/screens/show_more.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/widgets/PopularSalonsWidget.dart';
import 'package:coveredncurly/widgets/banner_add_widget.dart';
import 'package:coveredncurly/widgets/category_chip_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          text: TextSpan(
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'InknutAntiqua',
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'YS',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'Directory',
                style: TextStyle(
                  color: brown,
                ),
              ),
            ],
          ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryChipWidget(
              categoryList: [
                "Hijaby space",
                "Kids space",
                "Afrocare",
                "Location",
                "Mobile",
                "Ratings",
                "Curls",
                "Essentials",
                "Last minute",
              ],
            ),
            const BannerAddWidget(),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Popular Salons",
                  style: TextStyle(
                      fontFamily: 'InknutAntiqua',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: PopularSalonsWidget(
                  salon: SalonModel(
                url:
                    "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds004.png?alt=media&token=c8f27351-a1af-4fe6-83e7-cd64def476f7",
                salonName: "MeYou hair",
                uid: "123",
                summary:
                    "A private hijabi friendly salon that specialises in afro curly hair",
                //rating: 2,
                noOfRating: 3,
                salonDistance: 1.3,
                noOfReview: 20,
                //review: 20
              )),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowMore()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: brown,
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
        : salons.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.bookmark),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}
