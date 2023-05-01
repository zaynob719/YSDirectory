// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';
// import 'package:intl/intl.dart';
//import 'package:coveredncurly/utils/utils.dart';

// class AddReviewPage extends StatefulWidget {
//   const AddReviewPage({Key? key}) : super(key: key);

//   @override
//   _AddReviewPageState createState() => _AddReviewPageState();
// }

// class _AddReviewPageState extends State<AddReviewPage> {
//   // Default selected values for dropdowns
//   String _selectedSalon = 'Salon 1';
//   DateTime _selectedDate = DateTime.now();

//   // Function to show the date picker dialog
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: _selectedDate,
//         firstDate: DateTime(2000),
//         lastDate: DateTime.now());
//     if (picked != null && picked != _selectedDate)
//       setState(() {
//         _selectedDate = picked;
//       });
//   }

//   @override
//   Widget build(BuildContext context) {

//Size screenSize = Utils().getScreenSize();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Review'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   CircleAvatar(
//                     radius: 25,
//                     backgroundImage: AssetImage('images/logo.png'),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Choose the Salon:',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   DropdownButton<String>(
//                     value: _selectedSalon,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedSalon = newValue!;
//                       });
//                     },
//                     items: <String>[
//                       'Salon 1',
//                       'Salon 2',
//                       'Salon 3',
//                     ].map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'When did you attend:',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   GestureDetector(
//                     onTap: () => _selectDate(context),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_today),
//                         SizedBox(width: 8),
//                         Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Review:',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   Expanded(
//                     child: TextFormField(
//                       maxLines: null,
//                       keyboardType: TextInputType.multiline,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Write your review here...',
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           // Add your cancel review function here
//                         },
//                         child: Text('Cancel'),
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.grey[400],
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Add your submit review function here
//                         },
//                         child: Text('Add Review'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
