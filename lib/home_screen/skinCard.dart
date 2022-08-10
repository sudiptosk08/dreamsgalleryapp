import 'package:dream_gallary/main.dart';
import 'package:flutter/material.dart';
import 'package:dream_gallary/size_config.dart';

class SkinCard extends StatefulWidget {
  @override
  _SkinCardState createState() => _SkinCardState();
}

class _SkinCardState extends State<SkinCard> {
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(4 * SizeConfig.imageSizeMultiplier),
      padding: EdgeInsets.symmetric(
        horizontal: 14 * SizeConfig.imageSizeMultiplier,
        vertical: 11.5 * SizeConfig.heightMultiplier,
      ),
      decoration: store.state.isLoadingState == true
          ? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/makeup.jpg"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(store.state
                      .mainSliderState['promotionalCards'][1]['image']), //
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15),
            ),
    );
  }
}
