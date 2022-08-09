
import 'package:dream_gallary/k_text_style.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../size_config.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 4.4 * SizeConfig.imageSizeMultiplier,
          vertical: 0.1 * SizeConfig.imageSizeMultiplier),
      child: Container(
        child: FlatButton(
          padding: EdgeInsets.only(left: 2 * SizeConfig.imageSizeMultiplier),
          onPressed: press,
          child: Row(
            children: [
              Icon(
                icon,
                color: store.state.darkModeState == null ||
                        store.state.darkModeState == false
                    ? Colors.black
                    : Colors.grey[400],
                size: 5 * SizeConfig.imageSizeMultiplier,
              ),
              SizedBox(width: 20),
              Expanded(
                  child: Text(
                text,
                style: KTextStyle.bodyText4.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.grey[400],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
