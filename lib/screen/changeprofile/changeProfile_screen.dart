import 'package:dream_gallary/screen/changeprofile/profile_body.dart';
import 'package:flutter/material.dart';

import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class ChangeProfile extends StatefulWidget {
  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == false ||
              store.state.darkModeState == null
          ? Colors.white
          : Color(0xFF0F0E0E),
      appBar: AppBar(
        backgroundColor: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? Colors.white
            : Colors.grey[900],
        elevation: 0.6,
        centerTitle: true,
        title: Text(
          "Profile",
          style: KTextStyle.headline5.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
            child: Text(
              "Account Details",
              style: KTextStyle.subtitle3.copyWith(
                color: store.state.darkModeState == null ||
                        store.state.darkModeState == false
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
          ProfileBody(),
        ],
      )),
    );
  }
}
