import 'package:flutter/material.dart';
import 'package:dream_gallary/size_config.dart';

import '../main.dart';

class MakeupCard extends StatefulWidget {
  @override
  _MakeupCardState createState() => _MakeupCardState();
}

class _MakeupCardState extends State<MakeupCard> {
  var index = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(4 * SizeConfig.imageSizeMultiplier),
      padding: EdgeInsets.symmetric(
        horizontal: 14 * SizeConfig.imageSizeMultiplier,
        vertical: 11.5 * SizeConfig.heightMultiplier,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(store.state.mainSliderState['promotionalCards'][0]
              ['image']), // store.state.isLoadingState == true ?
          //AssetImage("assets/images/best-skin-care.jpg")
          //:
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
