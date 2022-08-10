// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/constant.dart';
import 'package:dream_gallary/model/notification_setting.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/checkout/orderSuccessfull.dart';
import 'package:dream_gallary/screen/checkout/paymentCancel.dart';
import 'package:dream_gallary/screen/checkout/paymentSuccessfull.dart';
import 'package:dream_gallary/screen/payment/ssl_commerz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sslcommerz_flutter/model/SSLCTransactionInfoModel.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class PreOrderCheckOutScreen extends StatefulWidget {
  final int sum;
  PreOrderCheckOutScreen(this.sum);

  @override
  _PreOrderCheckOutScreenState createState() => _PreOrderCheckOutScreenState();
}

class _PreOrderCheckOutScreenState extends State<PreOrderCheckOutScreen> {
  TextEditingController orderNotes = TextEditingController();

  var shippingCost;
  bool differentAddress = false;

  final notifications = [
    NotificationSetting(title: "Cash On Delivery"),
    NotificationSetting(title: "Payment Gateway"),
    NotificationSetting(title: "Bkash"),
  ];

  final _formKey = GlobalKey<FormState>();
  String fullName = store.state.userDataState['name'];
  String phone = store.state.userDataState['contact'];
  String email = store.state.userDataState['email'];
  String city = "Select City";
  int cityId = 0;
  String zone = "Select Zone";
  int zoneId = 0;
  String area = "Select Area";
  int areaId = 0;
  List<dynamic> zoneListByCity = [];
  List<dynamic> areaListByZone = [];
  List<dynamic> newZoneListByCity = [];

