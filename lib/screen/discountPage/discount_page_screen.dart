import 'package:flutter/material.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class DiscountPage extends StatefulWidget {
  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == false ||
              store.state.darkModeState == null
          ? Colors.white
          : Color(0xFF0F0E0E),
      appBar: AppBar(
        elevation: 0.6,
        backgroundColor: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? Colors.white
            : Colors.grey[900],
        centerTitle: true,
        title: Text(
          "Discount Privilege",
          style: KTextStyle.headline5.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 6 * SizeConfig.imageSizeMultiplier,
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: List.generate(
            store.state.discountState.length,
            (ind) {
              return Container(
                  child: SpecialOfferCard(
                imagePath: store.state.discountState[ind]['img'],
                titleTxt: store.state.discountState[ind]['title'],
                subTitleTxt: store.state.discountState[ind]['subtitle'],
                press: () {},
              ));
            },
          ),
        ),
      ),
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
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: SizedBox(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 1.6 * SizeConfig.imageSizeMultiplier,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 2.8 * SizeConfig.imageSizeMultiplier),
                child: Text(
                  titleTxt,
                  style: KTextStyle.bodyText4.copyWith(
                    color: store.state.darkModeState == false ||
                            store.state.darkModeState == null
                        ? Colors.black
                        : Colors.grey[400],
                  ),
                ),
              ),
              SizedBox(
                width: 10 * SizeConfig.imageSizeMultiplier,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: 3.2 * SizeConfig.imageSizeMultiplier),
                child: Text(
                  subTitleTxt,
                  style: KTextStyle.bodyText4.copyWith(
                    color: Colors.grey[600],
                    fontSize: 2.8 * SizeConfig.imageSizeMultiplier,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 0.5 * SizeConfig.imageSizeMultiplier,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                3.15 * SizeConfig.imageSizeMultiplier,
                0.5 * SizeConfig.imageSizeMultiplier,
                3.15 * SizeConfig.imageSizeMultiplier,
                1.5 * SizeConfig.imageSizeMultiplier),
            child: GestureDetector(
              onTap: press,
              child: SizedBox(
                width: 92.5 * SizeConfig.imageSizeMultiplier,
                height: 30 * SizeConfig.imageSizeMultiplier,
                child: ClipRect(
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            image: DecorationImage(
                              image: NetworkImage(
                                imagePath,
                              ),
                              fit: BoxFit.cover,
                            ))),
                  ]),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
