import 'package:coveredncurly/utils/colors.dart';
import 'package:coveredncurly/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.child,
    this.color,
    this.onTap,
    this.width = 60,
  }) : super(key: key);
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        clipBehavior: Clip.hardEdge,
        shape: const CircleBorder(),
        child: InkWell(onTap: onTap, child: child));
  }
}
