import 'package:dream_gallary/k_text_style.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../size_config.dart';

class ProfileCircleMenu extends StatelessWidget {
  const ProfileCircleMenu({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 0.8, right: 2.8 * SizeConfig.imageSizeMultiplier),
      child: InkWell(
        onTap: press,
        child: SizedBox(
          width: 16 * SizeConfig.imageSizeMultiplier,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all((3.3 * SizeConfig.imageSizeMultiplier)),
                height: 16 * SizeConfig.imageSizeMultiplier,
                width: 20.5 * SizeConfig.imageSizeMultiplier,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 6.7 * SizeConfig.imageSizeMultiplier,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 3.5),
                child: Text(text,
                    style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.grey[900]!.withOpacity(0.9)
                            : Colors.grey[400],
                        fontSize: 10),
                    textAlign: TextAlign.center),
              )
            ],
          ),
        ),
      ),
    );
  }
}
