import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/paymentHistory/recentpayment_body.dart';
import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../main.dart';
import '../../size_config.dart';

class PaymentHistory extends StatefulWidget {
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  var grandTotal;
  var shippingPrice;
  void initState() {
    _getAllOrder();
    _getUserBalanceData();
    super.initState();
  }

  _getAllOrder() {
    List.generate(store.state.myOrderState.length, (index) {
      return grandTotal = store.state.myOrderState[index]['grandTotal'];
    });
    List.generate(store.state.myOrderState.length, (index) {
      return shippingPrice = store.state.myOrderState[index]['shippingPrice'];
    });
  }

  Future<void> _getUserBalanceData() async {
    var resUserBalance = await CallApi().getData('/app/user/balance/details');
    if (resUserBalance.statusCode == 200) {
      var body = json.decode(resUserBalance.body);
      print(body);
      setState(() {
        store.dispatch(UserBalanceAction(body));
      });
      setState(() {
        store.dispatch(IsLoadingAction(false)); //true chilo
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == false ||
              store.state.darkModeState == null
          ? Colors.white
          : Color(0xFF0F0E0E),
      appBar: AppBar(
        elevation: 0.6,
        backgroundColor: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? Colors.white
            : Colors.grey[900],
        centerTitle: true,
        title: Text(
          "Payment History",
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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
            Padding(
              padding: EdgeInsets.only(
                left: 4 * SizeConfig.imageSizeMultiplier,
                right: 4 * SizeConfig.imageSizeMultiplier,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4 * SizeConfig.imageSizeMultiplier,
                        vertical: 10 * SizeConfig.imageSizeMultiplier),
                    child: Column(children: [
                      Text("Balance",
                          style: KTextStyle.bodyText2.copyWith(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center),
                      Padding(
                        padding: EdgeInsets.all(
                            0.9 * SizeConfig.imageSizeMultiplier),
                        child: Text(
                          "\৳ 20", //${store.state.userBalanceState['balance']}
                          style: KTextStyle.bodyText2.copyWith(
                            color: store.state.darkModeState == false ||
                                    store.state.darkModeState == null
                                ? Colors.black
                                : Colors.grey[400],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ])),
              ),
            ),
            SizedBox(
              height: 4 * SizeConfig.imageSizeMultiplier,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 4.5 * SizeConfig.imageSizeMultiplier),
              child: Text(
                "Recent Payment",
                style: KTextStyle.subtitle3.copyWith(
                  color: store.state.darkModeState == false ||
                          store.state.darkModeState == null
                      ? Colors.black
                      : Colors.grey[400],
                ),
              ),
            ),
            SizedBox(
              height: 4 * SizeConfig.imageSizeMultiplier,
            ),
            Container(
              color: kSecondaryColor.withOpacity(0.1),
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 2.5 * SizeConfig.imageSizeMultiplier),
                  child: RecentPaymentBody()),
            )
          ],
        ),
      ),
    );
  }
}
