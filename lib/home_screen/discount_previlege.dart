import 'package:dream_gallary/home_screen/section_title.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/main.dart';
import 'package:dream_gallary/screen/discountPage/discount_page_screen.dart';

import 'package:flutter/material.dart';
import 'package:dream_gallary/size_config.dart';

class DisCountPrivilege extends StatefulWidget {
  @override
  _DisCountPrivilegeState createState() => _DisCountPrivilegeState();
}

class _DisCountPrivilegeState extends State<DisCountPrivilege> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 2 * SizeConfig.imageSizeMultiplier),
          child: SectionTitle(
              title: "Discount Privilege",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DiscountPage()));
              }),
        ),
        SizedBox(height: 2.8 * SizeConfig.imageSizeMultiplier),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: List.generate(
                  store.state.discountState.length,
                  (ind) {
                    return Container(
                        child: SpecialOfferCard(
                      imagePath: store.state.discountState[ind]['img'],
                      titleTxt: store.state.discountState[ind]['title'],
                      subTitleTxt: store.state.discountState[ind]['subtitle'],
                      press: () {
                        //Navigator.push(context,
                        //MaterialPageRoute(builder: (context) => DiscountPage()));
                      },
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.imagePath,
    required this.titleTxt,
    required this.subTitleTxt,
    required this.press,
  }) : super(key: key);

  final String imagePath;
  final String titleTxt;
  final String subTitleTxt;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.fromLTRB(
            3.15 * SizeConfig.imageSizeMultiplier,
            0.5 * SizeConfig.imageSizeMultiplier,
            3.0 * SizeConfig.imageSizeMultiplier,
            1.5 * SizeConfig.imageSizeMultiplier),
        child: GestureDetector(
          onTap: press,
          child: SizedBox(
            width: 44 * SizeConfig.imageSizeMultiplier,
            height: 15 * SizeConfig.imageSizeMultiplier,
            child: ClipRect(
              child: Stack(alignment: Alignment.center, children: [
                Container(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // Colors.grey[300].withOpacity(0.6),
                      //Colors.grey[300].withOpacity(0.6),
                      Colors.grey[200]!,
                      Colors.grey[200]!
                    ],
                  ),
                )),
                Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.2 * SizeConfig.imageSizeMultiplier,
                    ),
                    child: Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                    )),
              ]),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(0.2 * SizeConfig.imageSizeMultiplier),
        child: Text(
          titleTxt,
          style: KTextStyle.bodyText4.copyWith(
            color: store.state.darkModeState == null ||
                    store.state.darkModeState == false
                ? Colors.black
                : Colors.grey[400],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(0.2 * SizeConfig.imageSizeMultiplier),
        child: Text(
          subTitleTxt,
          style: KTextStyle.overline.copyWith(
            color: store.state.darkModeState == null ||
                    store.state.darkModeState == false
                ? Colors.black
                : Colors.grey[400],
          ),
        ),
      ),
    ]);
  }
}
