import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/model/order_headerlist.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/myorder/order_item.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import 'myorder_details.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  var limit = 10;
  var total;
  int activeMenu = 0;
  var selectedValue;
  var status;
  void initState() {
    _getAllOrder();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();
  void _onLoading() async {
    limit = limit + 10;
    await _egerLoadingMyOrder(limit: limit);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _refreshController.loadComplete();
    });
  }

  Future<void> _getAllOrder() async {
    var res = await CallApi().getData('/app/order');
    var body = json.decode(res.body);
    total = body['order']['total'];
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    print("total - ${body['order']['total']}");
    setState(() {
      store.state.myOrderState = body['order']['data'];
      store.dispatch(MyOrderAction(store.state.myOrderState));
//      store.state.myOrderDataState =body['order']['data']['orderdetails'];
//       store.dispatch((MyOrderDataAction(store.state.myOrderDataState)));
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
    return RefreshConfiguration.copyAncestor(
        enableLoadingWhenFailed: true,
        context: context,
        child: Scaffold(
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
                "My Orders",
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
                    store.state.myOrderState = [];
                    Navigator.pop(context);
                  }),
              centerTitle: true,
            ),
            body: (total == limit)
                ? SmartRefresher(
                    key: _refresherKey,
                    controller: _refreshController,
                    enablePullUp: true,
                    child: getBody(),
                    physics: BouncingScrollPhysics(),
                    footer: ClassicFooter(
                      loadStyle: LoadStyle.ShowWhenLoading,
                    ),
                    onLoading: _onLoading,
                  )
                : getBody()));
  }

  Widget getBody() {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(top: 0.2 * SizeConfig.imageSizeMultiplier),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.grey[300]!
                  : Colors.grey[900]!,
              width: 0.6,
            ),
          )),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(myOrder.length, (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      activeMenu = index;
                      selectedValue = myOrder[index]["text"];
                      statusApi();
                      store.state.statusState = null;
                    });
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.all(1.5 * SizeConfig.imageSizeMultiplier),
                    child: Text(
                      myOrder[index]["text"],
                      style: KTextStyle.bodyText4.copyWith(
                          color: store.state.darkModeState == false ||
                                  store.state.darkModeState == null
                              ? activeMenu == index
                                  ? Colors.black
                                  : Colors.grey
                              : activeMenu == index
                                  ? Colors.grey[700]
                                  : Colors.grey[400]),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: (activeMenu == 0)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      store.state.myOrderState.length,
                      (index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyOrderDetails(
                                            orderId: store.state
                                                .myOrderState[index]['id'],
                                            name: store.state
                                                .myOrderState[index]['name'],
                                            contact: store.state
                                                .myOrderState[index]['contact'],
                                            date:
                                                store.state.myOrderState[index]
                                                    ['created_at'],
                                            paymentStatus:
                                                store.state.myOrderState[index]
                                                    ['paymentStatus'],
                                            paymentMethod:
                                                store.state.myOrderState[index]
                                                    ['paymentType'],
                                            billingAddress:
                                                store.state.myOrderState[index]
                                                    ['billingAddress'],
                                            billingCity:
                                                store.state.myOrderState[index]
                                                    ['billingCity'],
                                            discount:
                                                store.state.myOrderState[index]
                                                    ['discount'],
                                            deliveryCharge:
                                                store.state.myOrderState[index]
                                                    ['shippingPrice'],
                                            grandTotal: store.state
                                                        .myOrderState[index]
                                                    ['shippingPrice'] +
                                                store.state.myOrderState[index]
                                                    ['grandTotal'],
                                            subTotal:
                                                store.state.myOrderState[index]
                                                    ['subTotal'],
                                            orderDetails:
                                                store.state.myOrderState[index]
                                                    ['orderdetails'],
                                            status: store.state
                                                .myOrderState[index]['status'],
                                            giftVoucherCode:
                                                store.state.myOrderState[index]
                                                    ['giftVoucherCode'],
                                            referralCode:
                                                store.state.myOrderState[index]
                                                    ['referralCode'],
                                            coupon: store.state
                                                .myOrderState[index]['coupon'],
                                            discountType:
                                                store.state.myOrderState[index]
                                                    ['discountType'],
                                            giftVoucherAmount:
                                                store.state.myOrderState[index]
                                                    ['giftVoucherAmount'],
                                          ))); //order:store.state.myOrderState,
                            },
                            child: Container(
                                padding: EdgeInsets.all(
                                    1.7 * SizeConfig.imageSizeMultiplier),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: OrderCard(
                                  orderId: store.state.myOrderState[index]
                                      ['id'],
                                  name: store.state.myOrderState[index]['name'],
                                  phone: store.state.myOrderState[index]
                                      ['contact'],
                                  date: store.state.myOrderState[index]
                                      ['created_at'],
                                  paymentMethod: store.state.myOrderState[index]
                                      ['paymentType'],
                                  payment: store.state.myOrderState[index]
                                      ['paymentStatus'],
                                  amount: store.state.myOrderState[index]
                                          ['grandTotal'] +
                                      store.state.myOrderState[index]
                                          ['shippingPrice'],
                                  status: store.state.myOrderState[index]
                                      ['status'],
                                  orderType: "MyOrder",
                                  index: index,
                                )));
                        // here by default width and height is 0
                      },
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      store.state.statusState.length,
                      (index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyOrderDetails(
                                            orderId: store
                                                .state.statusState[index]['id'],
                                            name: store.state.statusState[index]
                                                ['name'],
                                            contact: store.state
                                                .statusState[index]['contact'],
                                            date: store.state.statusState[index]
                                                ['created_at'],
                                            paymentStatus:
                                                store.state.statusState[index]
                                                    ['paymentStatus'],
                                            paymentMethod:
                                                store.state.statusState[index]
                                                    ['paymentType'],
                                            billingAddress:
                                                store.state.statusState[index]
                                                    ['billingAddress'],
                                            billingCity:
                                                store.state.statusState[index]
                                                    ['billingCity'],
                                            discount: store.state
                                                .statusState[index]['discount'],
                                            deliveryCharge:
                                                store.state.statusState[index]
                                                    ['shippingPrice'],
                                            grandTotal: store.state
                                                        .statusState[index]
                                                    ['shippingPrice'] +
                                                store.state.statusState[index]
                                                    ['grandTotal'],
                                            subTotal: store.state
                                                .statusState[index]['subTotal'],
                                            orderDetails:
                                                store.state.statusState[index]
                                                    ['orderdetails'],
                                            status: store.state
                                                .statusState[index]['status'],
                                            giftVoucherCode:
                                                store.state.statusState[index]
                                                    ['giftVoucherCode'],
                                            referralCode:
                                                store.state.statusState[index]
                                                    ['referralCode'],
                                            coupon: store.state
                                                .statusState[index]['coupon'],
                                            discountType:
                                                store.state.statusState[index]
                                                    ['discountType'],
                                            giftVoucherAmount:
                                                store.state.statusState[index]
                                                    ['giftVoucherAmount'],
                                          ))); //order:store.state.myOrderState,
                            },
                            child: Container(
                                padding: EdgeInsets.all(
                                    1.7 * SizeConfig.imageSizeMultiplier),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: (store.state.statusState.isEmpty)
                                    ? Container()
                                    : OrderCard(
                                        index: index,
                                        orderId: store.state.statusState[index]
                                            ['id'],
                                        name: store.state.statusState[index]
                                            ['name'],
                                        phone: store.state.statusState[index]
                                            ['contact'],
                                        date: store.state.statusState[index]
                                            ['created_at'],
                                        paymentMethod: store.state
                                            .statusState[index]['paymentType'],
                                        payment: store.state.statusState[index]
                                            ['paymentStatus'],
                                        amount: store.state.statusState[index]
                                            ['grandTotal'],
                                        status: store.state.statusState[index]
                                            ['status'],
                                            
                                        orderType: "MyOrder",)));
                        // here by default width and height is 0
                      },
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Future<void> _egerLoadingMyOrder({limit}) async {
    var resAllMyOrder =
        await CallApi().getData("/app/order?isApp=1&limit=$limit");
    print(resAllMyOrder.statusCode);
    if (resAllMyOrder.statusCode == 200) {
      var body = json.decode(resAllMyOrder.body);
      print(body);
      print(body['order']);
      setState(() {
        store.state.myOrderState = body['order'];
        store.dispatch(MyOrderAction(store.state.myOrderState));
      });
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  Future<void> statusApi() async {
    var resAllStatusData =
        await CallApi().getData("/app/order?isApp=1&status=$selectedValue");
    print(resAllStatusData.statusCode);
    if (resAllStatusData.statusCode == 200) {
      var body = json.decode(resAllStatusData.body);
      store.state.statusState = body['order'];
      print(store.state.statusState);
      print(store.state.statusState.length);
      print(body);
      print(body['order']);
      List.generate(store.state.statusState.length, (index) {
        return status = store.state.statusState[index];
      });
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }
}
