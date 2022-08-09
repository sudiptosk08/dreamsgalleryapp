import 'package:dream_gallary/screen/account/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';
import '../../../size_config.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:store.state.darkModeState == null || store.state.darkModeState == false ? Colors.white :  Color(0xFF0F0E0E),
      appBar:AppBar(
        backgroundColor:store.state.darkModeState == null || store.state.darkModeState == false ? Colors.white :  Color(0xFF0F0E0E),
        elevation: 0.0,
        leading: Padding(
          padding:  EdgeInsets.all(12.0),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 6 * SizeConfig.imageSizeMultiplier,
                color:store.state.darkModeState == null || store.state.darkModeState == false ?
                Colors.black : Colors.grey[400],
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 4 * SizeConfig.imageSizeMultiplier),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.heightMultiplier * 4.5),
                  Container(
                    height: 22 * SizeConfig.imageSizeMultiplier,
                    width: 23.2 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding:
                      EdgeInsets.all(4.4 * SizeConfig.imageSizeMultiplier),
                      child: SvgPicture.asset("assets/icons/DG SVG.svg"),
                    ),
                  ),
                  SizedBox(height: 10 * SizeConfig.imageSizeMultiplier),
                  RegistrationForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
