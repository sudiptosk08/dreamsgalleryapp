import 'dart:convert';

import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/k_text_style.dart';

import 'package:dream_gallary/screen/pro_details/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dream_gallary/constant.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../main.dart';
import '../size_config.dart';

class AllProductCard extends StatelessWidget {
  const AllProductCard({
    Key? key,
    this.width = 46.6,
    this.aspectRetio = 1.02,
    required this.id,
    required this.appDiscount,
    required this.ratingStar,
    required this.imagePath,
    required this.price,
    required this.categoryName,
    required this.discountPrice,
    required this.productName,
  }) : super(key: key);

  final double width, aspectRetio;
  final int id;
  final int appDiscount;
  final int ratingStar;
  final String imagePath;
  final String productName;
  final String price;
  final String discountPrice;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 2 * SizeConfig.imageSizeMultiplier,
          bottom: 2 * SizeConfig.imageSizeMultiplier),
      width: 46.6 * SizeConfig.imageSizeMultiplier,
      height: 36 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.white
            : Colors.grey[900],
      ),
      child: SizedBox(
        width: SizeConfig.imageSizeMultiplier * (width),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(
                    id: id,
                    title: categoryName,
                    name: productName,
                    img: imagePath,
                    price: int.parse(price),
                    appDiscount: appDiscount,
                    discountPrice: int.parse(discountPrice),
                    ratingStar: ratingStar.toInt(),
                  ),
                ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: id,
                child: Container(
                  height: 25 * SizeConfig.heightMultiplier,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        imagePath,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 15),
                        child: GestureDetector(
                            onTap: () {
                              _getAllWishListItem();
                            },
                            child: Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.favorite_border_sharp,
                                    color: Colors.white,
                                  ),
                                ))),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 27 * SizeConfig.imageSizeMultiplier,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            categoryName,
                            overflow: TextOverflow.ellipsis,
                            style: KTextStyle.bodyText4.copyWith(
                                color: store.state.darkModeState == null ||
                                        store.state.darkModeState == false
                                    ? Colors.grey[600]
                                    : Colors.grey[400],
                                fontSize: 11),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SmoothStarRating(
                        size: 11,
                        borderColor: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.grey[600]
                            : Colors.grey[400],
                        color: Colors.yellow[600],
                        rating: ratingStar.toDouble(),
                        allowHalfRating: false,
                        //isReadOnly: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 3.3),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Text(
                      productName,
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: appDiscount > 0 ? 5 : 0),
                    child: Text.rich(TextSpan(
                        text: appDiscount > 0 ? "\৳$discountPrice " : null,
                        style: KTextStyle.bodyText3.copyWith(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          appDiscount > 0
                              ? TextSpan(
                                  text: " \৳$price",
                                  style: KTextStyle.bodyText3.copyWith(
                                    color: store.state.darkModeState == null ||
                                            store.state.darkModeState == false
                                        ? Colors.grey[700]
                                        : Colors.grey[400],
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                )
                              : TextSpan(
                                  text: " \৳$price",
                                  style: KTextStyle.bodyText3.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor,
                                    letterSpacing: 0.3,
                                  ),
                                )
                        ])),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getAllWishListItem() async {
    var data = {
      'id': id,
    };
    var res = await CallApi().postData(data, '/app/wishlist');
    var body = json.decode(res.body);
    print('Wishlistbody - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Add To WishList !", 2);
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
