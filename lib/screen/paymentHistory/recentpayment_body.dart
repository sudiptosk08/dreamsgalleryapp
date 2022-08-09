import 'dart:convert';

import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:flutter/material.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class RecentPaymentBody extends StatefulWidget {
  @override
  _RecentPaymentBodyState createState() => _RecentPaymentBodyState();
}

class _RecentPaymentBodyState extends State<RecentPaymentBody> {
  void initState() {
    _getAllOrder();
    super.initState();
  }

  Future<void> _getAllOrder() async {
    var res = await CallApi().getData('/app/order');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    setState(() {
      store.state.myOrderState = body['order']['data'];
      store.dispatch(MyOrderAction(store.state.myOrderState));
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
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: store.state.myOrderState.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(
              vertical: 0.2 * SizeConfig.imageSizeMultiplier),
          child: Container(
            padding: EdgeInsets.only(top: 0.2 * SizeConfig.imageSizeMultiplier),
            width: double.infinity,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                          text:
                              "${store.state.myOrderState[index]['created_at']} ",
                          style: KTextStyle.bodyText4.copyWith(
                            color: Colors.grey[600],
                          ),
                        )),
                        SizedBox(height: 1.3 * SizeConfig.imageSizeMultiplier),
                        Text.rich(TextSpan(
                          text:
                              "Payment For Order No. #PX${store.state.myOrderState[index]['id']} ",
                          style: KTextStyle.bodyText4.copyWith(
                            color: store.state.darkModeState == false ||
                                    store.state.darkModeState == null
                                ? Colors.black
                                : Colors.grey[400],
                          ),
                        )),
                        SizedBox(height: 1.3 * SizeConfig.imageSizeMultiplier),
                      ],
                    ),
                  ),
                  SizedBox(width: 1 * SizeConfig.imageSizeMultiplier),
                  Padding(
                    padding:
                        EdgeInsets.all(0.9 * SizeConfig.imageSizeMultiplier),
                    child: Text(
                      "\৳ ${store.state.myOrderState[index]['grandTotal']}",
                      style: KTextStyle.bodyText3.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2 * SizeConfig.imageSizeMultiplier,
              ),
              Divider(
                indent: 0.1 * SizeConfig.imageSizeMultiplier,
                endIndent: 0.1 * SizeConfig.imageSizeMultiplier,
                color: store.state.darkModeState == false ||
                        store.state.darkModeState == null
                    ? Colors.grey[400]
                    : Colors.grey[900],
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
