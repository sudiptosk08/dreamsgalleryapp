import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/notification/notification_body.dart';
import 'package:flutter/material.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void initState() {
    _getAllNotification();
    super.initState();
  }

  Future<void> _getAllNotification() async {
    var res = await CallApi().getData('/app/getNotiDetails');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    setState(() {
      store.state.notificationState = body['notiDetails'];
      store.dispatch(NotificationAction(store.state.notificationState));
    });
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == null ||
              store.state.darkModeState == false
          ? Colors.white
          : Color(0xFF0F0E0E),
      appBar: AppBar(
        backgroundColor: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.white
            : Colors.grey[900],
        elevation: 0.6,
        title: Text(
          "Notification",
          style: KTextStyle.headline5.copyWith(
            color: store.state.darkModeState == null ||
                    store.state.darkModeState == false
                ? Colors.black
                : Colors.grey[400],
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 6 * SizeConfig.imageSizeMultiplier,
              color: store.state.darkModeState == null ||
                      store.state.darkModeState == false
                  ? Colors.black
                  : Colors.grey[400],
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 2 * SizeConfig.imageSizeMultiplier),
        child: NotificationBody(),
      ), // here by default width and height is 0
    );
  }
}
