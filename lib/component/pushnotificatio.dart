import 'dart:async';
import 'package:dream_gallary/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
  }

  // Or do other work.
}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();
  static var fcmtoken;
  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    // handle when app in active state
    forgroundNotification();

    // handle when app running in background state
    backgroundNotification();

    // handle when app completely closed by the user
    terminateNotification();

    // With this token you can test it easily on your phone
    _firebaseMessaging.getToken().then((value) {
      fcmtoken = value;
      print("FCMTOKEN: $fcmtoken");
    });
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  }

  forgroundNotification() {
    FirebaseMessaging.onMessage.listen(
      (message) async {
        print('message.data = ${message.data}');
      },
    );
  }

  backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        print('message.data = ${message.data}');
      },
    );
  }

  terminateNotification() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}
