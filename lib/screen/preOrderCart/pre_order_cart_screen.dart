import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/home_screen/home_screen.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/preOrderCart/pre_order_checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import '../../main.dart';
import '../../size_config.dart';

class PreOrderCartScreen extends StatefulWidget {
  @override
  _PreOrderCartScreenState createState() => _PreOrderCartScreenState();
}

class _PreOrderCartScreenState extends State<PreOrderCartScreen> {
  List<dynamic> zoneListByCity = [];
  List<dynamic> areaListByZone = [];
  void initState() {
    _getPreOrderCart();
    _getAllDistrictApiData();
    _getAllZoneApiData();
    _getAllAreaApiData();
    super.initState();
  }

  Future<void> _getAllDistrictApiData() async {
    var resAllFilterDistrict =
        await CallApi().withoutTokengetData('/app/cities');
    if (resAllFilterDistrict.statusCode == 200) {
      var body = json.decode(resAllFilterDistrict.body);
      store.dispatch(DistrictAction(body['cities']));
      cityId = store.state.userDataState['customer']['cityId'];
      setState(() {
        var value = store.state.districtState;
        var index = value.indexWhere((element) => element['id'] == cityId);
        cityId == 0
            ? city = city
            : city = store.state.districtState[index]['name'];
      });
      print("store.state.districtState");
      print(store.state.districtState);
    } else {
      print("hello");
    }
  }

  Future<void> _getAllZoneApiData() async {
    var resAllFilterZones = await CallApi().withoutTokengetData('/app/zones');
    if (resAllFilterZones.statusCode == 200) {
      var body = json.decode(resAllFilterZones.body);
      store.dispatch(ZoneAction(body['zones']));

      setState(() {
        zoneId = store.state.userDataState['customer']['zoneId'];

        var value = store.state.zoneState;
        var index = value.indexWhere((element) => element['id'] == zoneId);
        zoneId == 0
            ? zone = zone
            : zone = store.state.zoneState[index]['zoneName'];
        zoneListByCity =
            value.where((zoneItem) => zoneItem['city_id'] == cityId).toList();
      });
      print("store.state.zonesState");
      print(store.state.zoneState);
    } else {
      print("hello");
    }
  }

  Future<void> _getAllAreaApiData() async {
    var resAllFilterAreas = await CallApi().withoutTokengetData('/app/areas');
    if (resAllFilterAreas.statusCode == 200) {
      var body = json.decode(resAllFilterAreas.body);
      store.dispatch(AreasAction(body['areas']));
      setState(() {
        areaId = store.state.userDataState['customer']['areaId'];
        var value = store.state.areaState;
        var index = value.indexWhere((element) => element['id'] == areaId);
        areaId == 0 ? area = area : area = store.state.areaState[index]['name'];
        areaListByZone =
            value.where((areaItem) => areaItem['zone_id'] == zoneId).toList();
      });
      print("store.state.areasState");
      print(store.state.areaState);
    } else {
      print("hello");
    }
  }
  Future<void> _getPreOrderCart() async {
    //var data = store.state.cartDataState;

    setState(() {
      for (int i = 0; i < store.state.preOrderCartState.length; i++) {
        var totalPrice = (store.state.preOrderCartState[i]['details']
                ['sellingPrice'] *
            store.state.preOrderCartState[i]['quantity']);
        sum = (sum + totalPrice).toInt();
      }
    });

    setState(() {
      store.dispatch(IsLoadingAction(false)); //false chilo
    });
  }

  int sum = 0;
  var stock;
  TextEditingController promoCode = TextEditingController();
  TextEditingController referralCode = TextEditingController();
  TextEditingController giftVoucherCode = TextEditingController();
  List cartList = store.state.preOrderCartState;

  String city = "Select City";
  int cityId = 0;
  String zone = "Select Zone";
  int zoneId = 0;
  String area = "Select Area";
  int areaId = 0;
  var shippingCost;
  // List<String> zoneNameByCity = [];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("Back button press");

        store.state.logoutUserData = null;

