import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/brandPage/brand_p_screen.dart';
import 'package:dream_gallary/screen/shoppage/shopPage_screen.dart';
import 'package:flutter/material.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:dream_gallary/home_screen/section_title.dart';

import 'package:shimmer/shimmer.dart';

import '../main.dart';

class BrandCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 2 * SizeConfig.imageSizeMultiplier),
          child: SectionTitle(
            title: "Brands",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BrandPage()));
            },
          ),
        ),
        SizedBox(height: 3.8 * SizeConfig.imageSizeMultiplier),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: store.state.isLoadingState == true
              ? Shimmer.fromColors(
                  child: Row(children: [
                    Container(
                      margin: EdgeInsets.only(right: 1.2),
                      width: 21.4 * SizeConfig.imageSizeMultiplier,
                      height: 11.5 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Colors.grey[350],
                      ),
                    ),
                    SizedBox(
                      width: 3 * SizeConfig.imageSizeMultiplier,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 1.2),
                      width: 21.4 * SizeConfig.imageSizeMultiplier,
                      height: 11.5 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Colors.grey[350],
                      ),
                    ),
                    SizedBox(
                      width: 3 * SizeConfig.imageSizeMultiplier,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 1.2),
                      width: 21.4 * SizeConfig.imageSizeMultiplier,
                      height: 11.5 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Colors.grey[350],
                      ),
                    ),
                    SizedBox(
                      width: 3 * SizeConfig.imageSizeMultiplier,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 1.2),
                      width: 21.4 * SizeConfig.imageSizeMultiplier,
                      height: 11.5 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Colors.grey[350],
                      ),
                    ),
                  ]),
                  baseColor: Colors.grey[350]!,
                  highlightColor: Colors.white,
                  period: Duration(seconds: 4),
                )
              : Row(
                  children: List.generate(
                  store.state.brandProductState.length,
                  (index) => SpecialOfferCard(
                    imagePath: store.state.brandProductState[index]['image'],
                    press: () {
                      store.dispatch(HomeFilterBrandAction(store.state.brandProductState[index]['id'])) ;
                      Navigator.push(context,
                       MaterialPageRoute(builder: (context) =>ShopPageProduct(groupCategoryValue: null,)));
                    },
                  ),
                )),
        )
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    required this.imagePath,
    required this.press,
  });

  final String imagePath;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(2.3 * SizeConfig.imageSizeMultiplier, 0,
            1.4 * SizeConfig.imageSizeMultiplier, 2),
        child: GestureDetector(
            onTap: press,
            child: SizedBox(
              width: 21.2 * SizeConfig.imageSizeMultiplier,
              height: 11.5 * SizeConfig.imageSizeMultiplier,
              child: Container(
                padding: EdgeInsets.all((1 * SizeConfig.imageSizeMultiplier)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: store.state.darkModeState == null || store.state.darkModeState == false ? Colors.grey[350] : Colors.black,
                    image: DecorationImage(
                      image: NetworkImage(
                        imagePath,
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
            )));
  }
}
