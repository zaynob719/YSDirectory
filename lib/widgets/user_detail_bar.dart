import 'package:coveredncurly/models/user_details_model.dart';
import 'package:coveredncurly/provider/user_details_provider.dart';
import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/constants.dart';
import 'package:coveredncurly/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailBar extends StatelessWidget {
  final double offset;
  const UserDetailBar({
    Key? key,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 2,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: lightBackgroupGradient,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 20,
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.location_on,
              color: Colors.grey[900],
            ),
          ),
          SizedBox(
            width: screenSize.width * 0.7,
            child: Text(
              "Location - ${userDetails.city}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontFamily: 'GentiumPlus'),
            ),
          ),
        ]),
      ),
    );
  }
}
