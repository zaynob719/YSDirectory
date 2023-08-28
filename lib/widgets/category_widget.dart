import 'package:YSDirectory/screens/result_screen.dart';
import 'package:YSDirectory/utils/constants.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final int index;
  const CategoryWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(query: categoryList[index]),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1)
            ]),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(categoryLogos[index]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                categoryList[index],
                style: const TextStyle(fontFamily: 'GentiumPlus'),
              ),
            )
          ],
        )),
      ),
    );
  }
}
