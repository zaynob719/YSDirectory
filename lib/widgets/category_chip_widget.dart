import 'package:YSDirectory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:YSDirectory/utils/constants.dart';
import 'package:YSDirectory/screens/result_screen.dart';

class CategoryChipWidget extends StatefulWidget {
  const CategoryChipWidget({Key? key}) : super(key: key);

  @override
  _CategoryChipWidgetState createState() => _CategoryChipWidgetState();
}

class _CategoryChipWidgetState extends State<CategoryChipWidget> {
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categoryList.map((category) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ChoiceChip(
                label: Text(category),
                selected: selectedCategory == category,
                selectedColor: brown,
                backgroundColor: lightBrown,
                labelStyle: TextStyle(fontFamily: 'GentiumPlus'),
                elevation: 2,
                onSelected: (isSelected) {
                  setState(() {
                    selectedCategory = isSelected ? category : '';
                  });
                  if (isSelected) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(query: category),
                        ),
                      );
                    });
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
