import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../size_config.dart';

class CheckBalance extends StatefulWidget {
  @override
  _CheckBalanceState createState() => _CheckBalanceState();
}

class _CheckBalanceState extends State<CheckBalance> {
  var index;
  void initState() {
    _getUserBalanceData();
    super.initState();
  }

  Future<void> _getUserBalanceData() async {
    var resUserBalance = await CallApi().getData('/app/user/balance/details');
    if (resUserBalance.statusCode == 200) {
      var body = json.decode(resUserBalance.body);
      print(body);
      setState(() {
        store.dispatch(UserBalanceAction(body));
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
        elevation: 0.0,
        backgroundColor: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? Colors.white
            : Colors.grey[900],
        centerTitle: true,
        title: Text(
          "Check Balance",
          style: KTextStyle.headline5.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
              letterSpacing: 0.4),
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
      body: Column(children: [
        Container(
          height: 70 * SizeConfig.heightMultiplier,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              width: 0.7,
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.grey
                  : Colors.grey[900]!,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2 * SizeConfig.imageSizeMultiplier,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 20 * SizeConfig.imageSizeMultiplier,
                    width: 44 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.white
                            : Colors.grey[900],
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey[900]!,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              0.9 * SizeConfig.imageSizeMultiplier),
                          child: Text(
                            "Balance",
                            style: KTextStyle.subtitle3.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              0.9 * SizeConfig.imageSizeMultiplier),
                          child: Text(
                            "\৳ ${store.state.userBalanceState['balance']}",
                            style: KTextStyle.headline4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 20 * SizeConfig.imageSizeMultiplier,
                    width: 44 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.white
                            : Colors.grey[900],
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey[900]!,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              0.9 * SizeConfig.imageSizeMultiplier),
                          child: Text(
                            "Total Order Amount",
                            style: KTextStyle.subtitle3.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              0.9 * SizeConfig.imageSizeMultiplier),
                          child: Text(
                            "\৳ ${store.state.userBalanceState['totalOrderAmount']}",
                            style: KTextStyle.headline4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5 * SizeConfig.imageSizeMultiplier,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 20 * SizeConfig.imageSizeMultiplier,
                    width: 44 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.white
                            : Colors.grey[900],
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey[900]!,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              0.9 * SizeConfig.imageSizeMultiplier),
                          child: Text(
                            "Total Paid Amount",
                            style: KTextStyle.subtitle3.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              0.9 * SizeConfig.imageSizeMultiplier),
                          child: Text(
                            "\৳ ${store.state.userBalanceState['totalPaidAmount']}",
                            style: KTextStyle.headline4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 20 * SizeConfig.imageSizeMultiplier,
                    width: 44 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.white
                            : Colors.grey[900],
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey[900]!,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              0.9 * SizeConfig.imageSizeMultiplier),
                          child: Text(
                            "Outstanding",
                            style: KTextStyle.subtitle3.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              0.9 * SizeConfig.imageSizeMultiplier),
                          child: Text(
                            "\৳ ${store.state.userBalanceState['outstanding']}",
                            style: KTextStyle.headline4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
