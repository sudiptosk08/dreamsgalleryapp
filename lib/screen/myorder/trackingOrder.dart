import 'package:flutter/material.dart';
import '../../k_text_style.dart';
import '../../size_config.dart';

class TrackOrder extends StatefulWidget {
  final orderId;
  final statusValue;
  TrackOrder({@required this.orderId, @required this.statusValue});
  @override
  _TrackOrderState createState() => _TrackOrderState(orderId, statusValue);
}

class _TrackOrderState extends State<TrackOrder> {
  var orderId;
  var statusValue;
  _TrackOrderState(this.orderId, this.statusValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        title: Text(
          "Track Order",
          style: KTextStyle.headline5.copyWith(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            size: 6 * SizeConfig.imageSizeMultiplier,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.grey[350]),
                child: Text.rich(
                  TextSpan(
                      text: "Order Tracking - #PX",
                      style: KTextStyle.bodyText3.copyWith(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: orderId.toString(),
                          style: KTextStyle.bodyText3.copyWith(
                            color: Colors.black,
                          ),
                        )
                      ]),
                ),
              ),
              //SizedBox(height: 12),
              Container(
                color: Colors.white,
                height: 430.0, // Change as per your requirement
                width: 280.0, // Change as per your requirement
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 13, top: 50),
                      width: 4,
                      height: 400,
                      color: Colors.grey[350],
                    ),
                    Column(
                      children: [
                        statusWidget('confirmed', "Order Placed", false),
                        statusWidget('onBoard2', "Processing", false),
                        statusWidget(
                            'servicesImg', "Preparing for Ship", false),
                        statusWidget('shipped', "Shipped", false),
                        statusWidget('Delivery', "Delivered", false),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey[350],
                height: 2,
                indent: 2,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "Delivery Partner ",
                  style: KTextStyle.bodyText4.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/pathao.png"),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 10,
              ),
            ]),
      ),
    );
  }

  Container statusWidget(String img, String status, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (statusValue == status) ? Colors.orange : Colors.white,
                border: Border.all(
                    color: (statusValue == status)
                        ? Colors.transparent
                        : Colors.orange,
                    width: 3)),
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/$img.png"),
                        fit: BoxFit.contain)),
              ),
              Text(
                status,
                style: KTextStyle.bodyText4.copyWith(
                    color:
                        (statusValue == status) ? Colors.orange : Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }
}
