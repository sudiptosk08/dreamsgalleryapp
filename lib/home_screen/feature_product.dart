import 'package:dream_gallary/screen/shoppage/shopPage_screen.dart';
import 'package:flutter/material.dart';
import 'package:dream_gallary/component/product_card.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:shimmer/shimmer.dart';
import '../main.dart';
import 'section_title.dart';

class FeatureProduct extends StatefulWidget {
  @override
  _FeatureProductState createState() => _FeatureProductState();
}

class _FeatureProductState extends State<FeatureProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 2 * SizeConfig.imageSizeMultiplier),
          child: SectionTitle(
              title: "Feature Products",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShopPageProduct(
                              groupCategoryValue: null,
                            )));
              }),
        ),
        SizedBox(height: 2.8 * SizeConfig.imageSizeMultiplier),
        store.state.isLoadingState == true
            ? Shimmer.fromColors(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                            margin: EdgeInsets.only(right: 1.2),
                            width: 43 * SizeConfig.imageSizeMultiplier,
                            height: 42 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  0.5 * SizeConfig.imageSizeMultiplier)),
                          Container(
                            margin: EdgeInsets.only(right: 1.2),
                            height: 2.5 * SizeConfig.imageSizeMultiplier,
                            width: 40 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              color: Colors.grey[350],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  0.5 * SizeConfig.imageSizeMultiplier)),
                          Container(
                            margin: EdgeInsets.only(right: 1.2),
                            height: 2.5 * SizeConfig.imageSizeMultiplier,
                            width: 40 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              color: Colors.grey[350],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  0.5 * SizeConfig.imageSizeMultiplier)),
                          Container(
                            margin: EdgeInsets.only(right: 1.2),
                            height: 2.5 * SizeConfig.imageSizeMultiplier,
                            width: 40 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              color: Colors.grey[350],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 1.2),
                            width: 43 * SizeConfig.imageSizeMultiplier,
                            height: 42 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  0.5 * SizeConfig.imageSizeMultiplier)),
                          Container(
                            height: 2.5 * SizeConfig.imageSizeMultiplier,
                            width: 40 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                color: Colors.grey[350]),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  0.5 * SizeConfig.imageSizeMultiplier)),
                          Container(
                            height: 2.5 * SizeConfig.imageSizeMultiplier,
                            width: 40 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              color: Colors.grey[350],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  0.5 * SizeConfig.imageSizeMultiplier)),
                          Container(
                            height: 2.5 * SizeConfig.imageSizeMultiplier,
                            width: 40 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                              color: Colors.grey[350],
                            ),
                          ),
                        ],
                      )
                    ]),
                baseColor: Colors.grey[350]!,
                highlightColor: Colors.white,
                period: Duration(seconds: 4),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      store.state.featureProductState.length,
                      (index) {
                        return ProductCard(
                            id: store.state.featureProductState[index]['id']
                                .toString(),
                            imagePath: store.state.featureProductState[index]
                                ['productImage'],
                            categoryName: store.state.featureProductState[index]
                                ['allcategory']['catName'],
                            productName: store.state.featureProductState[index]
                                ['productName'],
                            //discount: store.state.featureProductState[index]['discount'],
                            appDiscount: store.state.featureProductState[index]
                                ['appDiscount'],
                            price: store.state.featureProductState[index]['sellingPrice']
                                .toString(),
                            ratingStar: store.state.featureProductState[index]['avgRating'] == null
                                ? 0
                                : store.state.featureProductState[index]
                                    ['avgRating']['averageRating'],
                            discountPrice: store.state.featureProductState[index]['appDiscount'] > 0
                                ? (store.state.featureProductState[index]
                                            ['sellingPrice'] -
                                        (store.state.featureProductState[index]['sellingPrice'] * store.state.featureProductState[index]['appDiscount']) / 100)
                                    .toString()
                                : "0");
                        // here by default width and height is 0
                      },
                    ),
                  ],
                ),
              )
      ],
    );
  }
}
