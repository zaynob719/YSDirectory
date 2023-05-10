import 'package:coveredncurly/utils/utils.dart';
import 'package:flutter/material.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({Key? key}) : super(key: key);

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  //String _selectedSalon = 'Salon 1';
  DateTime _selectedDate = DateTime.now();

  // Function to show the date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: const Text(
          'Add a Review',
          style: TextStyle(
              fontFamily: 'InknutAntiqua', color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Which Salon did you attend?:',
                    style: TextStyle(fontSize: 16, fontFamily: 'GentiumPlus'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
