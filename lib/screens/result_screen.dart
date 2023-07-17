import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:YSDirectory/widgets/loading_widget.dart';
import 'package:YSDirectory/widgets/result_widget.dart';
import 'package:flutter/material.dart';

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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("salons")
            .where("category", isEqualTo: query)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          } else if (snapshot.hasData) {
            final salons = snapshot.data!.docs.map((doc) {
              return Salon.fromJson(doc.data());
            }).toList();
            if (salons.isEmpty) {
              return Center(
                child: Text(
                  'More salons coming soon!',
                  style: TextStyle(fontFamily: 'GentiumPlus', fontSize: 18),
                ),
              );
            } else {
              return ResultWidget(salons: salons);
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: Text('No results found.'),
            );
          }
        },
      ),
    );
  }
}
