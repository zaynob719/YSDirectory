import 'package:coveredncurly/utils/utils.dart';
import 'package:flutter/material.dart';

class SalonInformationWidget extends StatelessWidget {
  final String salonName;
  const SalonInformationWidget({
    Key? key,
    required this.salonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SizedBox(
      width: screenSize.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            salonName,
            maxLines: 1,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
                letterSpacing: 0.4,
                fontFamily: 'InknutAntiqua'),
          )
        ],
      ),
    );
  }
}