        return await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          ModalRoute.withName('/'),
        );
      },
      child: Scaffold(
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
            "Pre-Order Cart",
            style: KTextStyle.headline5.copyWith(
                color: store.state.darkModeState == null ||
                        store.state.darkModeState == false
                    ? Colors.black
                    : Colors.grey[400],
                letterSpacing: 0.4),
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
                // store.state.promoCodeState = null;
                // store.state.referralCodeState = null;
                // store.state.giftVoucherState = null;
                // store.state.logoutUserData = null;
                // store.state.cartDataLogoutState = [];
                // store.state.preOrderCartState = [];
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeScreen()),
                  ModalRoute.withName('/'),
                );
              }),
          centerTitle: true,
        ),
        body: store.state.preOrderCartState.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: store.state.preOrderCartState.length,
                      itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.05 * SizeConfig.imageSizeMultiplier),
                          child: Container(
                            height: 30 * SizeConfig.imageSizeMultiplier,
                            width: double.infinity,
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? kSecondaryColor.withOpacity(0.1)
                                : Colors.grey[900],
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 2.5 * SizeConfig.imageSizeMultiplier,
                                ),
                                SizedBox(
                                  width: 24 * SizeConfig.imageSizeMultiplier,
                                  height: 24 * SizeConfig.imageSizeMultiplier,
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              store.state
                                                      .preOrderCartState[index]
                                                  ['mproduct']['productImage'],
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 4 * SizeConfig.imageSizeMultiplier),
                                Container(
                                  width: 50 * SizeConfig.imageSizeMultiplier,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 2.6 *
                                            SizeConfig.imageSizeMultiplier,
                                      ),
                                      RichText(
                                        maxLines: 3,
                                        text: TextSpan(
                                            text:
                                                "${store.state.preOrderCartState[index]['details']['productName']} ",
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
                                              fontSize: 10.5,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${store.state.preOrderCartState[index]['details']['model']} ",
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
                                                ),
                                              ),
                                              store.state.preOrderCartState[
                                                              index]['details']
                                                          ['color'] ==
                                                      null
                                                  ? TextSpan(
                                                      text: "",
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
                                                            : Colors.grey[400],
                                                        fontSize: 10.5,
                                                      ),
                                                    )
                                                  : TextSpan(
                                                      text:
                                                          "${store.state.preOrderCartState[index]['details']['color']} ",
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
                                                            : Colors.grey[400],
                                                        fontSize: 10.5,
                                                      ),
                                                    ),
                                              store.state.preOrderCartState[
                                                              index]['details']
                                                          ['size'] ==
                                                      null
                                                  ? TextSpan(
                                                      text: "",
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
                                                            : Colors.grey[400],
                                                        fontSize: 10.5,
                                                      ),
                                                    )
                                                  : TextSpan(
                                                      text: store.state
                                                              .preOrderCartState[
                                                          index]['details']['size'],
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
                                                            : Colors.grey[400],
                                                        fontSize: 10.5,
                                                      ),
                                                    ),
                                            ]),
                                      ),
                                      SizedBox(
                                          height: 1.3 *
                                              SizeConfig.imageSizeMultiplier),
                                      (store.state.preOrderCartState[index]
                                                  ['mproduct']['appDiscount'] >
                                              0)
                                          ? Text.rich(
                                              TextSpan(
                                                text:
                                                    "\৳${(store.state.preOrderCartState[index]['details']['sellingPrice'] - (store.state.preOrderCartState[index]['details']['sellingPrice'] * store.state.preOrderCartState[index]['mproduct']['appDiscount']) / 100).toInt()}",
                                                style: KTextStyle.bodyText4
                                                    .copyWith(
                                                  color: Colors.redAccent,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        " x${store.state.preOrderCartState[index]['quantity']}",
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Text.rich(
                                              TextSpan(
                                                text:
                                                    "\৳${store.state.preOrderCartState[index]['details']['sellingPrice'].toInt()}",
                                                style: KTextStyle.bodyText4
                                                    .copyWith(
                                                  color: Colors.redAccent,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        " x${store.state.preOrderCartState[index]['quantity']}",
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      SizedBox(
                                          height: 1.3 *
                                              SizeConfig.imageSizeMultiplier),
                                      Container(
                                        height: 25.5,
                                        width: 95,
                                        color: Colors.white,
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (store.state
                                                              .preOrderCartState[
                                                          index]['quantity'] >
                                                      1) {
                                                    setState(() {
                                                      --store.state
                                                              .preOrderCartState[
                                                          index]['quantity'];
                                                      getUpdateQty();
                                                      minusSubTotal();
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  width: 26,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.5)),
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    FontAwesomeIcons.minus,
                                                    size: 9,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: 37,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.5)),
                                                child: Text(
                                                  store
                                                      .state
                                                      .preOrderCartState[index]
                                                          ['quantity']
                                                      .toString(),
                                                  style: KTextStyle.bodyText4
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.black),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (stock !=
                                                        store.state
                                                                .preOrderCartState[
                                                            index]['quantity']) {
                                                      store.state
                                                              .preOrderCartState[
                                                          index]['quantity']++;
                                                      getUpdateQty();
                                                      addSubTotal();
                                                    } else {
                                                      return _showMsg(
                                                          "Product out of Stock!",
                                                          1);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.5)),
                                                  width: 26,
                                                  child: Icon(
                                                    FontAwesomeIcons.plus,
                                                    size: 9,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        1.5 * SizeConfig.imageSizeMultiplier),
                                Container(
                                  width: 15 * SizeConfig.imageSizeMultiplier,
                                  child: Column(
                                    children: [
                                      IconButton(
                                          icon: Icon(FontAwesomeIcons.trashAlt),
                                          color: Colors.grey[700],
                                          iconSize: 18,
                                          alignment: Alignment.topRight,
                                          onPressed: () async {
                                            setState(() {
                                              //cartList.remove(store.state.preOrderCartState[index]['id']);
                                              deleteFromCart();
                                            });
                                          }),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      (store.state.preOrderCartState[index]
                                                  ['mproduct']['appDiscount'] >
                                              0)
                                          ? Text(
                                              "\৳${(store.state.preOrderCartState[index]['details']['sellingPrice'] - (store.state.preOrderCartState[index]['details']['sellingPrice'] * store.state.preOrderCartState[index]['mproduct']['appDiscount']) / 100).toInt() * store.state.preOrderCartState[index]['quantity']}",
                                              style:
                                                  KTextStyle.bodyText4.copyWith(
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          : Text(
                                              "\৳${store.state.preOrderCartState[index]['details']['sellingPrice'] * store.state.preOrderCartState[index]['quantity']}",
                                              style:
                                                  KTextStyle.bodyText4.copyWith(
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                    Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                  2.1 * SizeConfig.imageSizeMultiplier),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Calculate Shipping",
                                    style: KTextStyle.subtitle3.copyWith(
                                      color: store.state.darkModeState ==
                                                  null ||
                                              store.state.darkModeState == false
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        1.6 * SizeConfig.imageSizeMultiplier,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            46 * SizeConfig.imageSizeMultiplier,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.2 *
                                                    SizeConfig
                                                        .imageSizeMultiplier,
                                                right: 0.2 *
                                                    SizeConfig
                                                        .imageSizeMultiplier,
                                                bottom: 0.0 *
                                                    SizeConfig
                                                        .imageSizeMultiplier),
                                            child: GestureDetector(
                                              onTap: () {
                                                showCity(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 2.1 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                  vertical: 1.6 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                ),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  color: store.state
                                                                  .darkModeState ==
                                                              null ||
                                                          store.state
                                                                  .darkModeState ==
                                                              false
                                                      ? kSecondaryColor
                                                          .withOpacity(0.1)
                                                      : Colors.grey[900],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 8, 12, 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        store.state.districtName ==
                                                                null
                                                            ? city.toString()
                                                            : city
                                                                .toString(), //brandTitle
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
                                      SizedBox(
                                        width: 3.8 *
                                            SizeConfig.imageSizeMultiplier,
                                      ),
                                      Container(
                                        width:
                                            46 * SizeConfig.imageSizeMultiplier,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.2 *
                                                    SizeConfig
                                                        .imageSizeMultiplier,
                                                right: 0.2 *
                                                    SizeConfig
                                                        .imageSizeMultiplier,
                                                bottom: 0.0 *
                                                    SizeConfig
                                                        .imageSizeMultiplier),
                                            child: GestureDetector(
                                              onTap: () {
                                                showZone(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 2.1 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                  vertical: 1.6 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                ),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  color: store.state
                                                                  .darkModeState ==
                                                              null ||
                                                          store.state
                                                                  .darkModeState ==
                                                              false
                                                      ? kSecondaryColor
                                                          .withOpacity(0.1)
                                                      : Colors.grey[900],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12, 8, 12, 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        store.state.zoneName ==
                                                                null
                                                            ? zone.toString()
                                                            : zone
                                                                .toString(), //brandTitle
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
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                              12, 8, 12, 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                store.state.areaName == null
                                                    ? area.toString()
                                                    : area
                                                        .toString(), //brandTitle
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
                            SizedBox(
                              height: 2 * SizeConfig.imageSizeMultiplier,
                            )
                          ],
                        )),
                    Padding(
                      padding:
                          EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
                      child: Container(
                        height: 35 * SizeConfig.imageSizeMultiplier,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? kSecondaryColor.withOpacity(0.1)
                              : Colors.grey[900],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                  3.5 * SizeConfig.imageSizeMultiplier),
                              child: Text(
                                "Cart Summary",
                                style: KTextStyle.subtitle3.copyWith(
                                  color: store.state.darkModeState == null ||
                                          store.state.darkModeState == false
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                              ),
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
                                            ),
                                          ),
                                          Text(
                                            sum.toString(),
                                            style: KTextStyle.caption.copyWith(
                                              color: store.state
                                                              .darkModeState ==
                                                          null ||
                                                      store.state
                                                              .darkModeState ==
                                                          false
                                                  ? Colors.black
                                                  : Colors.grey[400],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.3 *
                                            SizeConfig.imageSizeMultiplier,
                                      ),
                                      SizedBox(
                                        height: 1.3 *
                                            SizeConfig.imageSizeMultiplier,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Shipping Cost",
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
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(0),
                                            child: _shippingCost(),
                                          ),
                                          (store.state.subTotalState != null &&
                                                  store.state.subTotalState >
                                                      3000)
                                              ? Text(
                                                  "0",
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
                                                  ),
                                                )
                                              : Text(
                                                  shippingCost.toString(),
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
                                                  ),
                                                ),
                                        ],
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
                                  height: 4 * SizeConfig.imageSizeMultiplier,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      3.5 * SizeConfig.imageSizeMultiplier,
                                      0.0 * SizeConfig.imageSizeMultiplier,
                                      3.5 * SizeConfig.imageSizeMultiplier,
                                      0.0 * SizeConfig.imageSizeMultiplier),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: KTextStyle.bodyText4.copyWith(
                                          color: store.state.darkModeState ==
                                                      null ||
                                                  store.state.darkModeState ==
                                                      false
                                              ? Colors.black
                                              : Colors.grey[400],
                                        ),
                                      ),
                                      Text(
                                        "\৳${(shippingCost + sum).toString()}",
                                        style: KTextStyle.bodyText4.copyWith(
                                          color: store.state.darkModeState ==
                                                      null ||
                                                  store.state.darkModeState ==
                                                      false
                                              ? Colors.black
                                              : Colors.grey[400],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
              )
            : Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/empty-cart.png",
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.grey
                            : Colors.grey[700],
                        height: 25 * SizeConfig.imageSizeMultiplier,
                        width: 25 * SizeConfig.imageSizeMultiplier,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Your Pre-Order Shopping Bag is Empty!",
                        style: KTextStyle.subtitle2.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.grey
                              : Colors.grey[700],
                        ),
                      )
                    ]),
              ),
        bottomNavigationBar: store.state.preOrderCartState.isEmpty
            ? null
            : Padding(
                padding: EdgeInsets.all(
                  2.0 * SizeConfig.imageSizeMultiplier,
                ),
                child: InkWell(
                  onTap: () {
                    store.state.userDataState['customer']['cityId'] == 0
                        ? _showMsg("Select City!", 2)
                        : store.state.userDataState['customer']['zoneId'] == 0
                            ? _showMsg("Select Zone!", 2)
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PreOrderCheckOutScreen(sum)));
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
                        child: Text("Proceed To Checkout",
                            style: KTextStyle.buttonText3.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center)),
                  ),
                ),
              ),
      ),
    );
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
                                    zone = cityId == 0
                                        ? store.state.zoneState[index]
                                            ['zoneName']
                                        : zoneListByCity[index]['zoneName'];
                                    zoneId = cityId == 0
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
                                      child: Text(cityId == 0
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
                          children: zoneId == 0
                              ? List.generate(
                                  store.state.areaState.length,
                                  (index) => GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        area = areaListByZone[index]['name'];
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

  Future<void> getUpdateQty() async {
    var cartIndex;
    setState(() {
      List.generate(
          store.state.preOrderCartState.length,
          (index) => store.state.preOrderCartState[index]['quantity'] =
              store.state.preOrderCartState[index]['quantity']);
      List.generate(
          store.state.preOrderCartState.length, (index) => cartIndex = index);
      //
    });

    var data = {
      'categoryId': store.state.preOrderCartState[cartIndex]['categoryId'],
      'created_at': store.state.preOrderCartState[cartIndex]['created_at'],
      'details': {
        'admin_id': store.state.preOrderCartState[cartIndex]['details']
            ['admin_id'],
        'averageBuyingPrice': store.state.preOrderCartState[cartIndex]
            ['details']['averageBuyingPrice'],
        'barCode': store.state.preOrderCartState[cartIndex]['details']
            ['barCode'],
        'brand': store.state.preOrderCartState[cartIndex]['details']['brand'],
        'brandId': store.state.preOrderCartState[cartIndex]['details']
            ['brandId'],
        'catName': store.state.preOrderCartState[cartIndex]['details']
            ['catName'],
        'categoryId': store.state.preOrderCartState[cartIndex]['details']
            ['categoryId'],
        'color': store.state.preOrderCartState[cartIndex]['details']['color'],
        'created_at': store.state.preOrderCartState[cartIndex]['details']
            ['created_at'],
        'date': store.state.preOrderCartState[cartIndex]['details']['date'],
        'discount': store.state.preOrderCartState[cartIndex]['details']
            ['discount'],
        'groupId': store.state.preOrderCartState[cartIndex]['details']
            ['groupId'],
        'groupName': store.state.preOrderCartState[cartIndex]['details']
            ['groupName'],
        'id': store.state.preOrderCartState[cartIndex]['details']['id'],
        'img': store.state.preOrderCartState[cartIndex]['details']['img'],
        'model': store.state.preOrderCartState[cartIndex]['details']['model'],
        'mproductId': store.state.preOrderCartState[cartIndex]['details']
            ['mproductId'],
        'openingQuantity': store.state.preOrderCartState[cartIndex]['details']
            ['openingQuantity'],
        'openingUnitPrice': store.state.preOrderCartState[cartIndex]['details']
            ['openingUnitPrice'],
        'productImage': store.state.preOrderCartState[cartIndex]['details']
            ['productImage'],
        'productName': store.state.preOrderCartState[cartIndex]['details']
            ['productName'],
        'quantity': store.state.preOrderCartState[cartIndex]['details']
            ['quantity'],
        'sellingPrice': store.state.preOrderCartState[cartIndex]['details']
            ['sellingPrice'],
        'size': store.state.preOrderCartState[cartIndex]['details']['size'],
        'stock': store.state.preOrderCartState[cartIndex]['details']['stock'],
        'unit': store.state.preOrderCartState[cartIndex]['details']['unit'],
        'updated_at': store.state.preOrderCartState[cartIndex]['details']
            ['updated_at'],
      },
      'id': store.state.preOrderCartState[cartIndex]['id'],
      'mproduct': {
        'adminDiscount': store.state.preOrderCartState[cartIndex]['mproduct']
            ['adminDiscount'],
        'admin_id': store.state.preOrderCartState[cartIndex]['mproduct']
            ['admin_id'],
        'appDiscount': store.state.preOrderCartState[cartIndex]['mproduct']
            ['appDiscount'],
        'averageBuyingPrice': store.state.preOrderCartState[cartIndex]
            ['mproduct']['averageBuyingPrice'],
        'brandId': store.state.preOrderCartState[cartIndex]['mproduct']
            ['brandId'],
        'categoryId': store.state.preOrderCartState[cartIndex]['mproduct']
            ['categoryId'],
        'created_at': store.state.preOrderCartState[cartIndex]['mproduct']
            ['created_at'],
        'description': store.state.preOrderCartState[cartIndex]['mproduct']
            ['description'],
        'discount': store.state.preOrderCartState[cartIndex]['mproduct']
            ['discount'],
        'groupId': store.state.preOrderCartState[cartIndex]['mproduct']
            ['groupId'],
        'id': store.state.preOrderCartState[cartIndex]['mproduct']['id'],
        'isAvailable': store.state.preOrderCartState[cartIndex]['mproduct']
            ['isAvailable'],
        'isFeatured': store.state.preOrderCartState[cartIndex]['mproduct']
            ['isFeatured'],
        'isNew': store.state.preOrderCartState[cartIndex]['mproduct']['isNew'],
        'model': store.state.preOrderCartState[cartIndex]['mproduct']['model'],
        'openingQuantity': store.state.preOrderCartState[cartIndex]['mproduct']
            ['openingQuantity'],
        'openingUnitPrice': store.state.preOrderCartState[cartIndex]['mproduct']
            ['openingUnitPrice'],
        'productImage': store.state.preOrderCartState[cartIndex]['mproduct']
            ['productImage'],
        'productName': store.state.preOrderCartState[cartIndex]['mproduct']
            ['productName'],
        'sellingPrice': store.state.preOrderCartState[cartIndex]['mproduct']
            ['sellingPrice'],
        'stock': store.state.preOrderCartState[cartIndex]['mproduct']['stock'],
        'totalSale': store.state.preOrderCartState[cartIndex]['mproduct']
            ['totalSale'],
        'updated_at': store.state.preOrderCartState[cartIndex]['mproduct']
            ['updated_at'],
      },
      'mproductId': store.state.preOrderCartState[cartIndex]['mproductId'],
      'product': store.state.preOrderCartState[cartIndex]['product'],
      'productId': store.state.preOrderCartState[cartIndex]['productId'],
      'quantity': store.state.preOrderCartState[cartIndex]['quantity'],
      'subcategoryId': store.state.preOrderCartState[cartIndex]
          ['subcategoryId'],
      'updated_at': store.state.preOrderCartState[cartIndex]['updated_at'],
      'userId': store.state.preOrderCartState[cartIndex]['userId'],
      'vproduct': {
        'admin_id': store.state.preOrderCartState[cartIndex]['vproduct']
            ['admin_id'],
        'averageBuyingPrice': store.state.preOrderCartState[cartIndex]
            ['vproduct']['averageBuyingPrice'],
        'barCode': store.state.preOrderCartState[cartIndex]['vproduct']
            ['barCode'],
        'brand': store.state.preOrderCartState[cartIndex]['vproduct']['brand'],
        'brandId': store.state.preOrderCartState[cartIndex]['vproduct']
            ['brandId'],
        'catName': store.state.preOrderCartState[cartIndex]['vproduct']
            ['catName'],
        'categoryId': store.state.preOrderCartState[cartIndex]['vproduct']
            ['categoryId'],
        'color': store.state.preOrderCartState[cartIndex]['vproduct']['color'],
        'created_at': store.state.preOrderCartState[cartIndex]['vproduct']
            ['created_at'],
        'date': store.state.preOrderCartState[cartIndex]['vproduct']['date'],
        'groupId': store.state.preOrderCartState[cartIndex]['vproduct']
            ['groupId'],
        'groupName': store.state.preOrderCartState[cartIndex]['vproduct']
            ['groupName'],
        'id': store.state.preOrderCartState[cartIndex]['vproduct']['id'],
        'model': store.state.preOrderCartState[cartIndex]['vproduct']['model'],
        'mproductId': store.state.preOrderCartState[cartIndex]['vproduct']
            ['mproductId'],
        'openingQuantity': store.state.preOrderCartState[cartIndex]['vproduct']
            ['openingQuantity'],
        'openingUnitPrice': store.state.preOrderCartState[cartIndex]['vproduct']
            ['openingUnitPrice'],
        'productImage': store.state.preOrderCartState[cartIndex]['vproduct']
            ['productImage'],
        'productName': store.state.preOrderCartState[cartIndex]['vproduct']
            ['productName'],
        'sellingPrice': store.state.preOrderCartState[cartIndex]['vproduct']
            ['sellingPrice'],
        'size': store.state.preOrderCartState[cartIndex]['vproduct']['v'],
        'stock': store.state.preOrderCartState[cartIndex]['vproduct']['stock'],
        'unit': store.state.preOrderCartState[cartIndex]['vproduct']['unit'],
        'updated_at': store.state.preOrderCartState[cartIndex]['vproduct']
            ['updated_at'],
      }
    };
    var res = await CallApi().postData(data, '/app/update-pre-order-cart');
    var body = json.decode(res.body);
    print('CartUpdate body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Quantity Updated!", 2);
    } else {
      _showMsg("Please login to add WishList ! ", 1);
    }
  }

  addSubTotal() {
    for (int i = 0; i < store.state.preOrderCartState.length; i++) {
      var totalPrice = (store.state.preOrderCartState[i]['details']
              ['sellingPrice'] *
          store.state.preOrderCartState[i]['quantity']);
      sum = totalPrice.toInt();
    }
  }

  minusSubTotal() {
    for (int i = 0; i < store.state.preOrderCartState.length; i++) {
      var totalPrice = (store.state.preOrderCartState[i]['details']
              ['sellingPrice'] *
          store.state.preOrderCartState[i]['quantity']);
      sum = totalPrice.toInt();
    }
  }

  deleteFromCart() async {
    var idIndex;
    List.generate(
        store.state.preOrderCartState.length, (index) => idIndex = index);
    var data;
    data = {
      'id': store.state.preOrderCartState[idIndex]['id'],
    };
    print(
        "preOrderCartState delete _ ${store.state.preOrderCartState[idIndex]['id']}");
    var res = await CallApi().postData(data, '/app/delete-pre-order-cart');
    var body = json.decode(res.body);
    print('CartUpdate body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Delete from Cart", 1);
    } else {
      _showMsg("Delete Something went wrong ! ", 1);
    }

    var resAllCart = await CallApi().getData('/app/pre-order-cart');
    print(resAllCart);
    if (resAllCart.statusCode == 200) {
      sum = 0;
      var body = json.decode(resAllCart.body);
      print('body -=-=-=-=--=-=-=-=-= $body');
      setState(() {
        store.dispatch(PreOrderCartAction(body['allCarts']));
        for (int i = 0; i < store.state.preOrderCartState.length; i++) {
          var totalPrice = (store.state.preOrderCartState[i]['details']
                  ['sellingPrice'] *
              store.state.preOrderCartState[i]['quantity']);
          sum = totalPrice.toInt();
        }
      });
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false)); //false chilo
    });
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

  _showMsg(msg, numb) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: numb == 1 ? Colors.red[500] : Colors.green[400],
        textColor: Colors.white,
        fontSize: 13.0);
  }
}


//bottomNavigationBar: CheckoutCard(),
///total
///  store.state.subTotalState != null && store.state.subTotalState >= 3000 ? "\৳${(0 + store.state.subTotalState ).toString()}" : store.state.userDataState['customer']['zone'] == "Sylhet"  ?
///  "\৳${( 50 + store.state.subTotalState ).toString()}" :  "\৳${( 100 + store.state.subTotalState ).toString()}" ,