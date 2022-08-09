import 'package:dream_gallary/screen/myorder/trackingOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class MyOrderDetails extends StatelessWidget {
  final orderId;
  final date;
  final name;
  final billingAddress;
  final billingCity;
  final contact;
  final paymentMethod;
  final paymentStatus;
  final subTotal;
  final grandTotal;
  final discount;
  final deliveryCharge;
  final orderDetails;
  final status;
  final coupon;
  final discountType;
  final giftVoucherAmount;
  final giftVoucherCode;
  final referralCode;

  MyOrderDetails({
    Key? key,
    @required this.orderId,
    @required this.date,
    @required this.name,
    @required this.billingAddress,
    @required this.billingCity,
    @required this.contact,
    @required this.paymentMethod,
    @required this.paymentStatus,
    @required this.subTotal,
    @required this.grandTotal,
    @required this.discount,
    @required this.deliveryCharge,
    @required this.orderDetails,
    @required this.status,
    @required this.giftVoucherCode,
    @required this.referralCode,
    @required this.discountType,
    @required this.coupon,
    @required this.giftVoucherAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? Colors.white
            : Color(0xFF0F0E0E),
        appBar: AppBar(
          backgroundColor: store.state.darkModeState == false ||
                  store.state.darkModeState == null
              ? Colors.white
              : Colors.grey[900],
          elevation: 0.6,
          title: Text(
            "Order Details",
            style: KTextStyle.headline5.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 6 * SizeConfig.imageSizeMultiplier,
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: double.infinity,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                padding: EdgeInsets.all(2 * SizeConfig.imageSizeMultiplier),
                height: 66 * SizeConfig.imageSizeMultiplier,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    5 * SizeConfig.imageSizeMultiplier,
                    3.5 * SizeConfig.imageSizeMultiplier,
                    5 * SizeConfig.imageSizeMultiplier,
                    3 * SizeConfig.imageSizeMultiplier,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.6 * SizeConfig.imageSizeMultiplier,
                      ),
                      Text.rich(
                        TextSpan(
                            text: "#PX",
                            style: KTextStyle.subtitle2.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                            children: [
                              TextSpan(
                                text: orderId.toString(),
                                style: KTextStyle.subtitle2.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                              )
                            ]),
                      ),
                      SizedBox(height: 1.3 * SizeConfig.imageSizeMultiplier),
                      Text.rich(
                        TextSpan(
                            text: "Order Date : ",
                            style: KTextStyle.bodyText4.copyWith(
                              color: Colors.grey[700]!.withOpacity(0.9),
                            ),
                            children: [
                              TextSpan(
                                text: date,
                                style: KTextStyle.bodyText4.copyWith(
                                  color: Colors.grey[700]!.withOpacity(0.9),
                                ),
                              )
                            ]),
                      ),
                      SizedBox(height: 1.7 * SizeConfig.imageSizeMultiplier),
                      Text(
                        "Delivered To :",
                        style: KTextStyle.bodyText4.copyWith(
                          color: Colors.grey[700]!.withOpacity(0.9),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                          Text(
                            billingAddress,
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                          Text(
                            billingCity,
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                          Text(
                            contact,
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.8 * SizeConfig.imageSizeMultiplier),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Method :",
                              style: KTextStyle.bodyText4.copyWith(
                                color: Colors.grey[700]!.withOpacity(0.9),
                              ),
                            ),
                            Text(
                              paymentMethod == "sslcommerz"
                                  ? "Payment Gateway"
                                  : paymentMethod,
                              style: KTextStyle.bodyText4.copyWith(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                          ]),
                      SizedBox(height: 1.8 * SizeConfig.imageSizeMultiplier),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Status :",
                              style: KTextStyle.bodyText4.copyWith(
                                color: Colors.grey[700]!.withOpacity(0.9),
                              ),
                            ),
                            Text(
                              paymentStatus,
                              style: KTextStyle.bodyText4.copyWith(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 1.05 * SizeConfig.imageSizeMultiplier),
                child: Container(
                  width: 90 * SizeConfig.imageSizeMultiplier,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 56.5 * SizeConfig.imageSizeMultiplier,
                            height: 22,
                            color: Colors.black,
                            alignment: Alignment.centerLeft,
                            child: Text.rich(
                              TextSpan(
                                text: "Description",
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.white
                                      : Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Price",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                          Text(
                            "Qty.",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                          Text(
                            "Total",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              ...List.generate(
                  orderDetails.length,
                  (index) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.05 * SizeConfig.imageSizeMultiplier),
                        child: Container(
                          width: 100 * SizeConfig.imageSizeMultiplier,
                          padding: EdgeInsets.symmetric(
                              horizontal: 6 * SizeConfig.imageSizeMultiplier),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 55 * SizeConfig.imageSizeMultiplier,
                                    child: Text.rich(
                                      TextSpan(
                                          text:
                                              "${orderDetails[index]['product']['productName']} ",
                                          style: KTextStyle.bodyText4.copyWith(
                                            color: store.state.darkModeState ==
                                                        false ||
                                                    store.state.darkModeState ==
                                                        null
                                                ? Colors.black
                                                : Colors.grey[400],
                                          ),
                                          children: [
                                            TextSpan(
                                                text:
                                                    "${orderDetails[index]['product']['model']} ",
                                                style: KTextStyle.bodyText4
                                                    .copyWith(
                                                  color: store.state
                                                                  .darkModeState ==
                                                              false ||
                                                          store.state
                                                                  .darkModeState ==
                                                              null
                                                      ? Colors.black
                                                      : Colors.grey[400],
                                                ),
                                                children: []),
                                            orderDetails[index]['product']
                                                        ['color'] ==
                                                    null
                                                ? TextSpan(
                                                    text: " ",
                                                    style: KTextStyle.bodyText4
                                                        .copyWith(
                                                      color: store.state
                                                                      .darkModeState ==
                                                                  false ||
                                                              store.state
                                                                      .darkModeState ==
                                                                  null
                                                          ? Colors.black
                                                          : Colors.grey[400],
                                                    ),
                                                    children: [])
                                                : TextSpan(
                                                    text:
                                                        "${orderDetails[index]['product']['color']} ",
                                                    style: KTextStyle.bodyText4
                                                        .copyWith(
                                                      color: store.state
                                                                      .darkModeState ==
                                                                  false ||
                                                              store.state
                                                                      .darkModeState ==
                                                                  null
                                                          ? Colors.black
                                                          : Colors.grey[400],
                                                    ),
                                                    children: []),
                                            orderDetails[index]['product']
                                                        ['size'] ==
                                                    null
                                                ? TextSpan(
                                                    text: " ",
                                                    style: KTextStyle.bodyText4
                                                        .copyWith(
                                                      color: store.state
                                                                      .darkModeState ==
                                                                  false ||
                                                              store.state
                                                                      .darkModeState ==
                                                                  null
                                                          ? Colors.black
                                                          : Colors.grey[400],
                                                    ),
                                                    children: [])
                                                : TextSpan(
                                                    text:
                                                        "${orderDetails[index]['product']['size']} ",
                                                    style: KTextStyle.bodyText4
                                                        .copyWith(
                                                      color: store.state
                                                                      .darkModeState ==
                                                                  false ||
                                                              store.state
                                                                      .darkModeState ==
                                                                  null
                                                          ? Colors.black
                                                          : Colors.grey[400],
                                                    ),
                                                    children: []),
                                          ]),
                                    ),
                                  ),
                                  Text(
                                    (orderDetails[index]['price']).toString(),
                                    style: KTextStyle.bodyText4.copyWith(
                                      color: store.state.darkModeState ==
                                                  false ||
                                              store.state.darkModeState == null
                                          ? Colors.black
                                          : Colors.grey[400],
                                    ),
                                  ),
                                  Text(
                                    orderDetails[index]['quantity'].toString(),
                                    style: KTextStyle.bodyText4.copyWith(
                                      color: store.state.darkModeState ==
                                                  false ||
                                              store.state.darkModeState == null
                                          ? Colors.black
                                          : Colors.grey[400],
                                    ),
                                  ),
                                  Text(
                                    (orderDetails[index]['quantity'] *
                                            orderDetails[index]['price'])
                                        .toString(),
                                    style: KTextStyle.bodyText4.copyWith(
                                      color: store.state.darkModeState ==
                                                  false ||
                                              store.state.darkModeState == null
                                          ? Colors.black
                                          : Colors.grey[400],
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      )),
              Divider(
                indent: 5 * SizeConfig.imageSizeMultiplier,
                endIndent: 5 * SizeConfig.imageSizeMultiplier,
                color: Colors.grey[400],
                thickness: 0.7,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: 6 * SizeConfig.imageSizeMultiplier),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40 * SizeConfig.imageSizeMultiplier,
                            child: Text(
                              "Sub Total",
                              style: KTextStyle.bodyText4.copyWith(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                          ),
                          Text(
                            subTotal.toString(),
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          )
                        ]),
                  ),
                  if (coupon != "" && discountType != "")
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60 * SizeConfig.imageSizeMultiplier,
                              child: Text(
                                "Promo code discount( $coupon)",
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                              ),
                            ),
                            Text(
                              discount.toString(),
                              style: KTextStyle.bodyText4.copyWith(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            )
                          ]),
                    ),
                  if (giftVoucherCode != "" && giftVoucherAmount != 0)
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 40 * SizeConfig.imageSizeMultiplier,
                              child: Text(
                                "GiftVoucher ",
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                              ),
                            ),
                            Text(
                              giftVoucherAmount.toString(),
                              style: KTextStyle.bodyText4.copyWith(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            )
                          ]),
                    ),
                  if (referralCode != "")
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 40 * SizeConfig.imageSizeMultiplier,
                              child: Text(
                                "Refferal Discount (5%) ",
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                              ),
                            ),
                            Text(
                              "5",
                              style: KTextStyle.bodyText4.copyWith(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            )
                          ]),
                    ),
                  if (store.state.userDataState['customer']['barcode'] != null)
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 40 * SizeConfig.imageSizeMultiplier,
                              child: Text(
                                "MemberShip Discount (10%) ",
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                              ),
                            ),
                            Text(
                              "10",
                              style: KTextStyle.bodyText4.copyWith(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            )
                          ]),
                    ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40 * SizeConfig.imageSizeMultiplier,
                            child: Text(
                              "Delivery Charge",
                              style: KTextStyle.bodyText4.copyWith(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.black
                                    : Colors.grey[400],
                              ),
                            ),
                          ),
                          Text(
                            deliveryCharge.toString(),
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          )
                        ]),
                  ),
                ]),
              ),
              Divider(
                indent: 5 * SizeConfig.imageSizeMultiplier,
                endIndent: 5 * SizeConfig.imageSizeMultiplier,
                color: Colors.grey[400],
                thickness: 0.7,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: 6 * SizeConfig.imageSizeMultiplier),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40 * SizeConfig.imageSizeMultiplier,
                          child: Text(
                            "Grand Total",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                        ),
                        Text(
                          grandTotal.toString(),
                          style: KTextStyle.bodyText4.copyWith(
                            color: store.state.darkModeState == false ||
                                    store.state.darkModeState == null
                                ? Colors.black
                                : Colors.grey[400],
                          ),
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: 5 * SizeConfig.imageSizeMultiplier,
              ),
            ]),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(
              2.0 * SizeConfig.imageSizeMultiplier,
              2.2 * SizeConfig.imageSizeMultiplier,
              2.0 * SizeConfig.imageSizeMultiplier,
              2.2 * SizeConfig.imageSizeMultiplier),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) => TrackOrder(
                            orderId: orderId,
                            statusValue: status,
                          )));
            },
            child: Container(
              width: 30 * SizeConfig.imageSizeMultiplier,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                      vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                  child: Text("Track Order",
                      style: KTextStyle.buttonText3.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center)),
            ),
          ),
        ));
  }
}
