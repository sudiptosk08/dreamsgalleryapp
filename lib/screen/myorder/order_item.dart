import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/screen/cart/action_button.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant.dart';
import '../../k_text_style.dart';
import '../../main.dart';

class OrderCard extends StatefulWidget {
  final index;
  final orderId;
  final name;
  final phone;
  final date;
  final paymentMethod;
  final payment;
  final amount;
  final status;
  final orderType;

  OrderCard(
      {Key? key,
      @required this.index,
      @required this.orderId,
      @required this.name,
      @required this.phone,
      @required this.date,
      @required this.payment,
      @required this.amount,
      @required this.paymentMethod,
      @required this.status,
      @required this.orderType})
      : super(key: key);
  @override
  _OrderCardState createState() => _OrderCardState(index, orderId, name, phone,
      date, payment, amount, paymentMethod, status, orderType);
}

class _OrderCardState extends State<OrderCard> {
  var orderId;
  var index;
  var name;
  var phone;
  var date;
  var paymentMethod;
  var payment;
  var amount;
  var status;
  var orderTYpe;

  _OrderCardState(
      this.index,
      this.orderId,
      this.name,
      this.phone,
      this.date,
      this.payment,
      this.amount,
      this.paymentMethod,
      this.status,
      this.orderTYpe);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? kSecondaryColor.withOpacity(0.1)
            : Colors.grey[900],
      ),
      padding: EdgeInsets.all(0.5 * SizeConfig.imageSizeMultiplier),
      height: 40 * SizeConfig.imageSizeMultiplier,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 2.5 * SizeConfig.imageSizeMultiplier,
          ),
          Container(
            width: 55 * SizeConfig.imageSizeMultiplier,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.6 * SizeConfig.imageSizeMultiplier,
                ),
                Text.rich(
                  TextSpan(
                      text: "PX",
                      style: KTextStyle.bodyText3.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                      children: [
                        TextSpan(
                          text: orderId.toString(),
                          style: KTextStyle.bodyText3.copyWith(
                            color: store.state.darkModeState == false ||
                                    store.state.darkModeState == null
                                ? Colors.black
                                : Colors.grey[400],
                          ),
                        )
                      ]),
                ),
                SizedBox(height: 1.3 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.all(0.2 * SizeConfig.imageSizeMultiplier),
                  child: Text(
                    name,
                    style: KTextStyle.bodyText4.copyWith(
                      color: store.state.darkModeState == false ||
                              store.state.darkModeState == null
                          ? Colors.black
                          : Colors.grey[400],
                    ),
                  ),
                ),
                SizedBox(height: 1.3 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.all(0.2 * SizeConfig.imageSizeMultiplier),
                  child: Text(
                    phone,
                    style: KTextStyle.bodyText4.copyWith(
                      color: store.state.darkModeState == false ||
                              store.state.darkModeState == null
                          ? Colors.black
                          : Colors.grey[400],
                    ),
                  ),
                ),
                SizedBox(height: 1.3 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.all(0.2 * SizeConfig.imageSizeMultiplier),
                  child: Text.rich(
                    TextSpan(
                      text: "Order Date : ",
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                      children: [
                        TextSpan(
                          text: date,
                          style: KTextStyle.bodyText4.copyWith(
                            color: store.state.darkModeState == false ||
                                    store.state.darkModeState == null
                                ? Colors.black
                                : Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 2.5 * SizeConfig.imageSizeMultiplier),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 30 * SizeConfig.imageSizeMultiplier,
                      height: 7 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                          paymentMethod == "sslcommerz"
                              ? "Payment Gateway"
                              : paymentMethod,
                          style: KTextStyle.buttonText4
                              .copyWith(color: Colors.white, fontSize: 10.8),
                          textAlign: TextAlign.center),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 4 * SizeConfig.imageSizeMultiplier,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  color: status == "Order Placed"
                      ? Colors.black
                      : store.state.darkModeState == false ||
                              store.state.darkModeState == null
                          ? Colors.grey
                          : Colors.redAccent,
                  icon: Icon(FontAwesomeIcons.trashAlt),
                  iconSize: 4 * SizeConfig.imageSizeMultiplier,
                  onPressed: () {
                    setState(() {
                      status == "Order Placed"
                          ? permissiondelete(context)
                          : _showMsg("This order is already $status!", 1);
                    });
                  }),
              Padding(
                padding:
                    EdgeInsets.only(top: 1.5 * SizeConfig.imageSizeMultiplier),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 30 * SizeConfig.imageSizeMultiplier,
                    height: 7 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                        color: status == "Order Placed"
                            ? Color(0xFFCCCCCB)
                            : status == "Processing"
                                ? Colors.lightBlue
                                : status == "Preparing for ship"
                                    ? Color(0xFFFBAF17)
                                    : status == "Shipped"
                                        ? Color(0xFF7B4199)
                                        : status == "Delivered"
                                            ? Color(0xFF607C36)
                                            : status == "Canceled"
                                                ? Color(0xFFE42D3B)
                                                : null,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            color: status == "Order Placed"
                                ? Color(0xFF7A7A7A)
                                : status == "Processing"
                                    ? Colors.lightBlue[800]!
                                    : status == "Preparing for ship"
                                        ? Color(0xFFC57134)
                                        : status == "Shipped"
                                            ? Color(0xFF38246B)
                                            : status == "Delivered"
                                                ? Color(0xFF223D1B)
                                                : status == "Canceled"
                                                    ? Color(0xFF951A1D)
                                                    : Colors.black,
                            width: 0.8)),
                    alignment: Alignment.center,
                    child: Text(status,
                        overflow: TextOverflow.clip,
                        style: KTextStyle.buttonText4.copyWith(
                            color: status == "Order Placed"
                                ? Color(0xFF7A7A7A)
                                : Colors.white,
                            fontSize: 10.8),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 1.5 * SizeConfig.imageSizeMultiplier),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 30 * SizeConfig.imageSizeMultiplier,
                    height: 7 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                        color: payment == "Pending"
                            ? Color(0xFFE42D3B)
                            : Color(0xFF607C36),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            color: payment == "Pending"
                                ? Color(0xFF951A1D)
                                : Color(0xFF223D1B),
                            width: 0.8)),
                    alignment: Alignment.center,
                    child: Text(payment,
                        style: KTextStyle.buttonText4
                            .copyWith(color: Colors.white, fontSize: 10.8),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
              SizedBox(
                height: 2 * SizeConfig.imageSizeMultiplier,
              ),
              Padding(
                padding: EdgeInsets.all(0.001 * SizeConfig.imageSizeMultiplier),
                child: Text.rich(
                  TextSpan(
                    text: "Total Amount : ",
                    style: KTextStyle.bodyText4.copyWith(
                      color: store.state.darkModeState == false ||
                              store.state.darkModeState == null
                          ? Colors.black
                          : Colors.grey[400],
                      fontSize: 9.5,
                    ),
                    children: [
                      TextSpan(
                          text: amount.toString(),
                          style: GoogleFonts.montserrat(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w400,
                              fontSize: 2.6 * SizeConfig.imageSizeMultiplier),
                          children: [
                            TextSpan(
                              text: "BDT",
                              style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.black
                                      : Colors.grey[400],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 9.5),
                            )
                          ]),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3 * SizeConfig.imageSizeMultiplier,
              ),
            ],
          )
        ],
      ),
    );
  }

  permissiondelete(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(7),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Cancel Order ",
                    style: KTextStyle.headline4,
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Do you want to cancel this order?",
                    style: KTextStyle.bodyText4.copyWith(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, right: 7, bottom: 15, left: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Cancel",
                                style: KTextStyle.bodyText4,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              orderTYpe == "MyOrder"
                                  ? myOrderdeleteHandeler(index)
                                  : preOrderdeleteHandeler(index);
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Delete",
                                style: KTextStyle.bodyText4
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        );
      });

  Future<void> myOrderdeleteHandeler(index) async {
    var data = {
      'billingAddress': store.state.myOrderState[index]['billingAddress'],
      'billingCity': store.state.myOrderState[index]['billingCity'],
      'bkashJson': store.state.myOrderState[index]['bkashJson'],
      'contact': store.state.myOrderState[index]['contact'],
      'coupon': store.state.myOrderState[index]['coupon'],
      'created_at': store.state.myOrderState[index]['created_at'],
      'dgAmount': store.state.myOrderState[index]['dgAmount'],
      'discount': store.state.myOrderState[index]['discount'],
      'discountType': store.state.myOrderState[index]['discountType'],
      'email': store.state.myOrderState[index]['email'],
      'giftVoucherAmount': store.state.myOrderState[index]['giftVoucherAmount'],
      'giftVoucherCode': store.state.myOrderState[index]['giftVoucherCode'],
      'grandTotal': store.state.myOrderState[index]['grandTotal'],
      'id': store.state.myOrderState[index]['id'],
      'invoice_id': store.state.myOrderState[index]['invoice_id'],
      'isDGMoney': store.state.myOrderState[index]['isDGMoney'],
      'name': store.state.myOrderState[index]['name'],
      'orderdetails': [
        {
          'created_at': store.state.myOrderState[index]['orderdetails'][0]
              ['created_at'],
          'id': store.state.myOrderState[index]['orderdetails'][0]['id'],
          'orderId': store.state.myOrderState[index]['orderdetails'][0]
              ['orderId'],
          'price': store.state.myOrderState[index]['orderdetails'][0]['price'],
          'product': {
            'admin_id': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['admin_id'],
            'averageBuyingPrice': store.state.myOrderState[index]
                ['orderdetails'][0]['product']['averageBuyingPrice'],
            'barCode': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['barCode'],
            'brand': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['brand'],
            'brandId': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['brandId'],
            'catName': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['catName'],
            'categoryId': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['categoryId'],
            'color': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['color'],
            'created_at': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['created_at'],
            'date': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['date'],
            'groupId': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['groupId'],
            'groupName': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['groupName'],
            'id': store.state.myOrderState[index]['orderdetails'][0]['product']
                ['id'],
            'model': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['model'],
            'mproductId': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['mproductId'],
            'openingQuantity': store.state.myOrderState[index]['orderdetails']
                [0]['product']['openingQuantity'],
            'openingUnitPrice': store.state.myOrderState[index]['orderdetails']
                [0]['product']['openingUnitPrice'],
            'productImage': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['productImage'],
            'productName': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['productName'],
            'sellingPrice': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['sellingPrice'],
            'size': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['size'],
            'stock': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['stock'],
            'unit': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['unit'],
            'updated_at': store.state.myOrderState[index]['orderdetails'][0]
                ['product']['updated_at'],
          },
          'productId': store.state.myOrderState[index]['orderdetails'][0]
              ['productId'],
          'quantity': store.state.myOrderState[index]['orderdetails'][0]
              ['quantity'],
          'updated_at': store.state.myOrderState[index]['orderdetails'][0]
              ['updated_at'],
        },
      ],
      'paymentStatus': store.state.myOrderState[index]['paymentStatus'],
      'paymentType': store.state.myOrderState[index]['paymentType'],
      'postCode': store.state.myOrderState[index]['postCode'],
      'referralCode': store.state.myOrderState[index]['referralCode'],
      'roundAmount': store.state.myOrderState[index]['roundAmount'],
      'sessionkey': store.state.myOrderState[index]['sessionkey'],
      'shippingPrice': store.state.myOrderState[index]['shippingPrice'],
      'status': store.state.myOrderState[index]['status'],
      'subTotal': store.state.myOrderState[index]['subTotal'],
      'updated_at': store.state.myOrderState[index]['updated_at'],
      'userId': store.state.myOrderState[index]['userId'],
    };
    var res = await CallApi().postData(data, '/app/cancelOrder');
    var body = json.decode(res.body);
    print('cancle body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Canceled Order!", 2);
      setState(() {
        status = "Canceled";
      });
    } else {
      _showMsg("This order already complete! ", 1);
    }
  }

  Future<void> preOrderdeleteHandeler(index) async {
    var data = {
      'billingAddress': store.state.preOrderDataState[index]['billingAddress'],
      'billingCity': store.state.preOrderDataState[index]['billingCity'],
      'bkashJson': store.state.preOrderDataState[index]['bkashJson'],
      'contact': store.state.preOrderDataState[index]['contact'],
      'coupon': store.state.preOrderDataState[index]['coupon'],
      'created_at': store.state.preOrderDataState[index]['created_at'],
      'dgAmount': store.state.preOrderDataState[index]['dgAmount'],
      'discount': store.state.preOrderDataState[index]['discount'],
      'discountType': store.state.preOrderDataState[index]['discountType'],
      'email': store.state.preOrderDataState[index]['email'],
      'giftVoucherAmount': store.state.preOrderDataState[index]
          ['giftVoucherAmount'],
      'giftVoucherCode': store.state.preOrderDataState[index]
          ['giftVoucherCode'],
      'grandTotal': store.state.preOrderDataState[index]['grandTotal'],
      'id': store.state.preOrderDataState[index]['id'],
      'invoice_id': store.state.preOrderDataState[index]['invoice_id'],
      'isDGMoney': store.state.preOrderDataState[index]['isDGMoney'],
      'name': store.state.preOrderDataState[index]['name'],
      'orderdetails': [
        {
          'created_at': store.state.preOrderDataState[index]['orderdetails'][0]
              ['created_at'],
          'id': store.state.preOrderDataState[index]['orderdetails'][0]['id'],
          'orderId': store.state.preOrderDataState[index]['orderdetails'][0]
              ['orderId'],
          'price': store.state.preOrderDataState[index]['orderdetails'][0]
              ['price'],
          'product': {
            'admin_id': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['admin_id'],
            'averageBuyingPrice': store.state.preOrderDataState[index]
                ['orderdetails'][0]['product']['averageBuyingPrice'],
            'barCode': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['barCode'],
            'brand': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['brand'],
            'brandId': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['brandId'],
            'catName': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['catName'],
            'categoryId': store.state.preOrderDataState[index]['orderdetails']
                [0]['product']['categoryId'],
            'color': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['color'],
            'created_at': store.state.preOrderDataState[index]['orderdetails']
                [0]['product']['created_at'],
            'date': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['date'],
            'groupId': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['groupId'],
            'groupName': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['groupName'],
            'id': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['id'],
            'model': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['model'],
            'mproductId': store.state.preOrderDataState[index]['orderdetails']
                [0]['product']['mproductId'],
            'openingQuantity': store.state.preOrderDataState[index]
                ['orderdetails'][0]['product']['openingQuantity'],
            'openingUnitPrice': store.state.preOrderDataState[index]
                ['orderdetails'][0]['product']['openingUnitPrice'],
            'productImage': store.state.preOrderDataState[index]['orderdetails']
                [0]['product']['productImage'],
            'productName': store.state.preOrderDataState[index]['orderdetails']
                [0]['product']['productName'],
            'sellingPrice': store.state.preOrderDataState[index]['orderdetails']
                [0]['product']['sellingPrice'],
            'size': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['size'],
            'stock': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['stock'],
            'unit': store.state.preOrderDataState[index]['orderdetails'][0]
                ['product']['unit'],
            'updated_at': store.state.preOrderDataState[index]['orderdetails']
                [0]['product']['updated_at'],
          },
          'productId': store.state.preOrderDataState[index]['orderdetails'][0]
              ['productId'],
          'quantity': store.state.preOrderDataState[index]['orderdetails'][0]
              ['quantity'],
          'updated_at': store.state.preOrderDataState[index]['orderdetails'][0]
              ['updated_at'],
        },
      ],
      'paymentStatus': store.state.preOrderDataState[index]['paymentStatus'],
      'paymentType': store.state.preOrderDataState[index]['paymentType'],
      'postCode': store.state.preOrderDataState[index]['postCode'],
      'referralCode': store.state.preOrderDataState[index]['referralCode'],
      'roundAmount': store.state.preOrderDataState[index]['roundAmount'],
      'sessionkey': store.state.preOrderDataState[index]['sessionkey'],
      'shippingPrice': store.state.preOrderDataState[index]['shippingPrice'],
      'status': store.state.preOrderDataState[index]['status'],
      'subTotal': store.state.preOrderDataState[index]['subTotal'],
      'updated_at': store.state.preOrderDataState[index]['updated_at'],
      'userId': store.state.preOrderDataState[index]['userId'],
    };
    var res = await CallApi().postData(data, '/app/cancelOrder');
    var body = json.decode(res.body);
    print('cancle body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Canceled Order!", 2);
      setState(() {
        status = "Canceled";
      });
    } else {
      _showMsg("This order already complete! ", 1);
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
}
