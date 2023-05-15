import 'package:coveredncurly/widgets/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:coveredncurly/models/salon_model.dart';

class ResultScreen extends StatelessWidget {
  final String query;

  const ResultScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            const TextSpan(
                text: "Showing results for:   ",
                style: TextStyle(
                  fontFamily: 'GentiumPlus',
                  fontSize: 17,
                  color: Colors.black,
                )),
            TextSpan(
                text: query,
                style: const TextStyle(
                    fontFamily: 'GentiumPlus',
                    fontStyle: FontStyle.italic,
                    fontSize: 17,
                    color: Colors.black))
          ]),
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
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: ((context, index) {
                  return ResultWidget(
                      salonModel: SalonModel(
                          url:
                              "https://firebasestorage.googleapis.com/v0/b/your-salon-directory.appspot.com/o/salons_options_images%2Fysds004.png?alt=media&token=c8f27351-a1af-4fe6-83e7-cd64def476f7",
                          salonName: "MeYou hair",
                          uid: "123",
                          summary:
                              "A private hijabi friendly salon that specialises in afro curly hair",
                          rating: 4,
                          noOfRating: 4,
                          salonDistance: 1.3,
                          noOfReview: 5,
                          //review: 20
                          location: "East Ham, E6 London, UK"));
                })),
          )
        ],
      ),
    );
  }
}
