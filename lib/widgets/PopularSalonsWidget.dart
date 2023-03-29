//import 'dart:html';

import 'package:coveredncurly/utils/colors.dart';
import 'package:flutter/material.dart';

class PopularSalonsWidget extends StatelessWidget {
  const PopularSalonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/ysds001.png'),
                  ),
                ),
              ),
              // Text and icons section
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: lightBrown,
                    borderRadius: BorderRadius.circular(10
                        //topRight: Radius.circular(10),
                        //bottomRight: Radius.circular(10),
                        ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Salon Name $index',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            fontFamily: 'InknutAntiqua'),
                      ),
                      //SizedBox(height: 10.0),
                      Text(
                        'Specialise in Afrocare services',
                        style: TextStyle(
                            fontSize: 14.0, fontFamily: 'GentiumPlus'),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.comment, color: Colors.black),
                              SizedBox(width: 8.0),
                              Text(
                                '20 reviews',
                                style: TextStyle(
                                    fontSize: 12.0, fontFamily: 'GentiumPlus'),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Icon(Icons.comment, color: Colors.black),
                          //     SizedBox(width: 5.0),
                          //     Text(
                          //       '20 socials',
                          //       style: TextStyle(fontSize: 12.0),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '1.5 mi',
                                style: TextStyle(
                                    fontSize: 13.0, fontFamily: 'GentiumPlus'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
