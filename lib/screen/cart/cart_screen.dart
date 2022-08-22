import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/home_screen/home_screen.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import '../../main.dart';
import '../../size_config.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<dynamic> zoneListByCity = [];
  List<dynamic> areaListByZone = [];
  void initState() {
    getCredentials();
    store.state.cartDataLogoutState.isNotEmpty ? cartPostLogout() : _getCart();
    _getAllDistrictApiData();
    _getAllZoneApiData();
    _getAllAreaApiData();
    super.initState();
  }

  getCredentials() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      store.state.userDataState =
          json.decode(localStorage.getString('userData')!);
    });
    cityId = store.state.userDataState['customer']['cityId'];
    zoneId = store.state.userDataState['customer']['zoneId'];
    areaId = store.state.userDataState['customer']['areaId'];
  }

  Future<void> _getAllDistrictApiData() async {
    var resAllFilterDistrict =
        await CallApi().withoutTokengetData('/app/cities');
    if (resAllFilterDistrict.statusCode == 200) {
      var body = json.decode(resAllFilterDistrict.body);
      store.dispatch(DistrictAction(body['cities']));
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

  Future<void> cartPostLogout() async {
    var cartIndex;
    List.generate(
        store.state.cartDataLogoutState.length, (index) => cartIndex = index);
    var cartData = {
      'admin_id': store.state.cartDataLogoutState[cartIndex]['admin_id'],
      'averageBuyingPrice': store.state.cartDataLogoutState[cartIndex]
          ['averageBuyingPrice'],
      'barCode': store.state.cartDataLogoutState[cartIndex]['barCode'],
      'brand': store.state.cartDataLogoutState[cartIndex]['brand'],
      'brandId': store.state.cartDataLogoutState[cartIndex]['brandId'],
      'catName': store.state.cartDataLogoutState[cartIndex]['catName'],
      'categoryId': store.state.cartDataLogoutState[cartIndex]['categoryId'],
      'color': store.state.cartDataLogoutState[cartIndex]['color'],
      'created_at': store.state.cartDataLogoutState[cartIndex]['created_at'],
      'date': store.state.cartDataLogoutState[cartIndex]['date'],
      'discount': store.state.cartDataLogoutState[cartIndex]['discount'],
      'groupId': store.state.cartDataLogoutState[cartIndex]['groupId'],
      'groupName': store.state.cartDataLogoutState[cartIndex]['groupName'],
      'id': store.state.cartDataLogoutState[cartIndex]['id'],
      'img': store.state.cartDataLogoutState[cartIndex]['img'],
      'model': store.state.cartDataLogoutState[cartIndex]['model'],
      'mproductId': store.state.cartDataLogoutState[cartIndex]['mproductId'],
      'openingQuantity': store.state.cartDataLogoutState[cartIndex]
          ['openingQuantity'],
      'openingUnitPrice': store.state.cartDataLogoutState[cartIndex]
          ['openingUnitPrice'],
      'productImage': store.state.cartDataLogoutState[cartIndex]
          ['productImage'],
      'productName': store.state.cartDataLogoutState[cartIndex]['productName'],
      'quantity': store.state.cartDataLogoutState[cartIndex]['quantity'],
      'sellingPrice': store.state.cartDataLogoutState[cartIndex]
          ['sellingPrice'],
      'size': store.state.cartDataLogoutState[cartIndex]['size'],
      'stock': store.state.cartDataLogoutState[cartIndex]['stock'],
      'unit': store.state.cartDataLogoutState[cartIndex]['unit'],
      'updated_at': store.state.cartDataLogoutState[cartIndex]['updated_at'],
    };
    print("--------------$cartData----------");

    var cartRes = await CallApi().postData(cartData, '/app/cart');
    var cartBody = json.decode(cartRes.body);
    print('CartPostbody ------------- $cartBody');
    print('res.statusCode  - ${cartRes.statusCode}');
    if (cartRes.statusCode == 200 && cartBody['success'] == true) {
      setState(() async {
        var resAllCart = await CallApi().getData('/app/cart');
        print(resAllCart);
        if (resAllCart.statusCode == 200) {
          var body = json.decode(resAllCart.body);
          print('body -=-=-=-=--=-=-=-=-= $body');
          setState(() {
            store.dispatch(CartGetAction(body['allCarts']));
            for (int i = 0; i < store.state.cartGetState.length; i++) {
              var totalPrice = store.state.cartGetState[i]['mproduct']
                          ['appDiscount'] >
                      0
                  ? (store.state.cartGetState[i]['details']['sellingPrice'] -
                              (store.state.cartGetState[i]['details']
                                          ['sellingPrice'] *
                                      store.state.cartGetState[i]['mproduct']
                                          ['appDiscount']) /
                                  100)
                          .toInt() *
                      store.state.cartGetState[i]['quantity']
                  : (store.state.cartGetState[i]['details']['sellingPrice'] *
                      store.state.cartGetState[i]['quantity']);
              sum = (sum + totalPrice).toInt();
              store.dispatch(SubTotalAction(sum));
            }
            List.generate(
                store.state.cartGetState.length,
                (index) => stock =
                    store.state.cartGetState[index]['details']['stock']);
          });

          print("sum = $sum");
          print(store.state.subTotalState);
          print(store.state.cartGetState);
          print("--------$stock"
              "------------");
          print(store.state.cartGetState.length);
        } else {
          print("hello");
        }
        setState(() {
          store.dispatch(IsLoadingAction(false)); //false chilo
        });
      });
    } else {
      _showMsg(cartBody['message'], 1);
    }
  }

  Future<void> _getCart() async {
    //var data = store.state.cartDataState;
    var resAllCart = await CallApi().getData('/app/cart');
    print(resAllCart);
    if (resAllCart.statusCode == 200) {
      var body = json.decode(resAllCart.body);
      print('body -=-=-=-=--=-=-=-=-= $body');
      setState(() {
        store.dispatch(CartGetAction(body['allCarts']));
        for (int i = 0; i < store.state.cartGetState.length; i++) {
          var totalPrice =
              store.state.cartGetState[i]['mproduct']['appDiscount'] > 0
                  ? (store.state.cartGetState[i]['details']['sellingPrice'] -
                              (store.state.cartGetState[i]['details']
                                          ['sellingPrice'] *
                                      store.state.cartGetState[i]['mproduct']
                                          ['appDiscount']) /
                                  100)
                          .toInt() *
                      store.state.cartGetState[i]['quantity']
                  : (store.state.cartGetState[i]['details']['sellingPrice'] *
                      store.state.cartGetState[i]['quantity']);
          sum = (sum + totalPrice).toInt();
          store.dispatch(SubTotalAction(sum));
        }
        List.generate(
            store.state.cartGetState.length,
            (index) =>
                stock = store.state.cartGetState[index]['details']['stock']);
      });

      print("sum = $sum");
      print(store.state.subTotalState);
      print(store.state.cartGetState);
      print("--------$stock"
          "------------");
      print(store.state.cartGetState.length);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false)); //false chilo
    });
  }

  int sum = 0;
  int sumUpdate = 0;
  int newcartSum = 0;
  var stock;
  TextEditingController promoCode = TextEditingController();
  TextEditingController referralCode = TextEditingController();
  TextEditingController giftVoucherCode = TextEditingController();
  var grandTotal;
  List cartList = store.state.cartGetState;
  var roundingAmount;
  var grandTotalValue;
  var discountAmount;

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
        store.state.cartDataLogoutState = [];
        print(store.state.cartDataState);
        store.state.logoutUserData = null;
        store.state.promoCodeState = null;
        store.state.referralCodeState = null;
        store.state.giftVoucherState = null;
        store.state.logoutUserData = null;
        store.state.cartDataLogoutState = [];
        store.state.cartGetState = [];
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
            "Shopping Cart",
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
                store.state.promoCodeState = null;
                store.state.referralCodeState = null;
                store.state.giftVoucherState = null;
                store.state.logoutUserData = null;
                store.state.cartDataLogoutState = [];
                store.state.cartGetState = [];
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeScreen()),
                  ModalRoute.withName('/'),
                );
              }),
          centerTitle: true,
        ),
        body: store.state.cartGetState.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: store.state.cartGetState.length,
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
                                              store.state.cartGetState[index]
                                                  ['details']['img'],
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
                                                "${store.state.cartGetState[index]['details']['productName']} ",
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
                                                    "${store.state.cartGetState[index]['details']['model']} ",
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
                                              store.state.cartGetState[index]
                                                              ['details']
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
                                                          "${store.state.cartGetState[index]['details']['color']} ",
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
                                              store.state.cartGetState[index]
                                                          ['details']['size'] ==
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
                                                                  .cartGetState[
                                                              index]['details']
                                                          ['size'],
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
                                      (store.state.cartGetState[index]
                                                  ['mproduct']['appDiscount'] >
                                              0)
                                          ? Text.rich(
                                              TextSpan(
                                                text:
                                                    "\৳${(store.state.cartGetState[index]['details']['sellingPrice'] - (store.state.cartGetState[index]['details']['sellingPrice'] * store.state.cartGetState[index]['mproduct']['appDiscount']) / 100).toInt()}",
                                                style: KTextStyle.bodyText4
                                                    .copyWith(
                                                  color: Colors.redAccent,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        " x${store.state.cartGetState[index]['quantity']}",
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
                                                    "\৳${store.state.cartGetState[index]['details']['sellingPrice'].toInt()}",
                                                style: KTextStyle.bodyText4
                                                    .copyWith(
                                                  color: Colors.redAccent,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        " x${store.state.cartGetState[index]['quantity']}",
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
                                                  if (store.state.cartGetState[
                                                          index]['quantity'] >
                                                      1) {
                                                    setState(() {
                                                      --store.state
                                                              .cartGetState[
                                                          index]['quantity'];
                                                      getUpdateQty();
                                                      minusSubTotal();
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.5,
                                                          color: Colors.grey)),
                                                  width: 26,
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    FontAwesomeIcons.minus,
                                                    size: 9,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: Colors.grey),
                                                  color: Colors.white,
                                                ),
                                                alignment: Alignment.center,
                                                width: 37,
                                                child: Text(
                                                  store
                                                      .state
                                                      .cartGetState[index]
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
                                                        store.state.cartGetState[
                                                                index]
                                                            ['quantity']) {
                                                      store.state.cartGetState[
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
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 0.5,
                                                        color: Colors.grey),
                                                  ),
                                                  alignment: Alignment.center,
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
                                              //cartList.remove(store.state.cartGetState[index]['id']);
                                              deleteFromCart();
                                            });
                                          }),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      (store.state.cartGetState[index]
                                                  ['mproduct']['appDiscount'] >
                                              0)
                                          ? Text(
                                              "\৳${(store.state.cartGetState[index]['details']['sellingPrice'] - (store.state.cartGetState[index]['details']['sellingPrice'] * store.state.cartGetState[index]['mproduct']['appDiscount']) / 100).toInt() * store.state.cartGetState[index]['quantity']}",
                                              style:
                                                  KTextStyle.bodyText4.copyWith(
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          : Text(
                                              "\৳${store.state.cartGetState[index]['details']['sellingPrice'] * store.state.cartGetState[index]['quantity']}",
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
                            if (store.state.referralCodeState == null)
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 2.1 * SizeConfig.imageSizeMultiplier,
                                    right:
                                        2.1 * SizeConfig.imageSizeMultiplier),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Promo Code",
                                      style: KTextStyle.subtitle3.copyWith(
                                        color:
                                            store.state.darkModeState == null ||
                                                    store.state.darkModeState ==
                                                        false
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
                                          width: 46 *
                                              SizeConfig.imageSizeMultiplier,
                                          decoration: BoxDecoration(
                                            color: store.state.darkModeState ==
                                                        null ||
                                                    store.state.darkModeState ==
                                                        false
                                                ? store.state.promoCodeState ==
                                                        null
                                                    ? kSecondaryColor
                                                        .withOpacity(0.1)
                                                    : Colors.grey[400]
                                                : Colors.grey[900],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: TextFormField(
                                            style:
                                                KTextStyle.bodyText4.copyWith(
                                              color: store.state
                                                              .darkModeState ==
                                                          null ||
                                                      store.state
                                                              .darkModeState ==
                                                          false
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            controller: promoCode,
                                            readOnly:
                                                store.state.promoCodeState !=
                                                        null
                                                    ? true
                                                    : false,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 2.1 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                  vertical: 3.1 *
                                                      SizeConfig
                                                          .imageSizeMultiplier),
                                              border: InputBorder.none,
                                              hintText: "Promo Code",
                                              hintStyle:
                                                  KTextStyle.bodyText4.copyWith(
                                                color: store.state
                                                                .darkModeState ==
                                                            null ||
                                                        store.state
                                                                .darkModeState ==
                                                            false
                                                    ? Colors.grey
                                                    : Colors.grey[400],
                                              ),
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4 *
                                              SizeConfig.imageSizeMultiplier,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              store.state.promoCodeState == null
                                                  ? promoCodeApply()
                                                  : clear();
                                            });
                                          },
                                          child: Container(
                                            width: 45.7 *
                                                SizeConfig.imageSizeMultiplier,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.1 *
                                                        SizeConfig
                                                            .imageSizeMultiplier,
                                                    vertical: 3.6 *
                                                        SizeConfig
                                                            .imageSizeMultiplier),
                                                child: store.state
                                                            .promoCodeState ==
                                                        null
                                                    ? Text("Apply Code",
                                                        style: KTextStyle
                                                            .buttonText4
                                                            .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center)
                                                    : Text("Clear",
                                                        style: KTextStyle
                                                            .buttonText4
                                                            .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 1.8 * SizeConfig.imageSizeMultiplier,
                            ),
                            if (store.state.promoCodeState == null &&
                                store.state.userDataState['customer']
                                        ['barcode'] ==
                                    0)
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 2.1 * SizeConfig.imageSizeMultiplier,
                                    right:
                                        2.1 * SizeConfig.imageSizeMultiplier),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Refferal Code",
                                      style: GoogleFonts.montserrat(
                                          color: store.state.darkModeState ==
                                                      null ||
                                                  store.state.darkModeState ==
                                                      false
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 3 *
                                              SizeConfig.imageSizeMultiplier),
                                    ),
                                    SizedBox(
                                      height:
                                          1.6 * SizeConfig.imageSizeMultiplier,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 46 *
                                              SizeConfig.imageSizeMultiplier,
                                          decoration: BoxDecoration(
                                            color: store.state.darkModeState ==
                                                        null ||
                                                    store.state.darkModeState ==
                                                        false
                                                ? store.state.promoCodeState ==
                                                        null
                                                    ? kSecondaryColor
                                                        .withOpacity(0.1)
                                                    : Colors.grey[400]
                                                : Colors.grey[900],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: TextFormField(
                                            style: TextStyle(
                                                color: store.state
                                                                .darkModeState ==
                                                            null ||
                                                        store.state
                                                                .darkModeState ==
                                                            false
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 3 *
                                                    SizeConfig
                                                        .imageSizeMultiplier),
                                            controller: referralCode,
                                            readOnly:
                                                store.state.referralCodeState !=
                                                        null
                                                    ? true
                                                    : false,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 2.1 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                  vertical: 3.1 *
                                                      SizeConfig
                                                          .imageSizeMultiplier),
                                              border: InputBorder.none,
                                              hintText: "Refferal Code",
                                              hintStyle: GoogleFonts.montserrat(
                                                color: store.state
                                                                .darkModeState ==
                                                            null ||
                                                        store.state
                                                                .darkModeState ==
                                                            false
                                                    ? Colors.grey
                                                    : Colors.grey[400],
                                                fontSize: 3 *
                                                    SizeConfig
                                                        .imageSizeMultiplier,
                                              ),
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4 *
                                              SizeConfig.imageSizeMultiplier,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              store.state.referralCodeState ==
                                                      null
                                                  ? referralCodeApply()
                                                  : clear();
                                            });
                                          },
                                          child: Container(
                                            width: 45.7 *
                                                SizeConfig.imageSizeMultiplier,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.1 *
                                                        SizeConfig
                                                            .imageSizeMultiplier,
                                                    vertical: 3.6 *
                                                        SizeConfig
                                                            .imageSizeMultiplier),
                                                child: store.state
                                                            .referralCodeState ==
                                                        null
                                                    ? Text("Apply Code",
                                                        style: KTextStyle
                                                            .buttonText4
                                                            .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center)
                                                    : Text("Clear",
                                                        style: KTextStyle
                                                            .buttonText4
                                                            .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 1.8 * SizeConfig.imageSizeMultiplier,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 2.1 * SizeConfig.imageSizeMultiplier,
                                  right: 2.1 * SizeConfig.imageSizeMultiplier),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gift Voucher",
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
                                        width: 45.7 *
                                            SizeConfig.imageSizeMultiplier,
                                        decoration: BoxDecoration(
                                          color: store.state.darkModeState ==
                                                      null ||
                                                  store.state.darkModeState ==
                                                      false
                                              ? store.state.promoCodeState ==
                                                      null
                                                  ? kSecondaryColor
                                                      .withOpacity(0.1)
                                                  : Colors.grey[400]
                                              : Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextFormField(
                                          style: KTextStyle.bodyText4.copyWith(
                                            color: store.state.darkModeState ==
                                                        null ||
                                                    store.state.darkModeState ==
                                                        false
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          controller: giftVoucherCode,
                                          readOnly:
                                              store.state.giftVoucherState !=
                                                      null
                                                  ? true
                                                  : false,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 2.1 *
                                                    SizeConfig
                                                        .imageSizeMultiplier,
                                                vertical: 3.1 *
                                                    SizeConfig
                                                        .imageSizeMultiplier),
                                            border: InputBorder.none,
                                            hintText: "Gift Voucher",
                                            hintStyle:
                                                KTextStyle.bodyText4.copyWith(
                                              color: store.state
                                                              .darkModeState ==
                                                          null ||
                                                      store.state
                                                              .darkModeState ==
                                                          false
                                                  ? Colors.grey
                                                  : Colors.grey[400],
                                            ),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            4 * SizeConfig.imageSizeMultiplier,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            store.state.giftVoucherState == null
                                                ? giftVoucherApply()
                                                : voucherClear();
                                          });
                                        },
                                        child: Container(
                                          width: 46 *
                                              SizeConfig.imageSizeMultiplier,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.1 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                  vertical: 3.6 *
                                                      SizeConfig
                                                          .imageSizeMultiplier),
                                              child: store.state
                                                          .giftVoucherState ==
                                                      null
                                                  ? Text("Apply Code",
                                                      style: KTextStyle
                                                          .buttonText4
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center)
                                                  : Text("Clear",
                                                      style: KTextStyle
                                                          .buttonText4
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
                        height: 55 * SizeConfig.imageSizeMultiplier,
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
                                            store.state.subTotalState != null
                                                ? "${store.state.subTotalState}"
                                                : "${store.state.subTotalState = 0}",
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
                                      if (store.state.promoCodeState != null)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Promo Code Discount(${store.state.promoCodeState['discount'].toString()}\%)",
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
                                              "${((store.state.subTotalState * store.state.promoCodeState['discount']) / 100).ceil()}",
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
                                            )
                                          ],
                                        ),
                                      if (store.state.userDataState['customer']
                                                  ['barcode'] !=
                                              null &&
                                          store.state.promoCodeState == null)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Membership Discount(10%)",
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
                                              "${((store.state.subTotalState * 10) / 100).ceil()}",
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
                                            )
                                          ],
                                        ),
                                      if (store.state.referralCodeState != null)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Referral Discount(5%)",
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
                                                "${((store.state.subTotalState * 5) / 100).ceil()}",
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
                                                ))
                                          ],
                                        ),
                                      if (store.state.giftVoucherState != null)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Gift Voucher(${giftVoucherCode.text})",
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
                                              "${store.state.giftVoucherState['amount']}",
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
                                            )
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
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Grand Total",
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
                                          store.state.giftVoucherState != null
                                              ? Text(
                                                  grandTotal = store.state
                                                              .promoCodeState !=
                                                          null
                                                      ? "${((store.state.subTotalState - (store.state.subTotalState * store.state.promoCodeState['discount']) / 100) - store.state.giftVoucherState['amount']).toInt()}"
                                                      : store.state
                                                                  .referralCodeState !=
                                                              null
                                                          ? "${((store.state.subTotalState - (store.state.subTotalState * 5) / 100) - store.state.giftVoucherState['amount']).toInt()}"
                                                          : store.state.userDataState[
                                                                          'customer']
                                                                      [
                                                                      'barcode'] !=
                                                                  null
                                                              ? "${((store.state.subTotalState - (store.state.subTotalState * 10) / 100) - store.state.giftVoucherState['amount']).toInt()}"
                                                              : "${store.state.subTotalState - store.state.giftVoucherState['amount']}",
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
                                                  grandTotal = store.state
                                                              .promoCodeState !=
                                                          null
                                                      ? "${(store.state.subTotalState - (store.state.subTotalState * store.state.promoCodeState['discount']) / 100).toInt()}"
                                                      : store.state
                                                                  .referralCodeState !=
                                                              null
                                                          ? "${(store.state.subTotalState - (store.state.subTotalState * 5) / 100).toInt()}"
                                                          : store.state.userDataState[
                                                                          'customer']
                                                                      [
                                                                      'barcode'] !=
                                                                  null
                                                              ? "${(store.state.subTotalState - (store.state.subTotalState * 10) / 100).toInt()}"
                                                              : "${store.state.subTotalState}",
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
                                        ],
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
                                            "Rounding(+-)",
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
                                            roundingAmount =
                                                (int.parse(grandTotal) % 10)
                                                    .toString(),
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
                                          )
                                        ],
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
                                        store.state.subTotalState != null &&
                                                store.state.subTotalState >=
                                                    3000
                                            ? "\৳${(0 + (int.parse(grandTotal) - int.parse(roundingAmount))).toString()}"
                                            : "\৳${(shippingCost + (int.parse(grandTotal) - int.parse(roundingAmount))).toString()}",
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
                        "Your Shopping Bag is Empty!",
                        style: KTextStyle.subtitle2.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.grey
                              : Colors.grey[700],
                        ),
                      )
                    ]),
              ),
        bottomNavigationBar: store.state.cartGetState.isEmpty
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
                                    builder: (context) => CheckOut()));
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
  Future<void> promoCodeApply() async {
    var data = {
      'code': promoCode.text,
    };
    print("-------$data--------");
    var res = await CallApi().postData(data, '/app/checkCoupon');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 202 && body['success'] == true) {
      setState(() {
        store.dispatch(PromoCodeAction(body['Coupon']));
      });
    } else {
      if (promoCode.text.isEmpty) {
        _showMsg("Promo Code is empty !", 2);
      } else {
        _showMsg(body['message'], 2);
      }
    }
    print(store.state.promoCodeState);
  }

  Future<void> referralCodeApply() async {
    var data = {
      'barCode': referralCode.text,
    };
    print("-------$data--------");
    var res = await CallApi().postData(data, '/app/checkReferralCode');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 202 && body['success'] == true) {
      setState(() {
        store.dispatch(ReferralCodeAction(body['Coupon']));
      });
    } else {
      if (referralCode.text.isEmpty) {
        _showMsg("Refferral Code is empty !", 2);
      } else {
        _showMsg(body['message'], 2);
      }
    }
    print(store.state.referralCodeState);
  }

  Future<void> giftVoucherApply() async {
    var data = {
      'code': giftVoucherCode.text,
    };
    print("-------$data--------");
    var res = await CallApi().postData(data, '/app/checkGiftVoucherCode');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 202 && body['success'] == true) {
      setState(() {
        store.dispatch(GiftVoucherAction(body['Coupon']));
      });
    } else {
      if (giftVoucherCode.text.isEmpty) {
        _showMsg("Gift Voucher Code is empty !", 2);
      } else {
        _showMsg(body['message'], 2);
      }
    }
    print(store.state.giftVoucherState);
  }

  clear() {
    setState(() {
      store.state.promoCodeState = null;
      store.state.referralCodeState = null;
      promoCode.clear();
      referralCode.clear();
    });
  }

  voucherClear() {
    setState(() {
      store.state.giftVoucherState = null;
      giftVoucherCode.clear();
    });
  }

  grandTotalValueGiftVoucher() {
    var reminder = (int.parse(grandTotal) % 10).toString();
    roundingAmount = reminder;
    // grandTotalValue = grandTotal - reminder;
  }

  grandTotalValuePromoCode() {
    var reminder = (int.parse(grandTotal) % 10).toString();
    roundingAmount = reminder;
    // grandTotalValue = grandTotal - reminder;
  }

  Future<void> getUpdateQty() async {
    var cartIndex;
    setState(() {
      List.generate(
          store.state.cartGetState.length,
          (index) => store.state.cartGetState[index]['quantity'] =
              store.state.cartGetState[index]['quantity']);
      List.generate(
          store.state.cartGetState.length, (index) => cartIndex = index);
      //
    });

    var data = {
      'categoryId': store.state.cartGetState[cartIndex]['categoryId'],
      'created_at': store.state.cartGetState[cartIndex]['created_at'],
      'details': {
        'admin_id': store.state.cartGetState[cartIndex]['details']['admin_id'],
        'averageBuyingPrice': store.state.cartGetState[cartIndex]['details']
            ['averageBuyingPrice'],
        'barCode': store.state.cartGetState[cartIndex]['details']['barCode'],
        'brand': store.state.cartGetState[cartIndex]['details']['brand'],
        'brandId': store.state.cartGetState[cartIndex]['details']['brandId'],
        'catName': store.state.cartGetState[cartIndex]['details']['catName'],
        'categoryId': store.state.cartGetState[cartIndex]['details']
            ['categoryId'],
        'color': store.state.cartGetState[cartIndex]['details']['color'],
        'created_at': store.state.cartGetState[cartIndex]['details']
            ['created_at'],
        'date': store.state.cartGetState[cartIndex]['details']['date'],
        'discount': store.state.cartGetState[cartIndex]['details']['discount'],
        'groupId': store.state.cartGetState[cartIndex]['details']['groupId'],
        'groupName': store.state.cartGetState[cartIndex]['details']
            ['groupName'],
        'id': store.state.cartGetState[cartIndex]['details']['id'],
        'img': store.state.cartGetState[cartIndex]['details']['img'],
        'model': store.state.cartGetState[cartIndex]['details']['model'],
        'mproductId': store.state.cartGetState[cartIndex]['details']
            ['mproductId'],
        'openingQuantity': store.state.cartGetState[cartIndex]['details']
            ['openingQuantity'],
        'openingUnitPrice': store.state.cartGetState[cartIndex]['details']
            ['openingUnitPrice'],
        'productImage': store.state.cartGetState[cartIndex]['details']
            ['productImage'],
        'productName': store.state.cartGetState[cartIndex]['details']
            ['productName'],
        'quantity': store.state.cartGetState[cartIndex]['details']['quantity'],
        'sellingPrice': store.state.cartGetState[cartIndex]['details']
            ['sellingPrice'],
        'size': store.state.cartGetState[cartIndex]['details']['size'],
        'stock': store.state.cartGetState[cartIndex]['details']['stock'],
        'unit': store.state.cartGetState[cartIndex]['details']['unit'],
        'updated_at': store.state.cartGetState[cartIndex]['details']
            ['updated_at'],
      },
      'id': store.state.cartGetState[cartIndex]['id'],
      'mproduct': {
        'adminDiscount': store.state.cartGetState[cartIndex]['mproduct']
            ['adminDiscount'],
        'admin_id': store.state.cartGetState[cartIndex]['mproduct']['admin_id'],
        'appDiscount': store.state.cartGetState[cartIndex]['mproduct']
            ['appDiscount'],
        'averageBuyingPrice': store.state.cartGetState[cartIndex]['mproduct']
            ['averageBuyingPrice'],
        'brandId': store.state.cartGetState[cartIndex]['mproduct']['brandId'],
        'categoryId': store.state.cartGetState[cartIndex]['mproduct']
            ['categoryId'],
        'created_at': store.state.cartGetState[cartIndex]['mproduct']
            ['created_at'],
        'description': store.state.cartGetState[cartIndex]['mproduct']
            ['description'],
        'discount': store.state.cartGetState[cartIndex]['mproduct']['discount'],
        'groupId': store.state.cartGetState[cartIndex]['mproduct']['groupId'],
        'id': store.state.cartGetState[cartIndex]['mproduct']['id'],
        'isAvailable': store.state.cartGetState[cartIndex]['mproduct']
            ['isAvailable'],
        'isFeatured': store.state.cartGetState[cartIndex]['mproduct']
            ['isFeatured'],
        'isNew': store.state.cartGetState[cartIndex]['mproduct']['isNew'],
        'model': store.state.cartGetState[cartIndex]['mproduct']['model'],
        'openingQuantity': store.state.cartGetState[cartIndex]['mproduct']
            ['openingQuantity'],
        'openingUnitPrice': store.state.cartGetState[cartIndex]['mproduct']
            ['openingUnitPrice'],
        'productImage': store.state.cartGetState[cartIndex]['mproduct']
            ['productImage'],
        'productName': store.state.cartGetState[cartIndex]['mproduct']
            ['productName'],
        'sellingPrice': store.state.cartGetState[cartIndex]['mproduct']
            ['sellingPrice'],
        'stock': store.state.cartGetState[cartIndex]['mproduct']['stock'],
        'totalSale': store.state.cartGetState[cartIndex]['mproduct']
            ['totalSale'],
        'updated_at': store.state.cartGetState[cartIndex]['mproduct']
            ['updated_at'],
      },
      'mproductId': store.state.cartGetState[cartIndex]['mproductId'],
      'product': store.state.cartGetState[cartIndex]['product'],
      'productId': store.state.cartGetState[cartIndex]['productId'],
      'quantity': store.state.cartGetState[cartIndex]['quantity'],
      'subcategoryId': store.state.cartGetState[cartIndex]['subcategoryId'],
      'updated_at': store.state.cartGetState[cartIndex]['updated_at'],
      'userId': store.state.cartGetState[cartIndex]['userId'],
      'vproduct': {
        'admin_id': store.state.cartGetState[cartIndex]['vproduct']['admin_id'],
        'averageBuyingPrice': store.state.cartGetState[cartIndex]['vproduct']
            ['averageBuyingPrice'],
        'barCode': store.state.cartGetState[cartIndex]['vproduct']['barCode'],
        'brand': store.state.cartGetState[cartIndex]['vproduct']['brand'],
        'brandId': store.state.cartGetState[cartIndex]['vproduct']['brandId'],
        'catName': store.state.cartGetState[cartIndex]['vproduct']['catName'],
        'categoryId': store.state.cartGetState[cartIndex]['vproduct']
            ['categoryId'],
        'color': store.state.cartGetState[cartIndex]['vproduct']['color'],
        'created_at': store.state.cartGetState[cartIndex]['vproduct']
            ['created_at'],
        'date': store.state.cartGetState[cartIndex]['vproduct']['date'],
        'groupId': store.state.cartGetState[cartIndex]['vproduct']['groupId'],
        'groupName': store.state.cartGetState[cartIndex]['vproduct']
            ['groupName'],
        'id': store.state.cartGetState[cartIndex]['vproduct']['id'],
        'model': store.state.cartGetState[cartIndex]['vproduct']['model'],
        'mproductId': store.state.cartGetState[cartIndex]['vproduct']
            ['mproductId'],
        'openingQuantity': store.state.cartGetState[cartIndex]['vproduct']
            ['openingQuantity'],
        'openingUnitPrice': store.state.cartGetState[cartIndex]['vproduct']
            ['openingUnitPrice'],
        'productImage': store.state.cartGetState[cartIndex]['vproduct']
            ['productImage'],
        'productName': store.state.cartGetState[cartIndex]['vproduct']
            ['productName'],
        'sellingPrice': store.state.cartGetState[cartIndex]['vproduct']
            ['sellingPrice'],
        'size': store.state.cartGetState[cartIndex]['vproduct']['v'],
        'stock': store.state.cartGetState[cartIndex]['vproduct']['stock'],
        'unit': store.state.cartGetState[cartIndex]['vproduct']['unit'],
        'updated_at': store.state.cartGetState[cartIndex]['vproduct']
            ['updated_at'],
      }
    };
    var res = await CallApi().postData(data, '/app/cart_update');
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
    for (int i = 0; i < store.state.cartGetState.length; i++) {
      var totalPrice = store.state.cartGetState[i]['mproduct']['appDiscount'] >
              0
          ? (store.state.cartGetState[i]['details']['sellingPrice'] -
                      (store.state.cartGetState[i]['details']['sellingPrice'] *
                              store.state.cartGetState[i]['mproduct']
                                  ['appDiscount']) /
                          100)
                  .toInt() *
              store.state.cartGetState[i]['quantity']
          : (store.state.cartGetState[i]['details']['sellingPrice'] *
              store.state.cartGetState[i]['quantity']);
      sumUpdate = (sumUpdate + totalPrice).toInt();
    }
    setState(() {
      store.state.subTotalState = sumUpdate;
      sumUpdate = 0;
    });
  }

  minusSubTotal() {
    for (int i = 0; i < store.state.cartGetState.length; i++) {
      var totalPrice = store.state.cartGetState[i]['mproduct']['appDiscount'] >
              0
          ? (store.state.cartGetState[i]['details']['sellingPrice'] -
                      (store.state.cartGetState[i]['details']['sellingPrice'] *
                              store.state.cartGetState[i]['mproduct']
                                  ['appDiscount']) /
                          100)
                  .toInt() *
              store.state.cartGetState[i]['quantity']
          : (store.state.cartGetState[i]['details']['sellingPrice'] *
              store.state.cartGetState[i]['quantity']);
      sumUpdate = (sumUpdate + totalPrice).toInt();
    }
    setState(() {
      store.state.subTotalState = sumUpdate;
      sumUpdate = 0;
    });
  }

  deleteFromCart() async {
    var idIndex;
    List.generate(store.state.cartGetState.length, (index) => idIndex = index);
    var data;
    data = {
      'id': store.state.cartGetState[idIndex]['id'],
    };
    print("CartgetState delete _ ${store.state.cartGetState[idIndex]['id']}");
    var res = await CallApi().postData(data, '/app/cart_delete');
    var body = json.decode(res.body);
    print('CartUpdate body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Delete from Cart", 1);
    } else {
      _showMsg("Please login to add WishList ! ", 1);
    }

    setState(() {
      store.dispatch(SubTotalAction(newcartSum));
    });
    var resAllCart = await CallApi().getData('/app/cart');
    print(resAllCart);
    if (resAllCart.statusCode == 200) {
      sum = 0;
      var body = json.decode(resAllCart.body);
      print('body -=-=-=-=--=-=-=-=-= $body');
      setState(() {
        store.dispatch(CartGetAction(body['allCarts']));
        for (int i = 0; i < store.state.cartGetState.length; i++) {
          var totalPrice =
              store.state.cartGetState[i]['mproduct']['appDiscount'] > 0
                  ? (store.state.cartGetState[i]['details']['sellingPrice'] -
                              (store.state.cartGetState[i]['details']
                                          ['sellingPrice'] *
                                      store.state.cartGetState[i]['mproduct']
                                          ['appDiscount']) /
                                  100)
                          .toInt() *
                      store.state.cartGetState[i]['quantity']
                  : (store.state.cartGetState[i]['details']['sellingPrice'] *
                      store.state.cartGetState[i]['quantity']);
          sum = (sum + totalPrice).toInt();
          store.dispatch(SubTotalAction(sum));
        }
      });

      print("sum = $sum");
      print(store.state.subTotalState);
      print(store.state.cartGetState);
      print("--------$stock"
          "------------");
      print(store.state.cartGetState.length);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false)); //false chilo
    });

    print(newcartSum);
    print(store.state.subTotalState);
    print(store.state.cartGetState.length);
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