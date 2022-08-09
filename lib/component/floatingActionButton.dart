import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../size_config.dart';

class FloatingActionBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        padding: EdgeInsets.all((3.3 * SizeConfig.imageSizeMultiplier)),
        height: 14 * SizeConfig.imageSizeMultiplier,
        width: 14.5 * SizeConfig.imageSizeMultiplier,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: SvgPicture.asset(
          "assets/icons/DG SVG.svg",
          color: Colors.white,
        ),
      ),
    );
  }
}
