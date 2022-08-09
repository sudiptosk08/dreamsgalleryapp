import 'package:dream_gallary/screen/account/login/login_screen.dart';
import 'package:dream_gallary/screen/notification/notification_screen.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:dream_gallary/home_screen/search_field.dart';
import '../main.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: Row(
          children: [
            SearchField(),
            IconButton(
                icon: Icon(
                  Icons.notifications_none,
                ),
                iconSize: 7 * SizeConfig.imageSizeMultiplier,
                color: store.state.darkModeState == false ||
                        store.state.darkModeState == null
                    ? Colors.black
                    : Colors.grey[400],
                onPressed: () {
                  store.state.userDataState == null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()));
                }),
          ],
        ));
  }
}
