import 'package:dream_gallary/home_screen/home_screen.dart';

import '../../../main.dart';
import '../../../size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'log_in.dart';

import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      },
      child: Scaffold(
        backgroundColor: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.white
            : Color(0xFF0F0E0E),
        appBar: AppBar(
          backgroundColor: store.state.darkModeState == null ||
                  store.state.darkModeState == false
              ? Colors.white
              : Color(0xFF0F0E0E),
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.all(12.0),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 6 * SizeConfig.imageSizeMultiplier,
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.grey[400],
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen()));
                  store.state.logoutUserData = null;
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
                    SizedBox(height: SizeConfig.heightMultiplier * 7),
                    Container(
                      height: 22 * SizeConfig.imageSizeMultiplier,
                      width: 23.2 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                            4.4 * SizeConfig.imageSizeMultiplier),
                        child: SvgPicture.asset("assets/icons/DG SVG.svg"),
                      ),
                    ),
                    SizedBox(height: 16 * SizeConfig.imageSizeMultiplier),
                    LoginForm(),
                    SizedBox(height: 4 * SizeConfig.imageSizeMultiplier),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
