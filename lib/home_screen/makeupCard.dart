import 'package:flutter/material.dart';
import 'package:dream_gallary/size_config.dart';

// ignore: import_of_legacy_library_into_null_safe
import '../main.dart';

class MakeupCard extends StatefulWidget {
  @override
  _MakeupCardState createState() => _MakeupCardState();
}

class _MakeupCardState extends State<MakeupCard> {
  
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
                image: NetworkImage(store.state.promotionalMakeupCardState),
                fit: BoxFit.cover,
              ),
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
                image: AssetImage("assets/images/best-skin-care.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ));
  }
}
