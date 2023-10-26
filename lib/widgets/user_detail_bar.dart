import 'package:YSDirectory/models/user_details_model.dart';
import 'package:YSDirectory/provider/user_details_provider.dart';
import 'package:YSDirectory/utils/colors.dart';
import 'package:YSDirectory/utils/constants.dart';
import 'package:YSDirectory/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:YSDirectory/main.dart';

class UserDetailBar extends StatelessWidget {
  final double offset;
  UserDetailBar({
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: lightBackgroupGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 20,
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.location_on,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.7,
              child: Text(
                'Location: ${userDetails.city}' ?? "Add location in settings",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'GentiumPlus',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
