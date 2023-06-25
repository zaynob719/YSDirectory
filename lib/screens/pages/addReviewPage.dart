import 'package:coveredncurly/models/review_model.dart';
import 'package:coveredncurly/provider/user_details_provider.dart';
import 'package:coveredncurly/firestore/cloudfirestore_methods.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/constants.dart';
import 'package:coveredncurly/widgets/custom_main_button.dart';
import 'package:coveredncurly/widgets/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddReviewPage extends StatefulWidget {
  final String? selectedSalon;
  final String? salonId;
  AddReviewPage({Key? key, this.selectedSalon, this.salonId}) : super(key: key);

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  late String selectedValue;
  List<String> listItem = [];
  double value = 0.0;
  late String salonId;
  int? rating;
  late DateTime attendanceDate;
  late String selectedRatingKey = '';

  @override
  void initState() {
    super.initState();
    selectedValue = '';
    fetchSalonNames().then((_) {
      setState(() {
        selectedValue = widget.selectedSalon ?? '';
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        attendanceDate = value;
      });
    });
  }

  final format = DateFormat("dd-MMMM-yyyy");
  final TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    reviewController.dispose();
  }

  Future<void> fetchSalonNames() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('salons').get();

    final List<String> salonNames = snapshot.docs
        .map((doc) =>
            Salon.fromJson(doc.data() as Map<String, dynamic>).salonName)
        .toList();

    setState(() {
      listItem = salonNames.map((value) => value.trim()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    String hint = selectedValue.isNotEmpty ? 'Select a salon' : 'humm...';
    final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
        GlobalKey<ScaffoldMessengerState>();
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Write a review",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'InknutAntiqua',
                fontSize: 20,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose a salon',
                  style: TextStyle(
                      fontFamily: 'GentiumPlus',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                DropdownButton<String>(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(10),
                  hint: Text(hint),
                  value: selectedValue.isNotEmpty ? selectedValue : null,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue ?? '';
                    });
                  },
                  items: listItem.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontFamily: 'GentiumPlus',
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('When was your appointment?',
                          style: TextStyle(
                              fontFamily: 'GentiumPlus',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DateTimeField(
                      format: format,
                      style: TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      initialValue: _dateTime,
                      onChanged: (selectedDate) {
                        setState(() {
                          _dateTime = selectedDate!;
                        });
                      },
                      onShowPicker: (context, currentValue) async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: currentValue ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: brown,
                                  onPrimary: lightBrown,
                                  error: Colors.red,
                                  onError: Colors.red,
                                  onSurface: Colors.black,
                                ),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child ?? Container(),
                            );
                          },
                        );
                        if (selectedDate != null) {
                          setState(() {
                            attendanceDate = selectedDate;
                            _dateTime = DateTime(selectedDate.year,
                                selectedDate.month, selectedDate.day);
                          });
                        }
                        return selectedDate;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'How would you rate it?',
                        style: TextStyle(
                            fontFamily: 'GentiumPlus',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RatingStars(
                        value: value,
                        onValueChanged: (v) {
                          setState(() {
                            value = v;
                            selectedRatingKey = keysOfRating[value.toInt() - 1];
                          });
                        },
                        starBuilder: (index, color) {
                          if (index < value.toInt()) {
                            return Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          } else {
                            return Icon(
                              Icons.star_outline_sharp,
                              color: Colors.amber,
                            );
                          }
                        },
                        starCount: 5,
                        starSize: 25,
                        valueLabelColor: const Color(0xff9b9b9b),
                        valueLabelTextStyle: const TextStyle(
                            color: Colors.white, fontFamily: 'GentiumPlus'),
                        valueLabelRadius: 10,
                        maxValue: 5,
                        starSpacing: 2,
                        maxValueVisibility: true,
                        valueLabelVisibility: true,
                        animationDuration: Duration(milliseconds: 1000),
                        valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        valueLabelMargin: const EdgeInsets.only(right: 8),
                        starOffColor: Color(0xffe7e8ea),
                        starColor: Colors.amber,
                      ),
                    ),
                    SizedBox(height: 30),
                    const SizedBox(height: 20),
                    const Text(
                      'Write your review', //spill the tea, what did you like, dislike,
                      style: TextStyle(
                          fontFamily: 'GentiumPlus',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      maxLines: null,
                      controller: reviewController,
                      style: const TextStyle(
                        fontFamily: 'GentiumPlus',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Spill the tea! What did you like? dislike?',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomMainButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontFamily: 'GentiumPlus', fontSize: 16),
                        ),
                        color: brown,
                        isLoading: false,
                        onPressed: () async {
                          if (selectedValue.isEmpty ||
                              //attendanceDate == null ||
                              selectedRatingKey.isEmpty ||
                              reviewController.text.isEmpty) {
                            _scaffoldKey.currentState?.showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.brown,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                                  content: Text('Please fill all fields')),
                            );
                            return;
                          }
                          CloudFirestoreClass().uploadReviewToDatabase(
                              id: widget.salonId.toString(),
                              model: ReviewModel(
                                  senderName: Provider.of<UserDetailsProvider>(
                                          context,
                                          listen: false)
                                      .userDetails
                                      .name,
                                  reviewController: reviewController.text,
                                  rating: selectedRatingKey,
                                  attendanceDate: format.format(_dateTime)));
                          //titleController: titleController.text));
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
