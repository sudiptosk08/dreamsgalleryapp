import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: KTextStyle.subtitle3.copyWith(
            color: store.state.darkModeState == null ||
                    store.state.darkModeState == false
                ? Colors.black
                : Colors.white,
          ),
        ),
        SizedBox(
          width: 2 * SizeConfig.imageSizeMultiplier,
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "VIEW ALL",
            style: KTextStyle.overline.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red[700],
            ),
          ),
        ),
      ],
    );
  }
}
