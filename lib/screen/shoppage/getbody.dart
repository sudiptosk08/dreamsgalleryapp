import 'package:dream_gallary/component/all_pcategory_card.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../size_config.dart';
class GetBody extends StatefulWidget {
  @override
  _GetBodyState createState() => _GetBodyState();
}

class _GetBodyState extends State<GetBody> {
  GlobalKey _contentKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
     return store.state.isLoadingState == false ? Container(
         child: CircularProgressIndicator()) : Wrap(
        spacing: 1.3 * SizeConfig.imageSizeMultiplier,
        key: _contentKey,
        children: [
          ...List.generate(
            store.state.shopPageState.length,
                (index) {
              return AllProductCard(
                id: store.state.shopPageState[index]['id'],
                imagePath: store.state.shopPageState[index]['productImage'],
                categoryName: store.state.shopPageState[index]['allcategory']
                ['catName'],
                productName: store.state.shopPageState[index]['productName'],
                appDiscount: store.state.shopPageState[index]['appDiscount'],
                price:
                store.state.shopPageState[index]['sellingPrice'].toString(),
                discountPrice: (store.state.shopPageState[index]
                ['sellingPrice'] -
                    (store.state.shopPageState[index]['sellingPrice'] *
                        store.state.shopPageState[index]['appDiscount']) /
                        100)
                    .toString(),
                ratingStar: store.state.shopPageState[index]['avgRating'] == null?
               0 :  store.state.shopPageState[index]['avgRating']['averageRating'],
              );
              // here by default width and height is 0
            },
          ),
        ]
    );
  }
}
