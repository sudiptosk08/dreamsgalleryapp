import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/home_screen/home_screen.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import '../../k_text_style.dart';
import '../../main.dart';

class PaymentSuccessfull extends StatefulWidget {
  @override
  _PaymentSuccessfullState createState() => _PaymentSuccessfullState();
}

class _PaymentSuccessfullState extends State<PaymentSuccessfull> {
  void initState() {
    _getAllOrder();
    super.initState();
  }

  var indexId;
  Future<void> _getAllOrder() async {
    var res = await CallApi().getData('/app/order');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    print("total - ${body['order']['total']}");
    setState(() {
      store.state.myOrderState = body['order']['data'];
      store.dispatch(MyOrderAction(store.state.myOrderState));
      List.generate(
          store.state.myOrderState.length, (index) => indexId = index);
    });
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == null ||
              store.state.darkModeState == false
          ? Colors.white
          : Color(0xFF0F0E0E),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Image.asset(
                "assets/images/check.png",
                width: 70,
                height: 70,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Payment SuccessFull!",
                style: KTextStyle.bodyText1.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.grey[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Your order No - PX${store.state.myOrderState[indexId]['id']}",
                style: KTextStyle.bodyText3.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey[400],
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 8.5 * SizeConfig.imageSizeMultiplier,
                  top: 20,
                  right: 8.5 * SizeConfig.imageSizeMultiplier,
                  bottom: 5),
              child: Text(
                "if you have any questions or concerns regarding this, do not hesitate to contact us at",
                textAlign: TextAlign.center,
                maxLines: 3,
                style: KTextStyle.bodyText4.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey[400],
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "+88 01611141115",
                style: KTextStyle.bodyText4.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey[400],
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Ten Percent Discount for",
                style: KTextStyle.bodyText4.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey[400],
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Our Premium Customers",
                style: KTextStyle.bodyText1.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.grey[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5 * SizeConfig.imageSizeMultiplier),
              child: Text(
                "Your will get 10% discount on your each and every purchase by using Loyalty Card for lifetime.",
                textAlign: TextAlign.center,
                style: KTextStyle.bodyText4.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey[400],
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
        child: InkWell(
          onTap: () {
            setState(() {
              //placeOrder();
              store.state.logoutUserData = null;
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen()));
            });
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                    vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                child: Text("Continue Shopping",
                    style: KTextStyle.buttonText3.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center)),
          ),
        ),
      ),
    );
  }
}
