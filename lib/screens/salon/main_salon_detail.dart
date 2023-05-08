// import 'package:coveredncurly/models/salon_model.dart';
// import 'package:coveredncurly/utils/colors.dart';
// import 'package:coveredncurly/widgets/app_icon.dart';
// import 'package:flutter/material.dart';

// class MyTabbedPage extends StatefulWidget {
//   final SalonModel salonModel;
  
//   const MyTabbedPage({Key? key, required this.salonModel}): 
//   super(key: key)

//   @override
//   State<MyTabbedPage> createState() => _MyTabbedPageState();
// }

// class _MyTabbedPageState extends State<MyTabbedPage>
//     with SingleTickerProviderStateMixin {
//   static const List<Tab> myTabs = <Tab>[
//     Tab(
//       text: 'Guide',
//       icon: Icon(Icons.note),
//     ),
//     Tab(
//       text: 'Reviews',
//       icon: Icon(Icons.comment),
//     ),
//     Tab(
//       text: 'Socials',
//       icon: Icon(Icons.link),
//     ),
//   ];

//   late TabController _tabController;
//   late final String _imageUrl;
//   bool _isGuideSelected = true;
//   bool _isReviewSelected = false;
//   bool _isSocialsSelected = false;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: myTabs.length);
//     _imageUrl = widget.salonModel.url;
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: lightBrown,
//             pinned: true,
//             expandedHeight: 250.0,
//             flexibleSpace: FlexibleSpaceBar(
//               centerTitle: false,
//               title: Text(
//                 widget.salonModel.salonName,
//                 style: const TextStyle(
//                     fontFamily: 'GentiumPlus',
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24),
//               ),
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: NetworkImage(_imageUrl), fit: BoxFit.cover),
//                     ),
//                   ),
//                   Positioned(
//                       top: 200,
//                       left: 70,
//                       child: Chip(
//                         label: Text(
//                           'hijaby friendly',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: 'GentiumPlus',
//                               fontSize: 14),
//                         ),
//                         backgroundColor: tagColor,
//                       ))
//                 ],
//               ),
//             ),
//             title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AppIcon(icon: Icons.clear),
//                   AppIcon(icon: Icons.bookmark_add_outlined),
//                 ]),
//           ),
//         ];


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: myTabs,
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: myTabs.map((Tab tab) {
//           final String label = tab.text!.toLowerCase();
//           return Center(
//             child: Text(
//               'This is the $label tab',
//               style: const TextStyle(fontSize: 36),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
