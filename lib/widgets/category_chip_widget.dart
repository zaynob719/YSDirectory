import 'package:coveredncurly/utils/colors.dart';
import 'package:flutter/material.dart';

class CategoryChipWidget extends StatefulWidget {
  final List<String> categoryList;
  final Function(String)? onSelectCategory;

  CategoryChipWidget({required this.categoryList, this.onSelectCategory});

  @override
  _CategoryChipWidgetState createState() => _CategoryChipWidgetState();
}

class _CategoryChipWidgetState extends State<CategoryChipWidget> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: widget.categoryList.map((category) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChoiceChip(
              label: Text(
                category,
                style: TextStyle(
                  fontFamily: 'GentiumPlus',
                  color: selectedCategory == category
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              selected: selectedCategory == category,
              backgroundColor: AppColors.mainBrownColor,
              selectedColor: AppColors.secondBrownColor,
              onSelected: (bool selected) {
                setState(() {
                  selectedCategory = selected ? category : null;
                });
                if (widget.onSelectCategory != null) {
                  widget.onSelectCategory!(selectedCategory!);
                }
                if (selected) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewPage(),
                    ),
                  );
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

//category list page when selected - change with video
class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list of selected category page '),
      ),
      body: Center(
        child: Text('list of selected category page'),
      ),
    );
  }
}
