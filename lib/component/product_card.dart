import 'package:dream_gallary/screen/pro_details/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:dream_gallary/constant.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../k_text_style.dart';
import '../main.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 45,
    this.aspectRatio = 1.02,
    required this.imagePath,
    required this.productName,
    //required this.discount,
    required this.appDiscount,
    required this.price,
    required this.discountPrice,
    required this.categoryName,
    required this.id,
    required this.ratingStar,
  }) : super(key: key);

  final double width, aspectRatio;
  //final int discount;
  final int appDiscount;
  final String imagePath;
  final String productName;
  final String price;
  final String discountPrice;
  final String categoryName;
  final String id;
  final int ratingStar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(2.7 * SizeConfig.imageSizeMultiplier, 1.2,
          2.7 * SizeConfig.imageSizeMultiplier, 0),
      child: SizedBox(
        width: SizeConfig.imageSizeMultiplier * (width),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(
                    id: int.parse(id),
                    title: categoryName,
                    name: productName,
                    img: imagePath,
                    price:int.parse(price) ,
                    appDiscount: appDiscount,
                    discountPrice: int.parse(discountPrice),
                    ratingStar: ratingStar.toInt(),
                  ),
                ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    margin: EdgeInsets.only(right: 1.2),
                    decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: NetworkImage(imagePath),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 1.8 * SizeConfig.imageSizeMultiplier),
                        child: Container(
                          width: 20 * SizeConfig.imageSizeMultiplier,
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
                      Padding(
                        padding: EdgeInsets.only(
                            right: 1.5 * SizeConfig.imageSizeMultiplier),
                        child: SmoothStarRating(
                          size: 11,
                          borderColor: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.grey[600]
                              : Colors.grey[400],
                          color: Colors.yellow[600],
                          allowHalfRating: false,
                          rating: ratingStar.toDouble(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 1.7 * SizeConfig.imageSizeMultiplier),
                    child: Text(
                      productName,
                      maxLines: 2,
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: appDiscount > 0 ? 0 : 3.2),
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
}
