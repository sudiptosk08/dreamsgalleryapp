import 'package:dream_gallary/model/pushnotification_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'home_screen/home_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  //register notification
  Future<void> registerNotification() async {
    await Firebase.initializeApp();
    //instance for firebase messaging
    _messaging = FirebaseMessaging.instance;

    //three type of state in nofification
    //not determined(null),granted (true) and decline (false)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted the permission");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          dataBody: message.data['title,'],
          dataTitle: message.data['body'],
        );

        setState(() {
          _notificationInfo = notification;
        });
        showSimpleNotification(Text(_notificationInfo!.title!),
            leading: Image(image: AssetImage("assets/images/DG Logo.jpg")),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.grey,
            duration: Duration(seconds: 4));
      });
    } else {
      print("Permission declined by user");
    }
  }

  @override
  void initState() {
    //set time to load the new page
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    registerNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 100,
                width: 120,
                child: Image.asset("assets/images/logo.png")),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
