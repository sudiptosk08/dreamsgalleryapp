import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/component/product_card.dart';
import 'package:dream_gallary/home_screen/section_title.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constant.dart';
import '../../main.dart';
import '../../size_config.dart';

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  void initState() {
    _getRelatedProduct();
    _getProductInformation();
     _onLoading();
    super.initState();
  }
  bool _loading = false;
  
void _onLoading() {
    setState(() {
      _loading = true;
      new Future.delayed(new Duration(seconds: 2), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  Future<void> _getRelatedProduct() async {
    var resAllRelatedProduct = await CallApi().withoutTokengetData(
        '/app/relatedProduct/${store.state.singleProductIdState}');
    print(resAllRelatedProduct);
    if (resAllRelatedProduct.statusCode == 200) {
      var body = json.decode(resAllRelatedProduct.body);
      setState(() {
        store.dispatch(RelatedProductAction(body['product']));
      });
      print("store.state.relatedProductState");
      print(store.state.relatedProductState);
    } else {
      print("relateproduct");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  Future<void> _getProductInformation() async {
    var resAllProductInformation = await CallApi().withoutTokengetData(
        '/app/getSingleproduct/${store.state.singleProductIdState}?fbclid=IwAR18lf64fKY198fOlngjhDdAyyFUpXZEhjN0ZNnfMAVRw6VcpyRkwODM_BU');
    print(resAllProductInformation);
    if (resAllProductInformation.statusCode == 200) {
      var body = json.decode(resAllProductInformation.body);
      setState(() {
        store.dispatch(SingleProductInformationAction(body['product']));
      });
      print("store.state.singleProductInformationState");
      print(store.state.singleProductInformationState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _loading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: ListView(children: [
                  SizedBox(
                    height: 5 * SizeConfig.imageSizeMultiplier,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 3.5 * SizeConfig.imageSizeMultiplier,
                        right: 3.5 * SizeConfig.imageSizeMultiplier,
                        top: 2.0 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30 * SizeConfig.imageSizeMultiplier,
                              child: Text(
                                "Product Name",
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == null ||
                                          store.state.darkModeState == false
                                      ? Colors.black
                                      : Colors.grey[400],
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              width: 3 * SizeConfig.imageSizeMultiplier,
                              child: Text(
                                ":",
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == null ||
                                          store.state.darkModeState == false
                                      ? Colors.black
                                      : Colors.grey[400],
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              width: 60 * SizeConfig.imageSizeMultiplier,
                              child: Text(
                                "${store.state.singleProductInformationState["productName"]}",
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == null ||
                                          store.state.darkModeState == false
                                      ? Colors.black
                                      : Colors.grey[400],
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )
                          ])),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 3.5 * SizeConfig.imageSizeMultiplier,
                        right: 3.5 * SizeConfig.imageSizeMultiplier,
                        top: 2.0 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: Row(children: [
                        Container(
                          width: 30 * SizeConfig.imageSizeMultiplier,
                          child: Text(
                            "Model",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          width: 3 * SizeConfig.imageSizeMultiplier,
                          child: Text(
                            ":",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${store.state.singleProductInformationState["model"]} ",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ])),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 3.5 * SizeConfig.imageSizeMultiplier,
                        right: 3.5 * SizeConfig.imageSizeMultiplier,
                        top: 2.0 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: Row(children: [
                        Container(
                          width: 30 * SizeConfig.imageSizeMultiplier,
                          child: Text(
                            "Brand",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          width: 3 * SizeConfig.imageSizeMultiplier,
                          child: Text(
                            ":",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${store.state.singleProductInformationState["allbrand"]["name"]}",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ])),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 3.5 * SizeConfig.imageSizeMultiplier,
                        right: 3.5 * SizeConfig.imageSizeMultiplier,
                        top: 2.0 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: Row(children: [
                        Container(
                          width: 30 * SizeConfig.imageSizeMultiplier,
                          child: Text(
                            "Category",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          width: 3 * SizeConfig.imageSizeMultiplier,
                          child: Text(
                            ":",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${store.state.singleProductInformationState["allgroup"]["groupName"]}",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ])),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 3.5 * SizeConfig.imageSizeMultiplier,
                        right: 3.5 * SizeConfig.imageSizeMultiplier,
                        top: 2.0 * SizeConfig.imageSizeMultiplier,
                      ),
                      child: Row(children: [
                        Container(
                          width: 30 * SizeConfig.imageSizeMultiplier,
                          child: Text(
                            "SubCategory",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          width: 3 * SizeConfig.imageSizeMultiplier,
                          child: Text(
                            ":",
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.black
                                  : Colors.grey[400],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          "${store.state.singleProductInformationState["allcategory"]["catName"]}",
                          style: KTextStyle.bodyText4.copyWith(
                            color: store.state.darkModeState == null ||
                                    store.state.darkModeState == false
                                ? Colors.black
                                : Colors.grey[400],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ])),
                  SizedBox(
                    height: 4 * SizeConfig.imageSizeMultiplier,
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
                    height: 5 * SizeConfig.imageSizeMultiplier,
                  ),
                  Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2 * SizeConfig.imageSizeMultiplier),
                      child:
                          SectionTitle(title: "Related Products", press: () {}),
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.imageSizeMultiplier,
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
                                imagePath: store.state
                                    .relatedProductState[index]['productImage'],
                                categoryName:
                                    store.state.relatedProductState[index]
                                        ['allcategory']['catName'],
                                productName: store.state
                                    .relatedProductState[index]['productName'],
                                appDiscount: store.state
                                    .relatedProductState[index]['appDiscount'],
                                price: store.state
                                    .relatedProductState[index]['sellingPrice']
                                    .toString(),
                                ratingStar: 0,
                                discountPrice: (store.state
                                                .relatedProductState[index]
                                            ['sellingPrice'] -
                                        (store.state.relatedProductState[index]
                                                    ['sellingPrice'] *
                                                store.state.relatedProductState[
                                                    index]['appDiscount']) /
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
                ]),
              ));
  }
}
