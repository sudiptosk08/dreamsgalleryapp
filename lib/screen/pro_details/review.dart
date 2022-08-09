// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/component/product_card.dart';
import 'package:dream_gallary/home_screen/section_title.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../constant.dart';
import '../../main.dart';
import '../../size_config.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  TextEditingController description = TextEditingController();
  late int rating;
  void initState() {
    _getProductReview();
    super.initState();
  }

  Future<void> _getProductReview() async {
    var resAllProductReviews = await CallApi().withoutTokengetData(
        '/app/getSingleproduct/${store.state.singleProductIdState}?fbclid=IwAR18lf64fKY198fOlngjhDdAyyFUpXZEhjN0ZNnfMAVRw6VcpyRkwODM_BU');
    print(resAllProductReviews);
    if (resAllProductReviews.statusCode == 200) {
      var body = json.decode(resAllProductReviews.body);
      setState(() {
        store.dispatch(ProductReviewAction(body['reviews']));
      });
      print("store.state.productReviewState");
      print(store.state.productReviewState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  var newIndex;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        store.state.userDataState == null
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        left: 3.0 * SizeConfig.imageSizeMultiplier,
                        right: 2.0 * SizeConfig.imageSizeMultiplier,
                        top: 2.0 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: Text(
                        "Add a review ",
                        style: KTextStyle.subtitle3.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 3.0 * SizeConfig.imageSizeMultiplier,
                        right: 2.0 * SizeConfig.imageSizeMultiplier,
                        top: 2.0 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: Text(
                        "your rating",
                        style: KTextStyle.subtitle4.copyWith(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.black
                                : Colors.grey[400],
                            fontWeight: FontWeight.normal),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 3.0 * SizeConfig.imageSizeMultiplier,
                      right: 2.0 * SizeConfig.imageSizeMultiplier,
                      top: 2.0 * SizeConfig.imageSizeMultiplier,
                    ),
                    child: SmoothStarRating(
                      size: 4.8 * SizeConfig.imageSizeMultiplier,
                      borderColor: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.grey[600]
                          : Colors.grey[400],
                      color: Colors.red[600],
                      allowHalfRating: false,
                      //rating: rating.toDouble(),
                      onRatingChanged: (value) {
                        setState(() {
                          rating = value.toInt();
                        });
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 3.0 * SizeConfig.imageSizeMultiplier,
                        right: 2.0 * SizeConfig.imageSizeMultiplier,
                        top: 2.0 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: Text(
                        "Write your review* ",
                        style: KTextStyle.bodyText4.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 3.0 * SizeConfig.imageSizeMultiplier,
                      right: 3.0 * SizeConfig.imageSizeMultiplier,
                      top: 2.0 * SizeConfig.imageSizeMultiplier,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? kSecondaryColor.withOpacity(0.1)
                            : Colors.grey[900],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextField(
                        controller: description,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        maxLines: 7,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: '  Description',
                          hintStyle: KTextStyle.bodyText4.copyWith(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.grey
                                : Colors.grey[700],
                            fontSize: 3.5 * SizeConfig.imageSizeMultiplier,
                          ),
                        ),
                        style: KTextStyle.bodyText4.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 3.0 * SizeConfig.imageSizeMultiplier,
                      right: 3.0 * SizeConfig.imageSizeMultiplier,
                      top: 1.7 * SizeConfig.imageSizeMultiplier,
                    ),
                    child: FlatButton(
                      height: 9.8 * SizeConfig.imageSizeMultiplier,
                      color: kPrimaryColor,
                      onPressed: () {
                        setState(() {
                          submitHandler();
                          reviewState();
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      child: Text(
                        "Submit",
                        style: KTextStyle.buttonText3.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
        store.state.isLoadingState == true
            ? CircularProgressIndicator()
            : Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: store.state.productReviewState.length,
                  itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.05 * SizeConfig.imageSizeMultiplier),
                      child: ReviewCard(
                        userName: store.state.userState ??
                            store.state.productReviewState[index]['user']
                                ['name'],
                        rating: store.state.ratingState ??
                            store.state.productReviewState[index]['rating'],
                        ratingStar: store.state.ratingState ??
                            store.state.productReviewState[index]['rating'],
                        date: store.state.dateState ??
                            store.state.productReviewState[index]['user']
                                ['updated_at'],
                        reviewText: store.state.textDescriptionState ??
                            store.state.productReviewState[index]['content'],
                      )),
                ),
              ),
        SizedBox(
          height: 14,
        ),
        Container(
          width: double.infinity,
          height: 12 * SizeConfig.imageSizeMultiplier,
          decoration: BoxDecoration(
            color: store.state.darkModeState == null ||
                    store.state.darkModeState == false
                ? kSecondaryColor.withOpacity(0.1)
                : Colors.grey[900],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.0),
                child: Text(
                  "SHARE THIS PRODUCT",
                  style: KTextStyle.bodyText4.copyWith(
                    color: store.state.darkModeState == null ||
                            store.state.darkModeState == false
                        ? Colors.black
                        : Colors.grey[400],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.twitter,
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[400],
                        size: 4.5 * SizeConfig.imageSizeMultiplier,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.facebookF,
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[400],
                        size: 4.5 * SizeConfig.imageSizeMultiplier,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.instagram,
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[400],
                        size: 4.5 * SizeConfig.imageSizeMultiplier,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.googlePlusG,
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[400],
                        size: 4.5 * SizeConfig.imageSizeMultiplier,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.pinterestP,
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[400],
                        size: 4.5 * SizeConfig.imageSizeMultiplier,
                      ),
                      onPressed: () {}),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 14,
        ),
        Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 2 * SizeConfig.imageSizeMultiplier),
            child: SectionTitle(title: "Related Products", press: () {}),
          ),
          SizedBox(
            height: 12,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  store.state.relatedProductState.length,
                  (index) {
                    return ProductCard(
                      id: store.state.relatedProductState[index]['id']
                          .toString(),
                      imagePath: store.state.relatedProductState[index]
                          ['productImage'],
                      categoryName: store.state.relatedProductState[index]
                          ['allcategory']['catName'],
                      productName: store.state.relatedProductState[index]
                          ['productName'],
                      appDiscount: store.state.relatedProductState[index]
                          ['appDiscount'],
                      price: store
                          .state.relatedProductState[index]['sellingPrice']
                          .toString(),
                      ratingStar: 0,
                      discountPrice: (store.state.relatedProductState[index]
                                  ['sellingPrice'] -
                              (store.state.relatedProductState[index]
                                          ['sellingPrice'] *
                                      store.state.relatedProductState[index]
                                          ['appDiscount']) /
                                  100)
                          .toString(),
                    );
                    // here by default width and height is 0
                  },
                ),
              ],
            ),
          )
        ]),
      ],
    );
  }

  Future<void> submitHandler() async {
    if (description.text.isEmpty) {
      _showMsg("Review Comment is empty!", 1);
    }
    if (rating == 0) {
      _showMsg("Rating is empty!", 1);
    }
    var data = {
      'content': description.text,
      'productId': store.state.singleProductIdState,
      'rating': rating,
      'userId': store.state.userDataState['id'],
    };
    print(data);

    var res = await CallApi().postData(data, '/app/reviews');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Success to add your review !", 2);
      description.clear();
    } else {
      _showMsg(body['message'], 1);
    }
  }

  Future<void> reviewState() async {
    var resAllProductReviews = await CallApi().withoutTokengetData(
        '/app/getSingleproduct/${store.state.singleProductIdState}?fbclid=IwAR18lf64fKY198fOlngjhDdAyyFUpXZEhjN0ZNnfMAVRw6VcpyRkwODM_BU');
    print(resAllProductReviews);
    if (resAllProductReviews.statusCode == 200) {
      var body = json.decode(resAllProductReviews.body);
      setState(() {
        store.state.productReviewState.add(body['reviews']);
        store.state.productReviewState.length =
            store.state.productReviewState.length;
        store.dispatch(RatingAction(rating));
        store.dispatch(UserAction(store.state.userDataState['name']));
        store.dispatch(DateAction(DateTime.now().toString()));
        store.dispatch(TextDescriptionAction(description.text));
      });
      print("store.state.productReviewState");
      print(store.state.productReviewState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
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

class ReviewCard extends StatelessWidget {
  final String userName;
  final int rating;
  final int ratingStar;
  final String date;
  final String reviewText;
  const ReviewCard({
    Key? key,
    required this.userName,
    required this.rating,
    required this.ratingStar,
    required this.date,
    required this.reviewText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kSecondaryColor.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.5 * SizeConfig.imageSizeMultiplier,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 2.5 * SizeConfig.imageSizeMultiplier,
                  ),
                  SizedBox(
                    width: 15 * SizeConfig.imageSizeMultiplier,
                    height: 15 * SizeConfig.imageSizeMultiplier,
                    child: AspectRatio(
                      aspectRatio: 0.88,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/User.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4 * SizeConfig.imageSizeMultiplier),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: GoogleFonts.montserrat(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.black
                                : Colors.grey[400],
                            fontSize: 3.5 * SizeConfig.imageSizeMultiplier),
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          SmoothStarRating(
                            size: 4.8 * SizeConfig.imageSizeMultiplier,
                            borderColor: Colors.grey[600],
                            color: Colors.yellow[600],
                            rating: ratingStar.toDouble(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Container(
                  width: 60,
                  height: 16,
                  child: Text(
                    date,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.montserrat(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 3.1 * SizeConfig.imageSizeMultiplier),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 21.6 * SizeConfig.imageSizeMultiplier,
              top: 2.0 * SizeConfig.imageSizeMultiplier,
              bottom: 3.0 * SizeConfig.imageSizeMultiplier,
            ),
            child: Text(
              reviewText,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                color: Colors.grey,
                fontSize: 3.5 * SizeConfig.imageSizeMultiplier,
              ),
            ),
          )
        ],
      ),
    );
  }
}