  String postalCode = store.state.userDataState['customer']['postCode'] == null
      ? ''
      : store.state.userDataState['customer']['postCode'];
  String fullAddress = store.state.userDataState['customer']['address'] == null
      ? ''
      : store.state.userDataState['customer']['address'];
  final List<String> errors = [];
  late String paymentMethod;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  var total;

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void initState() {
    cityId = store.state.userDataState['customer']['cityId'];
    zoneId = store.state.userDataState['customer']['zoneId'];
    areaId = store.state.userDataState['customer']['areaId'];
    setState(() {
      var index;
      var value = store.state.districtState;
      index = value.indexWhere((element) => element['id'] == cityId);
      city = cityId == 0 ? city : store.state.districtState[index]['name'];

      store.dispatch(IsLoadingAction(false));
    });
    setState(() {
      var index;
      var value = store.state.zoneState;
      index = value.indexWhere((element) => element['id'] == zoneId);
      zone = zoneId == 0 ? zone : store.state.zoneState[index]['zoneName'];
      zoneListByCity =
          value.where((zoneItem) => zoneItem['city_id'] == cityId).toList();
      store.dispatch(IsLoadingAction(false));
    });
    setState(() {
      var value = store.state.areaState;
      var index = value.indexWhere((element) => element['id'] == areaId);
      area = areaId == 0 ? area : store.state.areaState[index]['name'];
      areaListByZone =
          value.where((areaItem) => areaItem['zone_id'] == zoneId).toList();
    });

    super.initState();
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
        elevation: 0.6,
        backgroundColor: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.white
            : Colors.grey[900],
        centerTitle: true,
        title: Text(
          "Checkout",
          style: KTextStyle.headline5.copyWith(
            color: store.state.darkModeState == null ||
                    store.state.darkModeState == false
                ? Colors.black
                : Colors.white,
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
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
            child: Text(
              "Billing Address",
              style: KTextStyle.subtitle3.copyWith(
                color: store.state.darkModeState == null ||
                        store.state.darkModeState == false
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name:*",
                        style: KTextStyle.caption.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 1.6 * SizeConfig.imageSizeMultiplier,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? kSecondaryColor.withOpacity(0.1)
                              : Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: fullName,
                          keyboardType: TextInputType.name,
                          onSaved: (newValue) => fullName = newValue!,
                          onChanged: (value) {
                            setState(() {
                              fullName = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Full Name',
                            hintStyle: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                            ),
                          ),
                          style: KTextStyle.bodyText4.copyWith(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.grey[600]
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number:*",
                        style: KTextStyle.caption.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 1.6 * SizeConfig.imageSizeMultiplier,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? kSecondaryColor.withOpacity(0.1)
                              : Colors.grey[900],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: TextFormField(
                          initialValue: phone,
                          keyboardType: TextInputType.phone,
                          onSaved: (newValue) => phone = newValue!,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Phone Number',
                            hintStyle: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                            ),
                          ),
                          style: KTextStyle.bodyText4.copyWith(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.grey[600]
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email:*",
                        style: KTextStyle.caption.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 1.6 * SizeConfig.imageSizeMultiplier,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? kSecondaryColor.withOpacity(0.1)
                              : Colors.grey[900],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: email,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) => email = newValue!,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                            ),
                          ),
                          style: KTextStyle.bodyText4.copyWith(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.grey[600]
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.4 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "City:*",
                                style: KTextStyle.caption.copyWith(
                                  color: store.state.darkModeState == null ||
                                          store.state.darkModeState == false
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              SizedBox(
                                  height: 2 * SizeConfig.imageSizeMultiplier),
                              Container(
                                width: 46 * SizeConfig.imageSizeMultiplier,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.2 *
                                            SizeConfig.imageSizeMultiplier,
                                        right: 0.2 *
                                            SizeConfig.imageSizeMultiplier,
                                        bottom: 0.0 *
                                            SizeConfig.imageSizeMultiplier),
                                    child: GestureDetector(
                                      onTap: () {
                                        showCity(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.1 *
                                              SizeConfig.imageSizeMultiplier,
                                          vertical: 1.6 *
                                              SizeConfig.imageSizeMultiplier,
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          color: store.state.darkModeState ==
                                                      null ||
                                                  store.state.darkModeState ==
                                                      false
                                              ? kSecondaryColor.withOpacity(0.1)
                                              : Colors.grey[900],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 12, 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                store.state.districtName == null
                                                    ? city.toString()
                                                    : city
                                                        .toString(), //brandTitle
                                                style: KTextStyle.bodyText4
                                                    .copyWith(
                                                  color: store.state
                                                                  .darkModeState ==
                                                              null ||
                                                          store.state
                                                                  .darkModeState ==
                                                              false
                                                      ? Colors.grey[600]
                                                      : Colors.grey[400],
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                color: Colors.grey,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 3.8 * SizeConfig.imageSizeMultiplier,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Zone:*",
                                  style: KTextStyle.caption.copyWith(
                                    color: store.state.darkModeState == null ||
                                            store.state.darkModeState == false
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                SizedBox(
                                    height: 2 * SizeConfig.imageSizeMultiplier),
                                Container(
                                  width: 46 * SizeConfig.imageSizeMultiplier,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.2 *
                                              SizeConfig.imageSizeMultiplier,
                                          right: 0.2 *
                                              SizeConfig.imageSizeMultiplier,
                                          bottom: 0.0 *
                                              SizeConfig.imageSizeMultiplier),
                                      child: GestureDetector(
                                        onTap: () {
                                          showZone(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 2.1 *
                                                SizeConfig.imageSizeMultiplier,
                                            vertical: 1.6 *
                                                SizeConfig.imageSizeMultiplier,
                                          ),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            color: store.state.darkModeState ==
                                                        null ||
                                                    store.state.darkModeState ==
                                                        false
                                                ? kSecondaryColor
                                                    .withOpacity(0.1)
                                                : Colors.grey[900],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 8, 12, 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  store.state.zoneName == null
                                                      ? zone.toString()
                                                      : zone
                                                          .toString()
                                                          .toString(), //brandTitle
                                                  style: KTextStyle.bodyText4
                                                      .copyWith(
                                                    color: store.state
                                                                    .darkModeState ==
                                                                null ||
                                                            store.state
                                                                    .darkModeState ==
                                                                false
                                                        ? Colors.grey[600]
                                                        : Colors.grey[400],
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .keyboard_arrow_down_outlined,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                              ]),
                        ],
                      ),
                      SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Area (Optional):*",
                              style: KTextStyle.caption.copyWith(
                                color: store.state.darkModeState == null ||
                                        store.state.darkModeState == false
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.2 *
                                            SizeConfig.imageSizeMultiplier,
                                        right: 0.2 *
                                            SizeConfig.imageSizeMultiplier,
                                        bottom: 0.0 *
                                            SizeConfig.imageSizeMultiplier),
                                    child: GestureDetector(
                                      onTap: () {
                                        showarea(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.1 *
                                              SizeConfig.imageSizeMultiplier,
                                          vertical: 1.6 *
                                              SizeConfig.imageSizeMultiplier,
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          color: store.state.darkModeState ==
                                                      null ||
                                                  store.state.darkModeState ==
                                                      false
                                              ? kSecondaryColor.withOpacity(0.1)
                                              : Colors.grey[900],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 12, 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                store.state.areaState == null
                                                    ? area.toString()
                                                    : area.toString(),
                                                style: KTextStyle.bodyText4
                                                    .copyWith(
                                                  color: store.state
                                                                  .darkModeState ==
                                                              null ||
                                                          store.state
                                                                  .darkModeState ==
                                                              false
                                                      ? Colors.grey[600]
                                                      : Colors.grey[400],
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_down_outlined,
                                                color: Colors.grey,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
                SizedBox(height: 0.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full Address:*",
                        style: KTextStyle.caption.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 1.6 * SizeConfig.imageSizeMultiplier,
                      ),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? kSecondaryColor.withOpacity(0.1)
                              : Colors.grey[900],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: TextFormField(
                          initialValue: fullAddress,
                          onChanged: (value) {
                            setState(() {
                              fullAddress = value;
                            });
                          },
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Address',
                            hintStyle: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                            ),
                          ),
                          style: KTextStyle.bodyText4.copyWith(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.grey[600]
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Postal Code:*",
                        style: KTextStyle.caption.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 1.6 * SizeConfig.imageSizeMultiplier,
                      ),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? kSecondaryColor.withOpacity(0.1)
                              : Colors.grey[900],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: TextFormField(
                          initialValue: postalCode,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              postalCode = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Post Code",
                            hintStyle: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                            ),
                          ),
                          style: KTextStyle.bodyText4.copyWith(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.grey[600]
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 2.4 * SizeConfig.imageSizeMultiplier,
                    top: 3.1 * SizeConfig.imageSizeMultiplier,
                    right: 2.4 * SizeConfig.imageSizeMultiplier,
                    bottom: 3.1 * SizeConfig.imageSizeMultiplier,
                  ),
                  child: Text(
                    "Order Notes (Optional):*",
                    style: KTextStyle.caption.copyWith(
                      color: store.state.darkModeState == false ||
                              store.state.darkModeState == null
                          ? Colors.black
                          : Colors.grey[400],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.4 * SizeConfig.imageSizeMultiplier,
                      right: 2.4 * SizeConfig.imageSizeMultiplier),
                  child: Container(
                    width: double.infinity,
                    height: 40 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextFormField(
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.grey[600]
                            : Colors.grey[400],
                      ),
                      controller: orderNotes,
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                            vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText:
                            'Notes about your order, e.g. special notes for delivery.',
                        hintStyle: KTextStyle.bodyText4.copyWith(
                          color: store.state.darkModeState == false ||
                                  store.state.darkModeState == null
                              ? Colors.grey[600]
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
                  child: Text(
                    "Cart Total",
                    style: KTextStyle.subtitle3.copyWith(
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      3.5 * SizeConfig.imageSizeMultiplier,
                                      0.0 * SizeConfig.imageSizeMultiplier,
                                      3.5 * SizeConfig.imageSizeMultiplier,
                                      0.0 * SizeConfig.imageSizeMultiplier),
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                        store.state.preOrderCartState.length,
                                        (index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 56 *
                                                        SizeConfig
                                                            .imageSizeMultiplier,
                                                    height: 10 *
                                                        SizeConfig
                                                            .imageSizeMultiplier,
                                                    child: Text.rich(
                                                      TextSpan(
                                                          text:
                                                              "${store.state.preOrderCartState[index]['details']['productName']} ",
                                                          style: KTextStyle
                                                              .bodyText4
                                                              .copyWith(
                                                            color: store.state
                                                                            .darkModeState ==
                                                                        null ||
                                                                    store.state
                                                                            .darkModeState ==
                                                                        false
                                                                ? Colors.black
                                                                : Colors
                                                                    .grey[400],
                                                            fontSize: 10.5,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  "${store.state.preOrderCartState[index]['details']['model']} ",
                                                              style: KTextStyle
                                                                  .bodyText4
                                                                  .copyWith(
                                                                color: store.state.darkModeState ==
                                                                            null ||
                                                                        store.state.darkModeState ==
                                                                            false
                                                                    ? Colors
                                                                        .black
                                                                    : Colors.grey[
                                                                        400],
                                                                fontSize: 10.5,
                                                              ),
                                                            ),
                                                            store.state.preOrderCartState[index]
                                                                            [
                                                                            'details']
                                                                        [
                                                                        'color'] ==
                                                                    null
                                                                ? TextSpan(
                                                                    text: "",
                                                                    style: KTextStyle
                                                                        .bodyText4
                                                                        .copyWith(
                                                                      color: store.state.darkModeState == null ||
                                                                              store.state.darkModeState ==
                                                                                  false
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .grey[400],
                                                                      fontSize:
                                                                          10.5,
                                                                    ),
                                                                  )
                                                                : TextSpan(
                                                                    text:
                                                                        "${store.state.preOrderCartState[index]['details']['color']} ",
                                                                    style: KTextStyle
                                                                        .bodyText4
                                                                        .copyWith(
                                                                      color: store.state.darkModeState == null ||
                                                                              store.state.darkModeState ==
                                                                                  false
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .grey[400],
                                                                      fontSize:
                                                                          10.5,
                                                                    ),
                                                                  ),
                                                            store.state.preOrderCartState[index]
                                                                            [
                                                                            'details']
                                                                        [
                                                                        'size'] ==
                                                                    null
                                                                ? TextSpan(
                                                                    text: "",
                                                                    style: KTextStyle
                                                                        .bodyText4
                                                                        .copyWith(
                                                                      color: store.state.darkModeState == null ||
                                                                              store.state.darkModeState ==
                                                                                  false
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .grey[400],
                                                                      fontSize:
                                                                          10.5,
                                                                    ),
                                                                  )
                                                                : TextSpan(
                                                                    text: store
                                                                            .state
                                                                            .preOrderCartState[index]['details']
                                                                        [
                                                                        'size'],
                                                                    style: KTextStyle
                                                                        .bodyText4
                                                                        .copyWith(
                                                                      color: store.state.darkModeState == null ||
                                                                              store.state.darkModeState ==
                                                                                  false
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .grey[400],
                                                                      fontSize:
                                                                          10.5,
                                                                    ),
                                                                  ),
                                                            TextSpan(
                                                              text:
                                                                  "x (${store.state.preOrderCartState[index]['quantity']})",
                                                              style: KTextStyle
                                                                  .bodyText4
                                                                  .copyWith(
                                                                color: store.state.darkModeState ==
                                                                            null ||
                                                                        store.state.darkModeState ==
                                                                            false
                                                                    ? Colors
                                                                        .black
                                                                    : Colors.grey[
                                                                        400],
                                                                fontSize: 10.5,
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                ]),
                                            (store.state.preOrderCartState[
                                                            index]['mproduct']
                                                        ['appDiscount'] >
                                                    0)
                                                ? Text(
                                                    "${(store.state.preOrderCartState[index]['details']['sellingPrice'] - (store.state.preOrderCartState[index]['details']['sellingPrice'] * store.state.preOrderCartState[index]['mproduct']['appDiscount']) / 100).toInt() * store.state.preOrderCartState[index]['quantity']}",
                                                    style: KTextStyle.bodyText4
                                                        .copyWith(
                                                            color: store.state
                                                                            .darkModeState ==
                                                                        null ||
                                                                    store.state
                                                                            .darkModeState ==
                                                                        false
                                                                ? Colors.black
                                                                : Colors
                                                                    .grey[400],
                                                            fontSize: 10.5),
                                                  )
                                                : Text(
                                                    "${store.state.preOrderCartState[index]['details']['sellingPrice'] * store.state.preOrderCartState[index]['quantity']}",
                                                    style: KTextStyle.bodyText4
                                                        .copyWith(
                                                            color: store.state
                                                                            .darkModeState ==
                                                                        null ||
                                                                    store.state
                                                                            .darkModeState ==
                                                                        false
                                                                ? Colors.black
                                                                : Colors
                                                                    .grey[400],
                                                            fontSize: 10.5),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  indent: 15,
                                  endIndent: 15,
                                  color: store.state.darkModeState == null ||
                                          store.state.darkModeState == false
                                      ? Colors.black
                                      : Colors.grey[400],
                                  height: 4.5 * SizeConfig.imageSizeMultiplier,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          3.5 * SizeConfig.imageSizeMultiplier,
                                          0.0 * SizeConfig.imageSizeMultiplier,
                                          3.5 * SizeConfig.imageSizeMultiplier,
                                          0.0 * SizeConfig.imageSizeMultiplier),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Sub Total",
                                                style: KTextStyle.bodyText4.copyWith(
                                                    color: store.state
                                                                    .darkModeState ==
                                                                null ||
                                                            store.state
                                                                    .darkModeState ==
                                                                false
                                                        ? Colors.black
                                                        : Colors.grey[400],
                                                    fontSize: 10.5,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                "${widget.sum}",
                                                style: KTextStyle.bodyText4
                                                    .copyWith(
                                                  color: store.state
                                                                  .darkModeState ==
                                                              null ||
                                                          store.state
                                                                  .darkModeState ==
                                                              false
                                                      ? Colors.black
                                                      : Colors.grey[400],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10.5,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.3 *
                                                SizeConfig.imageSizeMultiplier,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      indent: 15,
                                      endIndent: 15,
                                      color: store.state.darkModeState ==
                                                  null ||
                                              store.state.darkModeState == false
                                          ? Colors.black
                                          : Colors.grey[400],
                                      height:
                                          4 * SizeConfig.imageSizeMultiplier,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          3.5 * SizeConfig.imageSizeMultiplier,
                                          0.0 * SizeConfig.imageSizeMultiplier,
                                          3.5 * SizeConfig.imageSizeMultiplier,
                                          0.0 * SizeConfig.imageSizeMultiplier),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 1.3 *
                                                SizeConfig.imageSizeMultiplier,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(0),
                                            child: _shippingCost(),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Shipping Cost",
                                                style: KTextStyle.bodyText4
                                                    .copyWith(
                                                  color: store.state
                                                                  .darkModeState ==
                                                              null ||
                                                          store.state
                                                                  .darkModeState ==
                                                              false
                                                      ? Colors.black
                                                      : Colors.grey[400],
                                                  fontSize: 10.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                store.state.subTotalState !=
                                                            null &&
                                                        store.state
                                                                .subTotalState >
                                                            3000
                                                    ? "${0}"
                                                    : shippingCost.toString(),
                                                style: KTextStyle.bodyText4
                                                    .copyWith(
                                                  color: store.state
                                                                  .darkModeState ==
                                                              null ||
                                                          store.state
                                                                  .darkModeState ==
                                                              false
                                                      ? Colors.black
                                                      : Colors.grey[400],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10.5,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      indent: 15,
                                      endIndent: 15,
                                      color: store.state.darkModeState ==
                                                  null ||
                                              store.state.darkModeState == false
                                          ? Colors.black
                                          : Colors.grey[400],
                                      height:
                                          4 * SizeConfig.imageSizeMultiplier,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          3.5 * SizeConfig.imageSizeMultiplier,
                                          0.0 * SizeConfig.imageSizeMultiplier,
                                          3.5 * SizeConfig.imageSizeMultiplier,
                                          3.0 * SizeConfig.imageSizeMultiplier),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total",
                                            style:
                                                KTextStyle.bodyText4.copyWith(
                                              color: store.state
                                                              .darkModeState ==
                                                          null ||
                                                      store.state
                                                              .darkModeState ==
                                                          false
                                                  ? Colors.black
                                                  : Colors.grey[400],
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10.5,
                                            ),
                                          ),
                                          Text(
                                            "\৳${(shippingCost + widget.sum).toString()}",
                                            style: KTextStyle.bodyText4.copyWith(
                                                color: store.state
                                                                .darkModeState ==
                                                            null ||
                                                        store.state
                                                                .darkModeState ==
                                                            false
                                                    ? Colors.black
                                                    : Colors.grey[400],
                                                fontWeight: FontWeight.w700,
                                                fontSize: 10.5),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 2.1 * SizeConfig.imageSizeMultiplier,
                        right: 2.1 * SizeConfig.imageSizeMultiplier,
                        top: 2.1 * SizeConfig.imageSizeMultiplier,
                        bottom: 0.9 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: Text(
                        "Payments",
                        style: KTextStyle.subtitle3.copyWith(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
                      child: Column(
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     setState(() {
                          //       isChecked1 = !isChecked1;
                          //       isChecked2 = false;
                          //       isChecked3 = false;
                          //       paymentMethod = "Cash on delivery";
                          //       print(paymentMethod);
                          //     });
                          //   },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         border: Border.all(
                          //             color: store.state.darkModeState ==
                          //                         null ||
                          //                     store.state.darkModeState == false
                          //                 ? Colors.black
                          //                 : Colors.white)),
                          //     child: Row(
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.all(12.0),
                          //           child: Container(
                          //             width: 20,
                          //             height: 20,
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: store.state
                          //                                     .darkModeState ==
                          //                                 null ||
                          //                             store.state
                          //                                     .darkModeState ==
                          //                                 false
                          //                         ? Colors.black
                          //                         : Colors.white)),
                          //             child: isChecked1 == true
                          //                 ? Padding(
                          //                     padding:
                          //                         const EdgeInsets.all(3.2),
                          //                     child: Container(
                          //                       width: 12,
                          //                       height: 12,
                          //                       color: Colors.red,
                          //                     ),
                          //                   )
                          //                 : Container(),
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           width: 14 * SizeConfig.imageSizeMultiplier,
                          //         ),
                          //         Image.asset(
                          //           "assets/icons/cod.png",
                          //           height: 30,
                          //           width: 30,
                          //           color: store.state.darkModeState == null ||
                          //                   store.state.darkModeState == false
                          //               ? null
                          //               : Colors.grey,
                          //         ),
                          //         SizedBox(
                          //           width: 8,
                          //         ),
                          //         Text("CASH ON DELIVERY",
                          //             style: KTextStyle.bodyText4.copyWith(
                          //               color:
                          //                   store.state.darkModeState == null ||
                          //                           store.state.darkModeState ==
                          //                               false
                          //                       ? Colors.black
                          //                       : Colors.grey[400],
                          //             ),
                          //             textAlign: TextAlign.start),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     setState(() {
                          //       isChecked2 = !isChecked2;
                          //       isChecked1 = false;
                          //       isChecked3 = false;
                          //       paymentMethod = "Bkash";
                          //       print(paymentMethod);
                          //     });
                          //   },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //         border: Border.all(color: Colors.black)),
                          //     child: Row(
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.all(12.0),
                          //           child: Container(
                          //             width: 20,
                          //             height: 20,
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: store.state
                          //                                     .darkModeState ==
                          //                                 null ||
                          //                             store.state
                          //                                     .darkModeState ==
                          //                                 false
                          //                         ? Colors.black
                          //                         : Colors.white)),
                          //             child: isChecked2 == true
                          //                 ? Padding(
                          //                     padding:
                          //                         const EdgeInsets.all(3.2),
                          //                     child: Container(
                          //                       width: 12,
                          //                       height: 12,
                          //                       color: Colors.red,
                          //                     ),
                          //                   )
                          //                 : Container(),
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           width: 26 * SizeConfig.imageSizeMultiplier,
                          //         ),
                          //         Text("bkash",
                          //             style: KTextStyle.bodyText4.copyWith(
                          //               color:
                          //                   store.state.darkModeState == null ||
                          //                           store.state.darkModeState ==
                          //                               false
                          //                       ? Colors.black
                          //                       : Colors.grey[400],
                          //             ),
                          //             textAlign: TextAlign.start),
                          //         Image.asset(
                          //           "assets/icons/bkash.png",
                          //           height: 30,
                          //           width: 12 * SizeConfig.imageSizeMultiplier,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isChecked3 = !isChecked3;
                                isChecked1 = false;
                                isChecked2 = false;
                                paymentMethod = "sslcommerz";
                                print(paymentMethod);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: store.state
                                                              .darkModeState ==
                                                          null ||
                                                      store.state
                                                              .darkModeState ==
                                                          false
                                                  ? Colors.black
                                                  : Colors.white)),
                                      child: isChecked3 == true
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(3.2),
                                              child: Container(
                                                width: 12,
                                                height: 12,
                                                color: Colors.red,
                                              ),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14 * SizeConfig.imageSizeMultiplier,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/visa.png",
                                        height: 30,
                                        width:
                                            12 * SizeConfig.imageSizeMultiplier,
                                      ),
                                      SizedBox(
                                        width:
                                            3 * SizeConfig.imageSizeMultiplier,
                                      ),
                                      Image.asset(
                                        "assets/icons/mastercard.png",
                                        height: 30,
                                        width:
                                            12 * SizeConfig.imageSizeMultiplier,
                                      ),
                                      SizedBox(
                                        width:
                                            3 * SizeConfig.imageSizeMultiplier,
                                      ),
                                      Image.asset(
                                        "assets/icons/american.png",
                                        height: 30,
                                        width:
                                            12 * SizeConfig.imageSizeMultiplier,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        fullAddress == ''
                            ? _showMsg("Full Address is Empty!", 1)
                            : postalCode == ''
                                ? _showMsg("Post Code is Empty!", 1)
                                : placeOrder();
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
                          child: Text("Place Order",
                              style: KTextStyle.buttonText3.copyWith(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center)),
                    ),
                  ),
                ),
                SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
              ],
            ),
          )
        ],
      )),
    );
  }

  Future<void> placeOrder() async {
    var data = {
      'billingCity': city,
      'billingZone': zone,
      'billingArea': area == 'Select Area' ? '' : area,
      'billingAddress': fullAddress,
      'postCode': postalCode,
      'isDifferentShipping': 0,
      'notes': orderNotes.text,
      'shippingPrice': shippingCost,
      'coupon': "",
      'discountType': "",
      'discount': 0,
      'referralCode': "",
      'giftVoucherCode': "",
      'giftVoucherAmount': 0,
      'isDGMoney': 0,
      'dgAmount': 0,
      'roundAmount': 0,
      'refferalDiscount': 0,
      'membershipDiscount': 0,
      'promoDiscount': 0,
      'refferalDiscountAmount': 0,
      'membershipDiscountAmount': 0,
      'promoDiscountAmount': 0,
      'totalSellingPrice': 0,
      'subTotal': widget.sum,
      'grandTotal': (shippingCost + widget.sum),
      'paymentType': paymentMethod,
      'name': fullName,
      'contact': phone,
      'cartItems': store.state.preOrderCartState,
      'date': "${DateTime.now()}",
    };
    print("-------$data--------");
    var res = await CallApi().postData(data, '/app/pre-order/order');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg(body['message'], 2);
      setState(() {
        store.state.userDataState['customer']['address'] = fullAddress;
        store.state.userDataState['customer']['postCode'] = postalCode;
        store.state.userDataState['customer']['cityId'] = cityId;
        store.state.userDataState['customer']['zoneId'] = zoneId;
        store.state.userDataState['customer']['areaId'] = areaId;
        print(body['order']['id']);
      });

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'userData', json.encode(store.state.userDataState));
      setState(() {
        store.state.userDataState =
            json.decode(localStorage.getString('userData')!);
        store.dispatch(UserDataAction(store.state.userDataState));
      });
      store.state.subTotalState = null;
      SharedPreferences getVariableProductStorage =
          await SharedPreferences.getInstance();
      getVariableProductStorage.remove('variableProductData');
      store.state.cartProductState = [];
      store.state.cartDataState = [];
      store.state.getVariableProductState = null;
      if (data['paymentType'] == 'sslcommerz') {
        var tranId = "PX${body['order']['id'].toString()}";
        var grandTotal = double.parse(data['grandTotal']) +
            double.parse(data['shippingPrice'].toString());

        var result = await EasySSLCommerz(
          tranId: tranId,
          amount: grandTotal.toDouble(),
          customerAddress1: fullAddress,
          customerCity: city,
          customerCountry: "Bangladesh",
          customerEmail: email,
          customerPhone: phone.toString(),
          customerPostCode: postalCode.toString(),
        ).payNow();
        if (result is PlatformException) {
          print("the response is: " +
              result.message.toString() +
              " code: " +
              result.code);
          Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => PaymentCancel()),
              ModalRoute.withName('/'));
        } else {
          SSLCTransactionInfoModel model = result as SSLCTransactionInfoModel;
          print("SSLCTransactionInfoModel: $model");
          if (model.status == "VALID") {
            Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => PaymentSuccessfull()),
              ModalRoute.withName('/'),
            );
          } else {
            Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => PaymentCancel()),
              ModalRoute.withName('/'),
            );
          }
        }
      } else {
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  OrderSuccessFull(body['order']['id'])),
          ModalRoute.withName('/'),
        );
      }
    }
  }

  _showMsg(msg, numb) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor:
            numb == 1 ? Colors.red.withOpacity(0.9) : Colors.green[400],
        textColor: Colors.white,
        fontSize: 13.0);
  }

  _shippingCost() {
    var value = store.state.zoneState;
    setState(() {
      int index = value.indexWhere((element) =>
          element['id'] == store.state.userDataState['customer']['zoneId']);
      shippingCost = store.state.userDataState['customer']['zoneId'] == null
          ? 0
          : store.state.zoneState[index]['delivery'];
      print("ShippingPrice === $shippingCost");
    });
  }

  showCity(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: Colors.black),
                    child: Text(
                      "SELECT DISTRICT",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  //SizedBox(height: 12),
                  Container(
                      color: Colors.white,
                      height: 400.0, // Change as per your requirement
                      width: 300.0, // Change as per your requirement
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              store.state.districtState.length,
                              (index) => GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    city = store.state.districtState[index]
                                        ['name'];
                                    cityId =
                                        store.state.districtState[index]['id'];

                                    var zone = store.state.zoneState;
                                    zoneListByCity = zone
                                        .where((zoneItem) =>
                                            zoneItem['city_id'] == cityId)
                                        .toList();
                                    store.dispatch(IsLoadingAction(false));
                                  });

                                  setState(() {
                                    store.state.userDataState['customer']
                                        ['cityId'] = cityId;
                                    store.dispatch(DistrictNameAction(city));
                                  });

                                  SharedPreferences localStorage =
                                      await SharedPreferences.getInstance();
                                  localStorage.setString('userData',
                                      json.encode(store.state.userDataState));
                                  setState(() {
                                    store.state.userDataState = json.decode(
                                        localStorage.getString('userData')!);
                                    store.dispatch(UserDataAction(
                                        store.state.userDataState));
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 12 * SizeConfig.imageSizeMultiplier,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 0.8,
                                      ))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0 *
                                            SizeConfig.imageSizeMultiplier),
                                    child: Text(store.state.districtState[index]
                                        ['name']),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  )
                ]),
          ),
        );
      });
  showZone(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: Colors.black),
                    child: Text(
                      "SELECT ZONE",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  //SizedBox(height: 12),
                  Container(
                      color: Colors.white,
                      height: 400.0, // Change as per your requirement
                      width: 300.0, // Change as per your requirement
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              zoneId == 0
                                  ? store.state.zoneState.length
                                  : zoneListByCity.length,
                              (index) => GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    zone = zoneId == 0
                                        ? store.state.zoneState[index]
                                            ['zoneName']
                                        : zoneListByCity[index]['zoneName'];
                                    zoneId = zoneId == 0
                                        ? store.state.zoneState[index]['id']
                                        : zoneListByCity[index]['id'];

                                    var area = store.state.areaState;
                                    areaListByZone = area
                                        .where((areaItem) =>
                                            areaItem['zone_id'] == zoneId)
                                        .toList();
                                  });
                                  setState(() {
                                    store.state.userDataState['customer']
                                        ['zoneId'] = zoneId;
                                    store.dispatch(ZoneNameAction(zone));
                                  });

                                  SharedPreferences localStorage =
                                      await SharedPreferences.getInstance();
                                  localStorage.setString('userData',
                                      json.encode(store.state.userDataState));
                                  setState(() {
                                    store.state.userDataState = json.decode(
                                        localStorage.getString('userData')!);
                                    store.dispatch(UserDataAction(
                                        store.state.userDataState));
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 12 * SizeConfig.imageSizeMultiplier,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 0.8,
                                      ))),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0 *
                                              SizeConfig.imageSizeMultiplier),
                                      child: Text(zoneId == 0
                                          ? store.state.zoneState[index]
                                              ['zoneName']
                                          : zoneListByCity[index]['zoneName'])),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  )
                ]),
          ),
        );
      });
  showarea(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: Colors.black),
                    child: Text(
                      "SELECT AREA",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  //SizedBox(height: 12),
                  Container(
                      color: Colors.white,
                      height: 400.0, // Change as per your requirement
                      width: 300.0, // Change as per your requirement
                      child: SingleChildScrollView(
                        child: Column(
                          children: zoneId == 0 && areaId == 0
                              ? List.generate(
                                  store.state.areaState.length,
                                  (index) => GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        area = store.state.areaState[index]
                                            ['name'];
                                        areaId =
                                            store.state.areaState[index]['id'];
                                        store.dispatch(AreaNameAction(area));
                                      });
                                      setState(() {
                                        store.state.userDataState['customer']
                                            ['areaId'] = areaId;
                                      });

                                      SharedPreferences localStorage =
                                          await SharedPreferences.getInstance();
                                      localStorage.setString(
                                          'userData',
                                          json.encode(
                                              store.state.userDataState));
                                      setState(() {
                                        store.state.userDataState = json.decode(
                                            localStorage
                                                .getString('userData')!);
                                        store.dispatch(UserDataAction(
                                            store.state.userDataState));
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height:
                                          12 * SizeConfig.imageSizeMultiplier,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                              bottom: BorderSide(
                                            color: Colors.grey[300]!,
                                            width: 0.8,
                                          ))),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0 *
                                                SizeConfig.imageSizeMultiplier),
                                        child: store.state.areaState[index]
                                            ['name'],
                                      ),
                                    ),
                                  ),
                                )
                              : List.generate(
                                  areaListByZone.length,
                                  (index) => GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        area = areaListByZone[index]['name'];
                                        areaId = areaListByZone[index]['id'];
                                        store.dispatch(AreaNameAction(area));
                                      });
                                      setState(() {
                                        store.state.userDataState['customer']
                                            ['areaId'] = areaId;
                                      });

                                      SharedPreferences localStorage =
                                          await SharedPreferences.getInstance();
                                      localStorage.setString(
                                          'userData',
                                          json.encode(
                                              store.state.userDataState));
                                      setState(() {
                                        store.state.userDataState = json.decode(
                                            localStorage
                                                .getString('userData')!);
                                        store.dispatch(UserDataAction(
                                            store.state.userDataState));
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height:
                                          12 * SizeConfig.imageSizeMultiplier,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                              bottom: BorderSide(
                                            color: Colors.grey[300]!,
                                            width: 0.8,
                                          ))),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0 *
                                                SizeConfig.imageSizeMultiplier),
                                        child:
                                            Text(areaListByZone[index]['name']),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  )
                ]),
          ),
        );
      });

  Widget buildSingleCheckBox(NotificationSetting notification) => buildCheckBox(
      notification: notification,
      onClicked: () {
        setState(() {
          final newValue = !notification.value;
          notification.value = newValue;
          paymentMethod = notification.title;
        });

        print("payment system $paymentMethod");
      });

  Widget buildCheckBox({
    required NotificationSetting notification,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        //minVerticalPadding: -2,
        onTap: onClicked,
        leading: Checkbox(
          value: notification.value,
          onChanged: (value) => onClicked(),
        ),
        title: Text(notification.title,
            style: GoogleFonts.montserrat(
                color: store.state.darkModeState == null ||
                        store.state.darkModeState == false
                    ? Colors.black
                    : Colors.grey[400],
                fontSize: 3 * SizeConfig.imageSizeMultiplier),
            textAlign: TextAlign.start),
      );
}
