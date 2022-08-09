import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/component/all_pcategory_card.dart';
import 'package:dream_gallary/home_screen/home_screen.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class Sale extends StatefulWidget {
  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();
  void initState() {
    _filterShopData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      enableLoadingWhenFailed: true,
      context: context,
      child: Scaffold(
        backgroundColor: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.grey[200]
            : Color(0xFF0F0E0E),
        appBar: AppBar(
          backgroundColor: store.state.darkModeState == null ||
                  store.state.darkModeState == false
              ? Colors.white
              : Colors.grey[900],
          elevation: 0.0,
          title: Text(
            "Sale!",
            style: KTextStyle.headline5.copyWith(
              color: store.state.darkModeState == null ||
                      store.state.darkModeState == false
                  ? Colors.black
                  : Colors.grey[400],
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
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeScreen()),
                  ModalRoute.withName('/'),
                );
              }),
          centerTitle: true,
        ),
        body: SmartRefresher(
          key: _refresherKey,
          controller: _refreshController,
          enablePullUp: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: getBody(),
          ),
          physics: BouncingScrollPhysics(),
          footer: ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              textStyle: TextStyle(
                color: store.state.darkModeState == null ||
                        store.state.darkModeState == false
                    ? Colors.black
                    : Colors.grey[400],
              )),
        ),
      ),
      footerTriggerDistance: 20,
    );
  }

  Widget getBody() {
    return store.state.isLoadingState == true
        ? Shimmer.fromColors(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, top: 4, right: 8.0, bottom: 4),
                        child: Container(
                          //margin: EdgeInsets.only(right: 1),
                          width: 45.5 * SizeConfig.imageSizeMultiplier,
                          height: 37 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, top: 4, right: 8.0, bottom: 4),
                        child: Container(
                          //padding:  EdgeInsets.fromLTRB(2, 0, 2, 0),
                          //margin: EdgeInsets.only(right: 10,top:10),
                          width: 45.55 * SizeConfig.imageSizeMultiplier,
                          height: 37 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, top: 4, right: 8.0, bottom: 4),
                        child: Container(
                          //margin: EdgeInsets.only(right: 1),
                          width: 45.5 * SizeConfig.imageSizeMultiplier,
                          height: 37 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, top: 4, right: 8.0, bottom: 4),
                        child: Container(
                          width: 45.55 * SizeConfig.imageSizeMultiplier,
                          height: 37 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, top: 4, right: 8.0, bottom: 4),
                        child: Container(
                          //margin: EdgeInsets.only(right: 1),
                          width: 45.5 * SizeConfig.imageSizeMultiplier,
                          height: 37 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, top: 4, right: 8.0, bottom: 4),
                        child: Container(
                          width: 45.55 * SizeConfig.imageSizeMultiplier,
                          height: 37 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            baseColor: Colors.grey[350]!,
            highlightColor: Colors.white,
            period: Duration(
              seconds: 4,
            ),
            loop: 1,
            enabled: true,
          )
        : Wrap(
            spacing: 1.3 * SizeConfig.imageSizeMultiplier,
            key: _contentKey,
            children: [
                ...List.generate(
                  store.state.salePageState.length,
                  (index) {
                    return AllProductCard(
                      id: store.state.salePageState[index]['id'],
                      imagePath: store.state.salePageState[index]
                          ['productImage'],
                      categoryName: store.state.salePageState[index]
                          ['allcategory']['catName'],
                      productName: store.state.salePageState[index]
                          ['productName'],
                      //discount: store.state.salePageState[index]['discount'],
                      appDiscount: store.state.salePageState[index]
                          ['appDiscount'],
                      price: store.state.salePageState[index]['sellingPrice']
                          .toString(),
                      discountPrice:
                          store.state.salePageState[index]['appDiscount'] > 0
                              ? (store.state.salePageState[index]
                                          ['sellingPrice'] -
                                      (store.state.salePageState[index]
                                                  ['sellingPrice'] *
                                              store.state.salePageState[index]
                                                  ['appDiscount']) /
                                          100)
                                  .toString()
                              : "0",
                      ratingStar:
                          store.state.salePageState[index]['avgRating'] == null
                              ? 0
                              : store.state.salePageState[index]['avgRating']
                                  ['averageRating'],
                    );
                  },
                ),
              ]);
  }

  // ignore: unused_element
  Future<void> _filterShopData({int page = 1}) async {
    print("I am in filter shop method");

    var resAllSalePage =
        await CallApi().withoutTokengetData("/app/appSalePageData");
    print(resAllSalePage.statusCode);
    if (resAllSalePage.statusCode == 200) {
      print("resAllShopPage.statusCode");
      var body = json.decode(resAllSalePage.body);
      setState(() {
        store.dispatch(SalePageAction(body['products']['data']));
      });
      //print("store.state.shopPageState");
      print(store.state.shopPageState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }
}
