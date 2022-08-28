import 'dart:convert';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/account/login/login_screen.dart';
import 'package:dream_gallary/screen/pro_details/review.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:tuple/tuple.dart';
import '../../constant.dart';
import '../../main.dart';
import '../../size_config.dart';
import 'description.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;
  final String name;
  final String title;
  final String img;
  final int price;
  final int appDiscount;
  final int discountPrice;

  final int ratingStar;

  const ProductDetailPage({
    Key? key,
    required this.id,
    required this.name,
    required this.title,
    required this.appDiscount,
    required this.img,
    required this.price,
    required this.discountPrice,
    required this.ratingStar,
  });

  @override
  _ProductDetailPageState createState() =>
      _ProductDetailPageState(ratingStar); //
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  final List<Tuple2> _pages = [
    Tuple2('Description', Description()),
    Tuple2('Report', Review()),
  ];
  late TabController _tabController;
  final int ratingStar;

  _ProductDetailPageState(this.ratingStar);
  var getSingleProductColor;
  var getSingleProductSize;
  int mproductId = 0;

  @override
  void initState() {
    _getSingleProductColor();
    _getSingleProductSize();
    _getProductReview();
    _getProductId();
    _getProductRating();
    _getVariableProduct();
    _getAllImages();
    _getCart();
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
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
        List.generate(
            store.state.cartDataState.length,
            (index) =>
                mproductId = store.state.cartDataState[index]['mproductId']);
      });
    } else {
      print("hello");
    }
    
  }

  Future<void> _getVariableProduct() async {
    print('on select button ');

    var data = {
      'colour': selectColor,
      'mproductId': widget.id, //Controller.text
      'quantity': qty,
      'size': selectSize,
    };
    print(data);

    var res = await CallApi().postData(data, '/app/getVariableProduct');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      setState(() {
        var details = body['finalProduct'];
        details['img'] = widget.img;
        details['quantity'] = qty;
        listQty = details['quantity'];
        details['appDiscount'] = widget.appDiscount;
        store.dispatch(GetVariableProductAction(body['finalProduct']));
      });
    } else {
      _showMsg(body['message'], 1);
    }
  }

  Future<void> _getSingleProductColor() async {
    var resAllSingleProductColor = await CallApi().withoutTokengetData(
        '/app/getSingleproduct/${widget.id}?isApp=1&fbclid=IwAR3J4_rpYjVBjv9DowW6ksN3uCyRbIo3gPO4h2eS-POH54TlXdhkTycfSPU');
    print(resAllSingleProductColor);
    if (resAllSingleProductColor.statusCode == 200) {
      var body = json.decode(resAllSingleProductColor.body);
      setState(() {
        store.dispatch(SingleProductColorAction(body['colour']));
      });
      print("store.state.singleProductColor");
      print(store.state.singleProductColor);
    } else {
      print("hello");
    }
   
    List.generate(
        store.state.singleProductColor.length,
        (index) => getSingleProductColor =
            store.state.singleProductColor[index]['color']);
  }

  Future<void> _getSingleProductSize() async {
    var resAllSingleProductSize = await CallApi().withoutTokengetData(
        '/app/getSingleproduct/${widget.id}?isApp=1&fbclid=IwAR3J4_rpYjVBjv9DowW6ksN3uCyRbIo3gPO4h2eS-POH54TlXdhkTycfSPU');
    print(resAllSingleProductSize);
    if (resAllSingleProductSize.statusCode == 200) {
      var body = json.decode(resAllSingleProductSize.body);
      setState(() {
        store.dispatch(SingleProductSizeAction(body['size']));
      });
      print("store.state.singleProductSize");
      print(store.state.singleProductSize);
    } else {
      print("hello");
    }
    
    List.generate(
        store.state.singleProductSize.length,
        (index) => getSingleProductSize =
            store.state.singleProductSize[index]['size']);
  }

  Future<void> _getProductReview() async {
    var resAllProductReview = await CallApi().withoutTokengetData(
        '/app/reviews/${widget.id}?fbclid=IwAR3xSsYr4FPei9wSqeaFNrL483RkVElyP9mwIaprsS2Uy1OcEJkdmkoTPaU');
    print(resAllProductReview);
    if (resAllProductReview.statusCode == 200) {
      var body = json.decode(resAllProductReview.body);
      setState(() {
        store.dispatch(ProductReviewAction(body['reviews']));
      });
      print("store.state.productReviewState");
      print(store.state.productReviewState);
    } else {
      print("hello");
    }
   
  }

  Future<void> _getProductId() async {
    setState(() {
      store.dispatch(SingleProductIdAction(widget.id));
    });
    print("store.state.singleProductState");
    print(store.state.singleProductIdState);
  }

  Future<void> _getProductRating() async {
    var resAllProductRating = await CallApi().withoutTokengetData(
        '/app/getSingleproduct/${widget.id}?fbclid=IwAR18lf64fKY198fOlngjhDdAyyFUpXZEhjN0ZNnfMAVRw6VcpyRkwODM_BU');
    print(resAllProductRating);
    if (resAllProductRating.statusCode == 200) {
      var body = json.decode(resAllProductRating.body);
      setState(() {
        store.dispatch(SingleProductRatingAction(body['product']));
      });
      print("store.state.singleProductRating");
      print(store.state.singleProductRating);
    } else {
      print("hello");
    }
   
  }

  Future<void> _getAllImages() async {
    var resAllProductRating = await CallApi().withoutTokengetData(
        '/app/getSingleproduct/${widget.id}?fbclid=IwAR18lf64fKY198fOlngjhDdAyyFUpXZEhjN0ZNnfMAVRw6VcpyRkwODM_BU');
    print(resAllProductRating);
    if (resAllProductRating.statusCode == 200) {
      var body = json.decode(resAllProductRating.body);
      setState(() {
        store.dispatch(AllImageAction(body['product']['allImages']));
      });
      print("store.state.allImageState");
      print(store.state.allImageState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
    List.generate(store.state.allImageState.length, (index) => index = index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  var colorTitle = "All";
  var sizeTitle = "All";
  var selectColor = "";
  var selectSize = "";
  int qty = 1;
  var id;
  var listQty;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return store.state.isLoadingState == false
        ? WillPopScope(
            onWillPop: () async {
              print("Back button press");
              store.state.ratingState = null;
              store.state.userState = null;
              store.state.dateState = null;
              store.state.textDescriptionState = null;
              store.state.singleProductIdState = null;
              store.state.allImageState = [];
              id = null;
              store.state.cartDataState = [];
              return Navigator.canPop(context);
            },
            child: Scaffold(
              backgroundColor: store.state.darkModeState == null ||
                      store.state.darkModeState == false
                  ? Colors.white
                  : Color(0xFF0F0E0E),
              body: SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverToBoxAdapter(
                        child: ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: [
                              Hero(
                                tag: widget.id.toString(),
                                child: Container(
                                  key: UniqueKey(),
                                  height: 50.0 * SizeConfig.heightMultiplier,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Carousel(
                                    boxFit: BoxFit.cover,
                                    images: List.generate(
                                        store.state.allImageState.length,
                                        (index) => Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: NetworkImage(
                                                  "${store.state.allImageState[index]['url']}",
                                                ),
                                                fit: BoxFit.fitWidth,
                                              )),
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20, top: 20),
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          store.state
                                                                  .ratingState =
                                                              null;
                                                          store.state
                                                              .userState = null;
                                                          store.state
                                                              .dateState = null;
                                                          store.state
                                                                  .textDescriptionState =
                                                              null;
                                                          store.state
                                                                  .singleProductIdState =
                                                              null;
                                                          store.state
                                                              .allImageState = [];
                                                          id = null;
                                                          store.state
                                                              .cartDataState = [];
                                                        },
                                                        child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            6.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_back_ios,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ))),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20, top: 20),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          store.state.userDataState ==
                                                                  null
                                                              ? _showMsg(
                                                                  "Please login to add WishList ! ",
                                                                  1)
                                                              : _getAllWishListItem();
                                                        },
                                                        child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.red,
                                                              child: Icon(
                                                                Icons
                                                                    .favorite_border_sharp,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ))),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 90 *
                                                              SizeConfig
                                                                  .imageSizeMultiplier,
                                                          top: 88 *
                                                              SizeConfig
                                                                  .imageSizeMultiplier),
                                                      child: Text.rich(
                                                        TextSpan(
                                                            text:
                                                                '${index + 1}',
                                                            style: KTextStyle
                                                                .bodyText3
                                                                .copyWith(
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    '/${store.state.allImageState.length}',
                                                                style: KTextStyle
                                                                    .bodyText3
                                                                    .copyWith(
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                ),
                                                              ),
                                                            ]),
                                                      )),
                                                ],
                                              ),
                                            )),
                                    borderRadius: true,
                                    dotIncreaseSize:
                                        0.0 * SizeConfig.imageSizeMultiplier,
                                    radius: Radius.circular(12),
                                    dotBgColor: Colors.grey.withOpacity(0.0),
                                    dotSize:
                                        0.0 * SizeConfig.imageSizeMultiplier,
                                    autoplay: false,
                                    animationCurve: Curves.easeInOut,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(1.7 *
                                            SizeConfig.imageSizeMultiplier),
                                        child: Text(
                                          widget.title,
                                          style: KTextStyle.bodyText4.copyWith(
                                            color: store.state.darkModeState ==
                                                        null ||
                                                    store.state.darkModeState ==
                                                        false
                                                ? Colors.grey[600]
                                                : Colors.grey[400],
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1.1 *
                                            SizeConfig.imageSizeMultiplier),
                                        child: SmoothStarRating(
                                          size: 13,
                                          borderColor: store.state
                                                          .darkModeState ==
                                                      null ||
                                                  store.state.darkModeState ==
                                                      false
                                              ? Colors.grey[600]
                                              : Colors.grey[400],
                                          color: Colors.yellow[600],
                                          rating: ratingStar.toDouble(),
                                          allowHalfRating: false,
                                          //isReadOnly: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 1.9 *
                                            SizeConfig.imageSizeMultiplier),
                                    child: Text(
                                      store.state
                                          .singleProductRating["productName"],
                                      style: KTextStyle.bodyText4.copyWith(
                                        color:
                                            store.state.darkModeState == null ||
                                                    store.state.darkModeState ==
                                                        false
                                                ? Colors.black
                                                : Colors.grey[400],
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 1.5 *
                                            SizeConfig.imageSizeMultiplier,
                                        top:
                                            1 * SizeConfig.imageSizeMultiplier),
                                    child: Text.rich(
                                      TextSpan(
                                          text: widget.appDiscount > 0
                                              ? "\৳${widget.discountPrice} "
                                              : null,
                                          style: KTextStyle.bodyText3.copyWith(
                                            color: kPrimaryColor,
                                          ),
                                          children: [
                                            widget.appDiscount > 0
                                                ? TextSpan(
                                                    text: " \৳${widget.price}",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          (widget.appDiscount >
                                                                  0)
                                                              ? Colors.grey[500]
                                                              : kPrimaryColor,
                                                      letterSpacing: 0.4,
                                                      decoration: (widget
                                                                  .appDiscount >
                                                              0)
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                    ))
                                                : TextSpan(
                                                    text: " \৳${widget.price}",
                                                    style: KTextStyle.bodyText3
                                                        .copyWith(
                                                      color:
                                                          (widget.appDiscount >
                                                                  0)
                                                              ? Colors.grey[500]
                                                              : kPrimaryColor,
                                                      letterSpacing: 0.4,
                                                      decoration: (widget
                                                                  .appDiscount >
                                                              0)
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                    ),
                                                  )
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  store.state.singleProductColor.isEmpty
                                      ? SizedBox(
                                          width: 0,
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 2.1 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                  top: 1.1 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                  bottom: 1.7 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                ),
                                                child: Text(
                                                  "Colors",
                                                  style: KTextStyle.subtitle4
                                                      .copyWith(
                                                    color: store.state
                                                                    .darkModeState ==
                                                                null ||
                                                            store.state
                                                                    .darkModeState ==
                                                                false
                                                        ? Colors.grey[800]
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.1 *
                                                          SizeConfig
                                                              .imageSizeMultiplier,
                                                      bottom: 2.0 *
                                                          SizeConfig
                                                              .imageSizeMultiplier),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showCustomColorDialog(
                                                          context); // store.state.singleProductColor.length > 0 ?: null ?
                                                    },
                                                    child: Container(
                                                      height: 12.5 *
                                                          SizeConfig
                                                              .imageSizeMultiplier,
                                                      width: 46.7 *
                                                          SizeConfig
                                                              .imageSizeMultiplier,
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
                                                            ? Colors.grey[200]
                                                            : Colors.grey[900],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                12, 8, 12, 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 34 *
                                                                  SizeConfig
                                                                      .imageSizeMultiplier,
                                                              child: Text(
                                                                colorTitle,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                                ),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_outlined,
                                                              color:
                                                                  Colors.grey,
                                                              size: 20,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ]),
                                  SizedBox(
                                    height: 1 * SizeConfig.imageSizeMultiplier,
                                  ),
                                  store.state.singleProductSize.isEmpty
                                      ? SizedBox(
                                          width: 0,
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.1 *
                                                        SizeConfig
                                                            .imageSizeMultiplier,
                                                    top: 1.1 *
                                                        SizeConfig
                                                            .imageSizeMultiplier,
                                                    bottom: 1.7 *
                                                        SizeConfig
                                                            .imageSizeMultiplier),
                                                child: Text(
                                                  "Size",
                                                  style: KTextStyle.subtitle4
                                                      .copyWith(
                                                    color: store.state
                                                                    .darkModeState ==
                                                                null ||
                                                            store.state
                                                                    .darkModeState ==
                                                                false
                                                        ? Colors.grey[800]
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.1 *
                                                          SizeConfig
                                                              .imageSizeMultiplier,
                                                      right: 1.7 *
                                                          SizeConfig
                                                              .imageSizeMultiplier,
                                                      bottom: 2.0 *
                                                          SizeConfig
                                                              .imageSizeMultiplier),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      // ignore: unnecessary_statements
                                                      showCustomSizeDialog(
                                                          context); // store.state.singleProductSize.length > 0 ? null
                                                    },
                                                    child: Container(
                                                      height: 12.5 *
                                                          SizeConfig
                                                              .imageSizeMultiplier,
                                                      width: 46.9 *
                                                          SizeConfig
                                                              .imageSizeMultiplier,
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
                                                            ? Colors.grey[200]
                                                            : Colors.grey[900],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                12, 8, 12, 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              sizeTitle,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_outlined,
                                                              color:
                                                                  Colors.grey,
                                                              size: 20,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ]),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.imageSizeMultiplier,
                              ),
                              SizedBox(
                                height: 3 * SizeConfig.imageSizeMultiplier,
                              ),
                              Container(
                                width: double.infinity,
                                height: 12 * SizeConfig.imageSizeMultiplier,
                                decoration: BoxDecoration(
                                    color: store.state.darkModeState == null ||
                                            store.state.darkModeState == false
                                        ? kSecondaryColor.withOpacity(0.1)
                                        : Colors.grey[900]),
                                child: TabBar(
                                  controller: _tabController,
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        "Description",
                                        style: KTextStyle.subtitle3.copyWith(
                                          color: store.state.darkModeState ==
                                                      null ||
                                                  store.state.darkModeState ==
                                                      false
                                              ? Colors.black
                                              : Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                    Tab(
                                        child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text: "Review",
                                        style: KTextStyle.subtitle3.copyWith(
                                          color: store.state.darkModeState ==
                                                      null ||
                                                  store.state.darkModeState ==
                                                      false
                                              ? Colors.black
                                              : Colors.grey[400],
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "(${store.state.productReviewState.length})",
                                        style: KTextStyle.subtitle3.copyWith(
                                          color: store.state.darkModeState ==
                                                      null ||
                                                  store.state.darkModeState ==
                                                      false
                                              ? Colors.black
                                              : Colors.grey[400],
                                        ),
                                      ),
                                    ])))
                                  ],
                                  indicatorColor:
                                      store.state.darkModeState == null ||
                                              store.state.darkModeState == false
                                          ? Colors.black
                                          : Colors.grey[400],
                                  indicatorWeight: 5.0,
                                ),
                              ),
                            ]),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: _pages
                        .map<Widget>((Tuple2 page) => page.item2)
                        .toList(),
                  ),
                ),
              ), //getBody(),
              bottomNavigationBar: BottomAppBar(
                color: store.state.darkModeState == null ||
                        store.state.darkModeState == false
                    ? Colors.white
                    : Colors.grey[700],
                child: Container(
                    height: 49.8,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.white
                              : Colors.grey[700]!,
                          width: 0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 13 * SizeConfig.imageSizeMultiplier,
                              width: 50 * SizeConfig.imageSizeMultiplier,
                              color: Colors.grey[600],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (qty > 1) {
                                        setState(() {
                                          qty = --qty;
                                          getVariableProduct();
                                        });
                                      }
                                    },
                                    child: Container(
                                      width:
                                          17 * SizeConfig.imageSizeMultiplier,
                                      child: Icon(
                                        FontAwesomeIcons.minus,
                                        size: 3.5 *
                                            SizeConfig.imageSizeMultiplier,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    qty.toString(),
                                    style: KTextStyle.buttonText3
                                        .copyWith(color: Colors.white),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        qty = ++qty;
                                        getVariableProduct();
                                      });
                                    },
                                    child: Container(
                                      width:
                                          17 * SizeConfig.imageSizeMultiplier,
                                      child: Icon(
                                        FontAwesomeIcons.plus,
                                        size: 3.5 *
                                            SizeConfig.imageSizeMultiplier,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            (store.state.getVariableProductState != null && store.state.userDataState != null)
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        store.state.getVariableProductState[
                                                    'stock'] <
                                                qty
                                            ? preOrder()
                                            : mproductId ==
                                                    store.state
                                                            .getVariableProductState[
                                                        'mproductId']
                                                ? _showMsg(
                                                    "Item already added in cart!",
                                                    1)
                                                : getAddToCart();
                                        store.state.getVariableProductState[
                                                    'stock'] <
                                                qty
                                            ? _showMsg(
                                                "Item added in Pre-Order Cart!",
                                                2)
                                            : mproductId ==
                                                    store.state
                                                            .getVariableProductState[
                                                        'mproductId']
                                                ? _showMsg(
                                                    "Item already added in cart!",
                                                    1)
                                                : cartPost();
                                        addToCartData();
                                      });
                                    },
                                    child: Container(
                                      height:
                                          13 * SizeConfig.imageSizeMultiplier,
                                      width: 49.50 *
                                          SizeConfig.imageSizeMultiplier,
                                      color: Colors.black,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 4 *
                                                SizeConfig.imageSizeMultiplier),
                                        child: Text(
                                          store.state.getVariableProductState[
                                                      'stock'] <
                                                  qty
                                              ? "PRE ORDER"
                                              : "ADD TO CART",
                                          textAlign: TextAlign.center,
                                          style:
                                              KTextStyle.buttonText3.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        store.state.singleProductRating[
                                                    'stock'] ==
                                                0
                                            ? Container()
                                            : getAddToCartLogout();
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => LogInScreen(),
                                        ));
                                      });
                                    },
                                    child: Container(
                                      height:
                                          13 * SizeConfig.imageSizeMultiplier,
                                      width: 49.50 *
                                          SizeConfig.imageSizeMultiplier,
                                      color: Colors.black,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 4 *
                                                SizeConfig.imageSizeMultiplier),
                                        child: Text(
                                          store.state.singleProductRating[
                                                      'stock'] ==
                                                  0
                                              ? "PRE ORDER"
                                              : "ADD TO CART",
                                          textAlign: TextAlign.center,
                                          style:
                                              KTextStyle.buttonText3.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ],
                    )),
              ),
            ))
        : CircularProgressIndicator();
  }

  showCustomSizeDialog(BuildContext context) => showDialog(
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
                      "SELECT SIZE",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  //SizedBox(height: 12),
                  Container(
                      color: Colors.white,
                      height: store.state.singleProductSize.length > 2
                          ? 140.0
                          : 80.0, // Change as per your requirement
                      width: 300.0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              store.state.singleProductSize.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sizeTitle = store
                                        .state.singleProductSize[index]['size'];
                                    selectSize = sizeTitle;
                                    //store.dispatch(FilterColorAction(store.state.colorState[index]['color']));
                                    getVariableProduct();
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 0.8,
                                      ))),
                                  alignment: Alignment.center,
                                  height: 10 * SizeConfig.imageSizeMultiplier,
                                  width: double.infinity,
                                  child: Text(store
                                          .state.singleProductSize[index][
                                      'size']), //store.state.colorState[index]['color']
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
  showCustomColorDialog(BuildContext context) => showDialog(
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
                      "SELECT COLOR",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  //SizedBox(height: 12),
                  Container(
                      color: Colors.white,
                      height: store.state.singleProductColor.length > 2
                          ? 140.0
                          : 80.0, // Change as per your requirement
                      width: 300.0, // Change as per your requirement
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              store.state.singleProductColor.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    colorTitle = store.state
                                        .singleProductColor[index]['color'];
                                    selectColor = colorTitle;
                                    //store.dispatch(FilterColorAction(store.state.colorState[index]['color']));
                                    getVariableProduct();
                                  });

                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 0.8,
                                      ))),

                                  alignment: Alignment.center,
                                  height: 10 * SizeConfig.imageSizeMultiplier,
                                  width: double.infinity,
                                  child: Text(store
                                          .state.singleProductColor[index][
                                      'color']), //store.state.colorState[index]['color']
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

  Future<void> getAddToCart() async {
    List.generate(
      store.state.cartDataState.length,
      (index) => id = store.state.cartDataState[index]['id'],
    );
    var value = store.state.cartDataState;
    if (getSingleProductColor != null && selectColor == "") {
      return _showMsg("Select a Color", 2);
    }
    if (getSingleProductSize != null && selectSize == "") {
      return _showMsg("Select a Size", 2);
    }
    if (store.state.getVariableProductState != null &&
        store.state.getVariableProductState['id'] != id) {
      _showMsg("Item added to cart ", 2);
      value.add(store.state.getVariableProductState);
    } else {
      _showMsg("Item added to cart ", 2);
    }

    print("cartDataState = ${store.state.cartDataState}");
    SharedPreferences getVariableProductStorage =
        await SharedPreferences.getInstance();
    getVariableProductStorage.setString(
        'variableProductData', json.encode(store.state.cartDataState));
  }

  Future<void> getAddToCartLogout() async {
    _showMsg("Login from Add To Cart ", 2);
    var data = {
      'colour': selectColor,
      'mproductId': widget.id, //Controller.text
      'quantity': qty,
      'size': selectSize,
    };
    print("--------------$data----------");
    var value = store.state.cartDataLogoutState;
    var res =
        await CallApi().withoutTokenPostData(data, '/app/getVariableProduct');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      setState(() {
        var details = body['finalProduct'];
        details['img'] = widget.img;
        details['quantity'] = qty;
        print("MproductId == $mproductId");
        print("widget.id == ${widget.id}");
        listQty = details['quantity'];
        details['appDiscount'] = widget.appDiscount;
        //details['discountPrice'] = widget.discountPrice;
        store.dispatch(GetVariableProductAction(body['finalProduct']));
        value.add(store.state.getVariableProductState);
        store.dispatch(LogoutUserAction("CartPage"));
        //cartPostLogout();
      });
    } else {
      _showMsg(body['message'], 1);
    }
    print("cartDataLogoutState = ${store.state.cartDataLogoutState}");
  }

  Future<void> cartPost() async {
    var cartIndex;
    List.generate(
        store.state.cartDataState.length, (index) => cartIndex = index);
    var cartData = {
      'admin_id': store.state.cartDataState[cartIndex]['admin_id'],
      'averageBuyingPrice': store.state.cartDataState[cartIndex]
          ['averageBuyingPrice'],
      'barCode': store.state.cartDataState[cartIndex]['barCode'],
      'brand': store.state.cartDataState[cartIndex]['brand'],
      'brandId': store.state.cartDataState[cartIndex]['brandId'],
      'catName': store.state.cartDataState[cartIndex]['catName'],
      'categoryId': store.state.cartDataState[cartIndex]['categoryId'],
      'color': store.state.cartDataState[cartIndex]['color'],
      'created_at': store.state.cartDataState[cartIndex]['created_at'],
      'date': store.state.cartDataState[cartIndex]['date'],
      'discount': store.state.cartDataState[cartIndex]['discount'],
      'groupId': store.state.cartDataState[cartIndex]['groupId'],
      'groupName': store.state.cartDataState[cartIndex]['groupName'],
      'id': store.state.cartDataState[cartIndex]['id'],
      'img': store.state.cartDataState[cartIndex]['img'],
      'model': store.state.cartDataState[cartIndex]['model'],
      'mproductId': store.state.cartDataState[cartIndex]['mproductId'],
      'openingQuantity': store.state.cartDataState[cartIndex]
          ['openingQuantity'],
      'openingUnitPrice': store.state.cartDataState[cartIndex]
          ['openingUnitPrice'],
      'productImage': store.state.cartDataState[cartIndex]['productImage'],
      'productName': store.state.cartDataState[cartIndex]['productName'],
      'quantity': store.state.cartDataState[cartIndex]['quantity'],
      'sellingPrice': store.state.cartDataState[cartIndex]['sellingPrice'],
      'size': store.state.cartDataState[cartIndex]['size'],
      'stock': store.state.cartDataState[cartIndex]['stock'],
      'unit': store.state.cartDataState[cartIndex]['unit'],
      'updated_at': store.state.cartDataState[cartIndex]['updated_at'],
    };
    print("--------------$cartData----------");

    var cartRes = await CallApi().postData(cartData, '/app/cart');
    var cartBody = json.decode(cartRes.body);
    print('CartPostbody ------------- $cartBody');
    print('res.statusCode  - ${cartRes.statusCode}');
  }

  preOrder() async {
    var preData = {
      'categoryId': store.state.getVariableProductState['groupId'],
      'mproductId': store.state.getVariableProductState['mproductId'],
      'product': {
        'admin_id': store.state.getVariableProductState['admin_id'],
        'averageBuyingPrice':
            store.state.getVariableProductState['averageBuyingPrice'],
        'barCode': store.state.getVariableProductState['barCode'],
        'brand': store.state.getVariableProductState['brand'],
        'brandId': store.state.getVariableProductState['brandId'],
        'catName': store.state.getVariableProductState['catName'],
        'categoryId': store.state.getVariableProductState['categoryId'],
        'color': store.state.getVariableProductState['color'],
        'created_at': store.state.getVariableProductState['created_at'],
        'date': store.state.getVariableProductState['date'],
        'groupId': store.state.getVariableProductState['groupId'],
        'groupName': store.state.getVariableProductState['groupName'],
        'id': store.state.getVariableProductState['id'],
        // 'img': store.state.cartDataState[index]['img'],
        'model': store.state.getVariableProductState['model'],
        'mproductId': store.state.getVariableProductState['mproductId'],
        'openingQuantity':
            store.state.getVariableProductState['openingQuantity'],
        'openingUnitPrice':
            store.state.getVariableProductState['openingUnitPrice'],
        'productImage': store.state.getVariableProductState['productImage'],
        'productName': store.state.getVariableProductState['productName'],
        'sellingPrice': store.state.getVariableProductState['sellingPrice'],
        'size': store.state.getVariableProductState['size'],
        'stock': store.state.getVariableProductState['stock'],
        'unit': store.state.getVariableProductState['unit'],
        'updated_at': store.state.getVariableProductState['updated_at'],
      },
      'productId': store.state.getVariableProductState['id'],
      'subcategoryId': store.state.getVariableProductState['categoryId'],
      'quantity': qty,
    };

    print("============+++++++$preData");

    var res = await CallApi().postData(preData, '/app/pre-order-cart');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
  }

  Future<void> getVariableProduct() async {
    print('on select button ');

    var data = {
      'colour': selectColor,
      'mproductId': widget.id, //Controller.text
      'quantity': qty,
      'size': selectSize,
    };
    print("--------------$data----------");

    var res = await CallApi().postData(data, '/app/getVariableProduct');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      setState(() {
        var details = body['finalProduct'];
        details['img'] = widget.img;
        details['quantity'] = qty;
        listQty = details['quantity'];
        details['discount'] = widget.appDiscount;
        //details['discountPrice'] = widget.discountPrice;
        store.dispatch(GetVariableProductAction(body['finalProduct']));
      });
    } else {
      _showMsg(body['message'], 1);
    }
  }

  Future<void> _getAllWishListItem() async {
    var data = {
      'id': widget.id,
    };
    var res = await CallApi().postData(data, '/app/wishlist');
    var body = json.decode(res.body);
    print('Wishlistbody - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Add To WishList !", 2);
    } else {
      _showMsg("Please login to add WishList ! ", 1);
    }
  }

  Future<void> addToCartData() async {
    //var data = store.state.cartDataState;
    var resAllCart = await CallApi().getData('/app/cart');
    print(resAllCart);
    if (resAllCart.statusCode == 200) {
      var body = json.decode(resAllCart.body);
      print('body -=-=-=-=--=-=-=-=-= $body');
      setState(() {
        store.dispatch(CartGetAction(body['allCarts']));
        List.generate(
            store.state.cartDataState.length,
            (index) =>
                mproductId = store.state.cartDataState[index]['mproductId']);
      });
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false)); //false chilo
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
