// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:coveredncurly/widgets/icon_and_text_widget.dart';
// import 'package:coveredncurly/widgets/big_text.dart';
// import 'package:coveredncurly/widgets/small_text.dart';
// import 'package:coveredncurly/widgets/app_icon.dart';
// import 'package:coveredncurly/utils/dimensions.dart';
// import 'package:coveredncurly/widgets/app_column.dart';

// import '../utils/colors.dart';

// class AppColumn extends StatelessWidget {
//   final String text;
//   const AppColumn({Key? key, required this.text}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         BigText(text: text),
//         SizedBox(height: 0),
//         Row(
//           children: [
//             Wrap(
//                 children: List.generate(
//                     5,
//                     (index) => Icon(
//                           Icons.star,
//                           color: AppColors.secondBrownColor,
//                           size: 15,
//                         ))),
//             SizedBox(
//               width: 10,
//             ),
//             SmallText(text: "South Croydon, CR2"),
//           ],
//         ),
//         SizedBox(
//           height: 8,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconAndTextWidget(
//                 icon: Icons.location_on_rounded,
//                 text: "15 km",
//                 iconColor: AppColors.secondBrownColor),
//             IconAndTextWidget(
//                 icon: Icons.comment_rounded,
//                 text: "reviwes",
//                 iconColor: AppColors.secondBrownColor),
//             IconAndTextWidget(
//                 icon: Icons.link_rounded,
//                 text: "socials",
//                 iconColor: AppColors.secondBrownColor)
//           ],
//         )
//       ],
//     );
//   }
// }
