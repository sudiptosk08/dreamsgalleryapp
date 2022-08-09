

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:shimmer/shimmer.dart';

import '../main.dart';
class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      padding: EdgeInsets.only(left:1.5 * SizeConfig.imageSizeMultiplier,
          right: 1.5 * SizeConfig.imageSizeMultiplier),
      height: 174,
      width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: store.state.isLoadingState == true ? Shimmer.fromColors(child: Container(height: 200,
          width: 97 * SizeConfig.imageSizeMultiplier,
          decoration: BoxDecoration(
            color: Colors.grey[350],
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),), baseColor:Colors.grey[350]!,
          highlightColor: Colors.white,
          period: Duration(seconds: 3),
          )
          :
          Carousel(
            boxFit: BoxFit.cover,
          images:store.state.mainSliderState['headerSlider'].map<Widget>((element) =>
               ClipRRect(
                 borderRadius: BorderRadius.all(Radius.circular(10)),
                 child: Image.network(element['image'],
                  alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                  ),
               ),).toList(),
          borderRadius: true,
          dotIncreaseSize: 0.4 * SizeConfig.imageSizeMultiplier,
          radius: Radius.circular(12),
          dotBgColor: Colors.grey.withOpacity(0.0),
          dotSize: 1.5 * SizeConfig.imageSizeMultiplier,
          autoplay: true,
            autoplayDuration:Duration(seconds: 3) ,
            animationCurve: Curves.easeInOut,
    ),
    );
  }
}
