
import 'package:dream_gallary/main.dart';
import 'package:dream_gallary/screen/shoppage/shopPage_screen.dart';
import 'package:flutter/material.dart';
import 'package:dream_gallary/component/product_card.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:shimmer/shimmer.dart';
import 'section_title.dart';

class LeatestProduct extends StatefulWidget {
  @override
  _LeatestProductState createState() => _LeatestProductState();
}

class _LeatestProductState extends State<LeatestProduct> {

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 2 * SizeConfig.imageSizeMultiplier),
            child: SectionTitle(title: "Latest Products", press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShopPageProduct(groupCategoryValue: null,)));
            }),
          ),
          SizedBox(height: 2.8 * SizeConfig.imageSizeMultiplier),
          store.state.isLoadingState == true ? Shimmer.fromColors(
            child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        padding:  EdgeInsets.fromLTRB(2, 0, 2, 0),
                        margin: EdgeInsets.only(right: 1.2),
                        width: 43* SizeConfig.imageSizeMultiplier,
                        height: 42 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.all(Radius.circular(20),
                          ),
                        ),),
                      Padding(padding: EdgeInsets.all(0.5* SizeConfig.imageSizeMultiplier)),
                      Container(
                        margin: EdgeInsets.only(right: 1.2),
                        height: 2.5* SizeConfig.imageSizeMultiplier,
                        width: 40* SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[350],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(0.5* SizeConfig.imageSizeMultiplier)),
                      Container(
                        margin: EdgeInsets.only(right: 1.2),
                        height: 2.5* SizeConfig.imageSizeMultiplier,
                        width: 40* SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[350],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(0.5* SizeConfig.imageSizeMultiplier)),
                      Container(
                        margin: EdgeInsets.only(right: 1.2),
                        height: 2.5* SizeConfig.imageSizeMultiplier,
                        width: 40* SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 1.2),
                        width: 43* SizeConfig.imageSizeMultiplier,
                        height: 42 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          color:Colors.grey[350],
                          borderRadius: BorderRadius.all(Radius.circular(20),
                          ),
                        ),),
                      Padding(padding: EdgeInsets.all(0.5* SizeConfig.imageSizeMultiplier)),
                      Container(
                        height: 2.5* SizeConfig.imageSizeMultiplier,
                        width: 40* SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Colors.grey[350]
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(0.5* SizeConfig.imageSizeMultiplier)),
                      Container(
                        height: 2.5* SizeConfig.imageSizeMultiplier,
                        width: 40* SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[350],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(0.5* SizeConfig.imageSizeMultiplier)),
                      Container(
                        height: 2.5* SizeConfig.imageSizeMultiplier,
                        width: 40* SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.grey[350],
                        ),

                      ),
                    ],
                  )
                ]
            ),
            baseColor: Colors.grey[350]!,
            highlightColor: Colors.white,
            period: Duration(seconds: 4),
          ):SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  store.state.latestProductState.length,
                      (index) {
                    return ProductCard(
                      id:store.state.latestProductState[index]['id'].toString() ,
                      imagePath: store.state.latestProductState[index]['productImage'],
                      productName: store.state.latestProductState[index]['productName'],
                      price: store.state.latestProductState[index]['sellingPrice'].toString(),
                      categoryName: store.state.latestProductState[index]['allcategory']['catName'],
                      //discount: store.state.latestProductState[index]['discount'],
                      appDiscount: store.state.latestProductState[index]['appDiscount'],
                      ratingStar: store.state.latestProductState[index]['avgRating'] == null ? 0 :store.state.latestProductState[index]['avgRating']['averageRating'],
                      discountPrice:
                      store.state.latestProductState[index]['appDiscount'] > 0?
                      (store.state.latestProductState[index]['sellingPrice']-(
                          store.state.latestProductState[index]['sellingPrice']*store.state.latestProductState[index]['appDiscount'])/100).toString():
                      "0",

                    );
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

  