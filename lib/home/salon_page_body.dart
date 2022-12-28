import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SalonPageBody extends StatefulWidget {
  const SalonPageBody({Key? key}) : super(key: key);

  @override
  _SalonPageBodyState createState() => _SalonPageBodyState();
}

class _SalonPageBodyState extends State<SalonPageBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 320,
        child: PageView.builder(
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            }));
  }

  Widget _buildPageItem(int index) {
    return Stack(
      children: [
        Container(
          height: 220,
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index.isEven ? Color(0xFFD8BA9E) : Color(0xFFF1E6DB),
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/salon.jpg"))),
        )
      ],
    );
  }
}
