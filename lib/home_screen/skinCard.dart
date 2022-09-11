import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dream_gallary/main.dart';
import 'package:dream_gallary/size_config.dart';

class SkinCard extends StatefulWidget {
  @override
  _SkinCardState createState() => _SkinCardState();
}

class _SkinCardState extends State<SkinCard> {
  
  @override
  Widget build(BuildContext context) {
    return store.state.isLoadingState == false
        ? Container(
            width: double.infinity,
            margin: EdgeInsets.all(4 * SizeConfig.imageSizeMultiplier),
            padding: EdgeInsets.symmetric(
              horizontal: 14 * SizeConfig.imageSizeMultiplier,
              vertical: 11.5 * SizeConfig.heightMultiplier,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(store.state.promotionalSkinCardState),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15),
            ),
          )
        : Container(
            width: double.infinity,
            margin: EdgeInsets.all(4 * SizeConfig.imageSizeMultiplier),
            padding: EdgeInsets.symmetric(
              horizontal: 14 * SizeConfig.imageSizeMultiplier,
              vertical: 11.5 * SizeConfig.heightMultiplier,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/makeup.jpg"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15),
            ),
          );
  }
}
