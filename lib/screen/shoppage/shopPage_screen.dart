import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/component/all_pcategory_card.dart';
import 'package:dream_gallary/home_screen/home_screen.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/FilterPage/filter_page_screen.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../constant.dart';
import '../../k_text_style.dart';
import '../../main.dart';

class ShopPageProduct extends StatefulWidget {
  final groupCategoryValue;

  ShopPageProduct({@required this.groupCategoryValue});
  @override
  _ShopPageProductState createState() =>
      _ShopPageProductState(groupCategoryValue);
}

class _ShopPageProductState extends State<ShopPageProduct> {
  var groupCategoryValue;
  _ShopPageProductState(this.groupCategoryValue);
  var increasePage;
  var activeMenu = store.state.categoryIndex;

  late int selectIndex = 6;

  late String searchString = '';
  late String id = store.state.singleProductIdState;

  void initState() {
    _filterShopData();
    _getAllFilterBrandApiData();
    _getAllFilterColorApiData();
    _getAllFilterCategoryApiData();
    _getAllFilterTagApiData();

    super.initState();
  }

  int page = 1;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  void _onRefresh() async {
    //await Future.delayed(Duration(seconds: 2));
    page = 1;
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    page++;
    await _egerLoadingfilterShopData(page: page);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _refreshController.loadComplete();
    });
  }

  Future<void> _getAllFilterBrandApiData() async {
    var resAllFilterBrand =
        await CallApi().withoutTokengetData('/app/AllBrands');
    if (resAllFilterBrand.statusCode == 200) {
      var body = json.decode(resAllFilterBrand.body);
      setState(() {
        store.dispatch(BrandAction(body['brands']));
      });
      print("store.state.brandState");
      print(store.state.brandState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  Future<void> _getAllFilterColorApiData() async {
    var resAllFilterColor =
        await CallApi().withoutTokengetData('/app/allColors');
    if (resAllFilterColor.statusCode == 200) {
      var body = json.decode(resAllFilterColor.body);
      setState(() {
        store.dispatch(ColorAction(body['colors']));
      });
      print("store.state.colorstate");
      print(store.state.colorState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  Future<void> _getAllFilterCategoryApiData() async {
    var resAllFilterCategory =
        await CallApi().withoutTokengetData('/app/allGroups');
    if (resAllFilterCategory.statusCode == 200) {
      var body = json.decode(resAllFilterCategory.body);
      setState(() {
        store.dispatch(CategoryAction(body['groups']));
      });
      print("store.state.categorystate");
      print(store.state.categoryState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  Future<void> _getAllFilterTagApiData() async {
    var resAllFilterTag = await CallApi().withoutTokengetData('/app/allTags');
    if (resAllFilterTag.statusCode == 200) {
      var body = json.decode(resAllFilterTag.body);
      setState(() {
        store.dispatch(TagAction(body['tags']));
      });
      print("store.state.tagstate");
      print(store.state.tagState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      enableLoadingWhenFailed: true,
      context: context,
      child: Scaffold(
        backgroundColor: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.grey[100]
            : Color(0xFF0F0E0E),
        appBar: AppBar(
          backgroundColor: store.state.darkModeState == null ||
                  store.state.darkModeState == false
              ? Colors.white
              : Color(0xFF0F0E0E),
          elevation: 0.0,
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
                store.state.categoryIndex = null;
                store.state.filterHomeBrand = null;

                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomeScreen()),
                  ModalRoute.withName('/'),
                );
              }),
          actions: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
                  children: [
                    Container(
                      width: 71 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? kSecondaryColor.withOpacity(0.1)
                            : Colors.grey[900],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: TextFormField(
                          style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.white),
                          onChanged: (text) {
                            setState(() {
                              searchString = text;
                            });
                            _filterShopData();
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 4 * SizeConfig.imageSizeMultiplier),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'What would you like to buy?',
                            hintStyle: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.grey
                                  : Colors.grey[600],
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.slidersH,
                        ),
                        iconSize: 6 * SizeConfig.imageSizeMultiplier,
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[400],
                        onPressed: () {
                          setState(() {
                            store.state.categoryIndex = null;
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilterPage()));
                        }),
                  ],
                ))
          ],
        ),
        body: SmartRefresher(
          key: _refresherKey,
          controller: _refreshController,
          enablePullUp: true,
          child: ListView(children: [
            Container(
              padding:
                  EdgeInsets.only(top: 0.7 * SizeConfig.imageSizeMultiplier),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey[700]!,
                  width: 0.6,
                ),
              )),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 1.3 * SizeConfig.imageSizeMultiplier,
                        left: 1.3 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            activeMenu = selectIndex;
                            groupCategoryValue = '';
                          });
                          _filterShopData();
                        },
                        child: Padding(
                            padding: EdgeInsets.all(
                                2.9 * SizeConfig.imageSizeMultiplier),
                            child: Text(
                              "All",
                              style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == null ||
                                          store.state.darkModeState == false
                                      ? activeMenu == selectIndex
                                          ? Colors.black
                                          : Colors.grey
                                      : activeMenu == selectIndex
                                          ? Colors.grey[700]
                                          : Colors.grey[400]),
                            )),
                      ),
                    ),
                    ...List.generate(store.state.groupProductState.length,
                        (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            right: 1.3 * SizeConfig.imageSizeMultiplier),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              activeMenu = index;
                              groupCategoryValue =
                                  store.state.groupProductState[index]['id'];
                            });
                            _filterShopData();
                          },
                          child: Padding(
                              padding: EdgeInsets.all(
                                  2.9 * SizeConfig.imageSizeMultiplier),
                              child: Text(
                                store.state.groupProductState[index]
                                    ['groupName'],
                                style: KTextStyle.bodyText4.copyWith(
                                    color: store.state.darkModeState == null ||
                                            store.state.darkModeState == false
                                        ? activeMenu == index
                                            ? Colors.black
                                            : Colors.grey
                                        : activeMenu == index
                                            ? Colors.grey[700]
                                            : Colors.grey[300]),
                              )),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 1 * SizeConfig.heightMultiplier,
            ),
            getBody(),
          ]),
          physics: BouncingScrollPhysics(),
          footer: ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              textStyle: KTextStyle.bodyText4.copyWith(
                color: store.state.darkModeState == null ||
                        store.state.darkModeState == false
                    ? Colors.black
                    : Colors.grey[400],
              )),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
        ),
      ),
      footerTriggerDistance: 20,
    );
  }

  Future<void> _filterShopData({int page = 1}) async {
    print("I am in filter shop method");
    var minPrice =
        (store.state.filterMinPrice == null) ? '' : store.state.filterMinPrice;
    var maxPrice =
        (store.state.filterMaxPrice == null) ? '' : store.state.filterMaxPrice;
    var brandValue =
        (store.state.filterBrand == null) ? '' : store.state.filterBrand;
    var homeBrandValue = (store.state.filterHomeBrand == null)
        ? brandValue
        : store.state.filterHomeBrand;
    var colorValue =
        (store.state.filterColor == null) ? '' : store.state.filterColor;
    var categoryValue =
        (store.state.filterCategory == null) ? '' : store.state.filterCategory;
    var subcategoryValue = (store.state.filterSubcategory == null)
        ? ''
        : store.state.filterSubcategory;
    var tagValue = (store.state.filterTag == null) ? '' : store.state.filterTag;

    var resAllShopPage = await CallApi().withoutTokengetData(
        "/app/shopPageData?&order=id%2Cdesc&page=$page&groupId=${groupCategoryValue ?? categoryValue}&categoryId=$subcategoryValue&tags=$tagValue&str=$searchString&minPrice=$minPrice&maxPrice=$maxPrice&brandId=${homeBrandValue ?? brandValue}&colour=$colorValue");
    print(resAllShopPage.statusCode);
    if (resAllShopPage.statusCode == 200) {
      print("resAllShopPage.statusCode");
      var body = json.decode(resAllShopPage.body);
      setState(() {
        store.dispatch(ShopPageAction(body['products']['data']));
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

  Future<void> _egerLoadingfilterShopData({int page = 1}) async {
    print("I am in filter shop method");
    var minPrice =
        (store.state.filterMinPrice == null) ? '' : store.state.filterMinPrice;
    var maxPrice =
        (store.state.filterMaxPrice == null) ? '' : store.state.filterMaxPrice;
    var brandValue =
        (store.state.filterBrand == null) ? '' : store.state.filterBrand;
    var homeBrandValue = (store.state.filterHomeBrand == null)
        ? ''
        : store.state.filterHomeBrand;
    var colorValue =
        (store.state.filterColor == null) ? '' : store.state.filterColor;
    var categoryValue =
        (store.state.filterCategory == null) ? '' : store.state.filterCategory;
    var subcategoryValue = (store.state.filterSubcategory == null)
        ? ''
        : store.state.filterSubcategory;
    var tagValue = (store.state.filterTag == null) ? '' : store.state.filterTag;
    var resAllShopPage = await CallApi().withoutTokengetData(
        "/app/shopPageData?&order=id%2Cdesc&page=$page&groupId=${groupCategoryValue ?? categoryValue}&categoryId=$subcategoryValue&tags=$tagValue&str=$searchString&minPrice=$minPrice&maxPrice=$maxPrice&brandId=${homeBrandValue ?? brandValue}&colour=$colorValue");
    print(resAllShopPage.statusCode);
    if (resAllShopPage.statusCode == 200) {
      print("resAllShopPage.statusCode");
      print(resAllShopPage);
      var body = json.decode(resAllShopPage.body);
      var listdata = store.state.shopPageState;
      listdata.addAll(body['products']['data']);

      setState(() {
        store.dispatch(ShopPageAction(listdata));
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
                  store.state.shopPageState.length,
                  (index) {
                    return AllProductCard(
                      id: store.state.shopPageState[index]['id'],
                      imagePath: store.state.shopPageState[index]
                          ['productImage'],
                      categoryName: store.state.shopPageState[index]
                          ['allcategory']['catName'],
                      productName: store.state.shopPageState[index]
                          ['productName'],
                      appDiscount: store.state.shopPageState[index]
                          ['appDiscount'],
                      price: store.state.shopPageState[index]['sellingPrice']
                          .toString(),
                      discountPrice:
                          store.state.shopPageState[index]['appDiscount'] > 0
                              ? (store.state.shopPageState[index]
                                          ['sellingPrice'] -
                                      (store.state.shopPageState[index]
                                                  ['sellingPrice'] *
                                              store.state.shopPageState[index]
                                                  ['appDiscount']) /
                                          100)
                                  .toString()
                              : "0",
                      ratingStar:
                          store.state.shopPageState[index]['avgRating'] == null
                              ? 0
                              : store.state.shopPageState[index]['avgRating']
                                  ['averageRating'],
                    );
                    // here by default width and height is 0
                  },
                ),
              ]);
  }
}
