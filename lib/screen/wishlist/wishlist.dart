import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/home_screen/home_screen.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/pro_details/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constant.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final key = GlobalKey();
  void initState() {
    _getAllWishList();
    super.initState();
  }

  Future<void> _getAllWishList() async {
    setState(() {
      store.dispatch(IsLoadingAction(true));
    });
    var res = await CallApi().getData('/app/wishList');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    setState(() {
      store.state.wishListState = body['wishlist']['data'];
      store.dispatch(WishListAction(store.state.wishListState));
    });
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("Back button press");
        return await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
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
            "Wishlist",
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
                store.state.promoCodeState = null;
                store.state.referralCodeState = null;
                store.state.giftVoucherState = null;
                store.state.logoutUserData = null;
              }),
          centerTitle: true,
        ),
        body: store.state.isLoadingState == true
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[350],
                ))
            : store.state.wishListState.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/wishlistbox.png",
                            height: 25 * SizeConfig.imageSizeMultiplier,
                            width: 35 * SizeConfig.imageSizeMultiplier,
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.grey
                                : Colors.grey[700],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Your Wishlist is Empty!",
                            style: KTextStyle.bodyText3.copyWith(
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            "Tap heart button to start saving your favorite item.",
                            style: KTextStyle.bodyText3.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.grey
                                  : Colors.grey[700],
                            ),
                          )
                        ]),
                  )
                : ListView.builder(
                    key: key,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: store.state.wishListState.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailPage(
                                id: store
                                    .state.wishListState[index]['product']['id']
                                    ,
                                title: store.state.wishListState[index]
                                    ['product']['allcategory']['catName'],
                                name: store.state.wishListState[index]
                                    ['product']['productName'],
                                img: store.state.wishListState[index]['product']
                                    ['productImage'],
                                price: store
                                    .state
                                    .wishListState[index]['product']
                                        ['sellingPrice']
                                    ,
                                appDiscount: store.state.wishListState[index]
                                    ['product']['appDiscount'],
                                discountPrice: (store.state.wishListState[index]
                                            ['product']['sellingPrice'] -
                                        (store.state.wishListState[index]
                                                        ['product']
                                                    ['sellingPrice'] *
                                                store.state.wishListState[index]
                                                        ['product']
                                                    ['appDiscount']) /
                                            100)
                                   ,
                                ratingStar: store.state.wishListState[index]
                                            ['product']['avgRating'] ==
                                        null
                                    ? 0
                                    : store.state.wishListState[index]
                                            ['product']['avgRating']
                                        ['averageRating'],
                              ),
                            ));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.05 * SizeConfig.imageSizeMultiplier),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 2 * SizeConfig.imageSizeMultiplier),
                          height: 28 * SizeConfig.imageSizeMultiplier,
                          width: double.infinity,
                          color: kSecondaryColor.withOpacity(0.1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 2 * SizeConfig.imageSizeMultiplier,
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
                                            store.state.wishListState[index]
                                                ['product']['productImage'],
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 4 * SizeConfig.imageSizeMultiplier),
                              Container(
                                width: 55 * SizeConfig.imageSizeMultiplier,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          2.6 * SizeConfig.imageSizeMultiplier,
                                    ),
                                    Text(
                                      store.state.wishListState[index]
                                          ['product']['productName'],
                                      style: KTextStyle.bodyText4.copyWith(
                                        color: store.state.darkModeState ==
                                                    false ||
                                                store.state.darkModeState ==
                                                    null
                                            ? Colors.black
                                            : Colors.grey[400],
                                      ),
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                        height: 1.3 *
                                            SizeConfig.imageSizeMultiplier),
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            "\৳${store.state.wishListState[index]['product']['sellingPrice']}",
                                        style: KTextStyle.bodyText3.copyWith(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: 1.3 *
                                            SizeConfig.imageSizeMultiplier),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: 2.3 * SizeConfig.imageSizeMultiplier),
                              IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.trashAlt,
                                ),
                                color: Colors.red,
                                iconSize: 4 * SizeConfig.imageSizeMultiplier,
                                onPressed: () {
                                  _deleteWishListItem(index);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Future<void> _deleteWishListItem(int index) async {
    var data = {
      'id': store.state.wishListState[index]['id'],
    };
    setState(() {
      store.dispatch(IsLoadingAction(true));
    });

    var res = await CallApi().postData(data, '/app/deleteWishlist');

    var body = json.decode(res.body);
    print('deletebody - $body');
    print('res.statusCode  - ${res.statusCode}');

    if (res.statusCode == 200 && body['success'] == true) {
      print('Array Length');
      print(index);
      print(store.state.wishListState.length);
      setState(() {
        store.state.wishListState.removeAt(index);
        store.dispatch(WishListAction(store.state.wishListState));
        store.dispatch(IsLoadingAction(false));
      });
      print('Array Length');
      print(store.state.wishListState.length);

      _showMsg("Product deleted from wishlist!", 1);
    } else {
      _showMsg(body['message'], 1);
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
