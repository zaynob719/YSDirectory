// import 'package:coveredncurly/utils/constants.dart';
// import 'package:coveredncurly/widgets/category_widget.dart';
// import 'package:coveredncurly/widgets/search_bar_widget.dart';
// import 'package:flutter/material.dart';

// class ResultScreen extends StatefulWidget {
//   const ResultScreen({Key? key}) : super(key: key);

//   @override
//   State<ResultScreen> createState() => _ResultScreenState();
// }

// class _ResultScreenState extends State<ResultScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//       elevation: 0,
//       actions: <Widget>[
//         IconButton(
//           onPressed: () {
//             showSearch(context: context, delegate: DataSerch());
//           },
//           icon: Icon(Icons.search),
//         )
//       ],
//     ));
//   }
// }

// class DataSerch extends SearchDelegate<String> {
//   final salons = [
//     "Curl Talk",
//     "Lindsey Hughes",
//     "Curly Hair London",
//     "Topè Beesley",
//     "The Curl Consultant",
//     "Spring",
//     "McCrory Hair",
//     "Curl Confidence",
//     "Belle & Blackley",
//     "Curly Hair",
//     "3Thirty",
//     "The Curl Bar",
//     "Cornwall Curl Specialist",
//     "Ama Hair Salon",
//     "The Curl Clinic",
//     "Curl Truth",
//     "The Curly Look",
//     "Mulaax Hair",
//     "Unruly Curls",
//     "Beyond Curls",
//     "Nuala Morey",
//     "The Curl Artist",
//     "The Curly Way",
//     "Natural hair and Loc bar",
//     "Faye lawless Hair",
//     "Wilderness Hair",
//     "Francesco Group",
//     "Hair Lounge by Charlotte Mensah",
//     "Adornment365",
//     "Nayemah Beauty",
//     "Elite Hair Lounge",
//     "Qurts Hair",
//     "Junior Green Hair",
//     "Her Definition",
//     "Mebu Salon",
//     "Adeline Hair and beauty",
//     "Purely Natural Hair",
//     "André Pierre",
//     "Moiso London",
//   ];

//   final recentSalons = [
//     "Qurts Hair",
//     "Junior Green Hair",
//     "Her Definition",
//     "Mebu Salon",
//   ];

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     return [
//       IconButton(
//           onPressed: () {
//             query = "";
//           },
//           icon: Icon(Icons.clear))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back_ios),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     final suggestionList = query.isEmpty
//         ? recentSalons
//         : salons.where((p) => p.startsWith(query)).toList();

//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//         leading: Icon(Icons.bookmark),
//         title: Text(suggestionList[index]),
//       ),
//       itemCount: suggestionList.length,
//     );
//   }
// }
