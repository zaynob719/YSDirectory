// import 'package:YSDirectory/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class RatingStarWidget extends StatelessWidget {
//   final int rating;
//   final bool isVertical;

//   const RatingStarWidget({
//     Key? key,
//     required this.rating,
//     this.isVertical = true,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     IconData starIcon = Icons.star;
//     Color starColor = Colors.amber;
//     num ratingValue =
//         rating.clamp(0.0, 5.0); // Clamp the rating value between 0.0 and 5.0

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment:
//           isVertical ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//       children: List.generate(
//         5,
//         (index) => Icon(
//           index < ratingValue.floor() ? starIcon : starIcon,
//           color: starColor,
//         ),
//       ),
//     );
//   }
// }
  //   Size screenSize = Utils().getScreenSize();
  //   List<Widget> children = [];

  //   for (int i = 0; i < 5; i++) {
  //     children.add(i < rating
  //         ? Icon(
  //             Icons.star,
  //             color: Colors.orange,
  //             size: screenSize.height / 40,
  //           )
  //         : Icon(
  //             Icons.star_border,
  //             color: Colors.orange,
  //             size: screenSize.height / 40,
  //           ));
  //   }

  //   return isVertical
  //       ? Column(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: children,
  //         )
  //       : Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: children,
  //         );
  // }






// class RatingStarWidget extends StatelessWidget {
//   final int rating;
//   const RatingStarWidget({Key? key, required this.rating}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = Utils().getScreenSize();
//     List<Widget> children = [];

//     for (int i = 0; i < 5; i++) {
//       children.add(i < rating
//           ? Icon(
//               Icons.star,
//               color: Colors.orange,
//               size: screenSize.height / 40,
//             )
//           : Icon(
//               Icons.star_border,
//               color: Colors.orange,
//               size: screenSize.height / 40,
//             ));
//     }
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: children,
//     );
//   }
// }
