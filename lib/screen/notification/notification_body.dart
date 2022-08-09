import 'package:dream_gallary/k_text_style.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../size_config.dart';

class NotificationBody extends StatefulWidget {
  @override
  _NotificationBodyState createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == null ||
              store.state.darkModeState == false
          ? Colors.white
          : Color(0xFF0F0E0E),
      body: ListView.builder(
        itemCount: store.state.notificationState.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(
              vertical: 0.2 * SizeConfig.imageSizeMultiplier),
          child: Container(
            padding: EdgeInsets.only(top: 0.2 * SizeConfig.imageSizeMultiplier),
            width: double.infinity,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 2.0 * SizeConfig.imageSizeMultiplier,
                  ),
                  IconButton(
                      icon: Icon(Icons.notifications),
                      color: Colors.red,
                      iconSize: 6 * SizeConfig.imageSizeMultiplier,
                      onPressed: () {}),
                  SizedBox(width: 4 * SizeConfig.imageSizeMultiplier),
                  Container(
                    width: 70 * SizeConfig.imageSizeMultiplier,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.6 * SizeConfig.imageSizeMultiplier,
                        ),
                        Text.rich(TextSpan(
                          text: store.state.notificationState[index]['title'],
                          style: KTextStyle.subtitle3.copyWith(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.black
                                : Colors.grey[400],
                          ),
                        )),
                        SizedBox(height: 1.3 * SizeConfig.imageSizeMultiplier),
                        Text.rich(TextSpan(
                          text: store.state.notificationState[index]['msg'],
                          style: KTextStyle.subtitle4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontSize: 10.5),
                        )),
                        SizedBox(height: 1.3 * SizeConfig.imageSizeMultiplier),
                        Text.rich(
                          TextSpan(
                            text: store.state.notificationState[index]
                                ['created_at'],
                            style: KTextStyle.subtitle4.copyWith(
                                color: store.state.darkModeState == null ||
                                        store.state.darkModeState == false
                                    ? Colors.black
                                    : Colors.grey[400],
                                fontSize: 10.5),
                          ),
                        ),
                        SizedBox(height: 2 * SizeConfig.imageSizeMultiplier),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1 * SizeConfig.imageSizeMultiplier,
              ),
              Divider(
                indent: 5 * SizeConfig.imageSizeMultiplier,
                endIndent: 5 * SizeConfig.imageSizeMultiplier,
                color: Colors.grey[400],
                height: 5.0 * SizeConfig.imageSizeMultiplier,
                thickness: 0.9,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
