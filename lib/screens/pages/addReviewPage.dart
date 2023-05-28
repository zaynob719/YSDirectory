//import 'dart:ffi';

import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:flutter/material.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({Key? key}) : super(key: key);

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  TextEditingController salonController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController inputController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

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
  void dispose() {
    super.dispose();
    salonController.dispose();
    dateController.dispose();
    inputController.dispose();
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
                  const Text(
                    'Which Salon did you attend?',
                    style: TextStyle(fontSize: 16, fontFamily: 'GentiumPlus'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                      controller: salonController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: brown),
                        ),
                        hintText: 'So many salons...',
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'When did you attend?',
                    style: TextStyle(fontSize: 16, fontFamily: 'GentiumPlus'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                      controller: dateController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'When did I go again?')),
                  const SizedBox(
                    height: 20,
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
