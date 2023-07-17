import 'package:YSDirectory/utils/utils.dart';
import 'package:flutter/material.dart';

class SalonSummaryWidget extends StatelessWidget {
  final String summary;
  const SalonSummaryWidget({
    Key? key,
    required this.summary,
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
            summary,
            maxLines: 1,
            style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
                letterSpacing: 0.4,
                fontFamily: 'GentiumPlus'),
          )
        ],
      ),
    );
  }
}
