import 'package:dream_gallary/screen/terms&condition/bangla.dart';
import 'package:dream_gallary/screen/terms&condition/english.dart';
import 'package:flutter/material.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class TermCondition extends StatefulWidget {
  @override
  _TermConditionState createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  var activeMenu = 0;
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
          title: Text(
            "Terms & Conditions",
            style: KTextStyle.headline5.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
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
          centerTitle: true,
        ),
        body: ListView(children: [
          SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Terms & Conditions",
            style: KTextStyle.subtitle2.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: (activeMenu == 0) ? English() : Bangla()),
        ]));
  }
}
