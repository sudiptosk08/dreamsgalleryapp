import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/FilterPage/tag_filterChip.dart';
import 'package:dream_gallary/screen/shoppage/shopPage_screen.dart';
import 'package:flutter/material.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late int selecttags;
  var brandTitle = store.state.filterBrandName;
  var colorTitle = store.state.filterColor;
  var categoryTitle = store.state.filterCategoryName;
  var subCategoryTitle = store.state.filterSubCategoryName;
  String minText = store.state.filterMinPrice.toString();
  String maxText = store.state.filterMaxPrice.toString();
  //var selectedTag =[];
  var subcategoryArray = [];

  var subcategoryChoose;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == null ||
              store.state.darkModeState == false
          ? Colors.white
          : Color(0xFF0F0E0E),
      appBar: AppBar(
        elevation: 0.6,
        backgroundColor: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.white
            : Colors.grey[900],
        centerTitle: true,
        title: Text(
          "Filter",
          style: KTextStyle.headline5.copyWith(
              color: store.state.darkModeState == null ||
                      store.state.darkModeState == false
                  ? Colors.black
                  : Colors.grey[400],
              letterSpacing: 0.4),
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
              store.state.filterCategory = null;
              store.state.filterMaxPrice = null;
              store.state.filterMinPrice = null;
              store.state.filterTag = null;
              store.state.filterBrand = null;
              store.state.filterColor = null;
              store.state.filterSubcategory = null;
              store.state.filterBrandName = null;
              store.state.filterCategoryName = null;
              store.state.filterSubCategoryName = null;
              setState(() {
                store
                    .dispatch(FilterCategoryAction(store.state.filterCategory));
                store
                    .dispatch(FilterMaxPriceAction(store.state.filterMaxPrice));
                store
                    .dispatch(FilterMinPriceAction(store.state.filterMinPrice));
                store.dispatch(FilterTagAction(store.state.filterTag));
                store.dispatch(FilterBrandAction(store.state.filterBrand));
                store.dispatch(FilterColorAction(store.state.filterColor));
                store.dispatch(
                    FilterSubcategoryAction(store.state.filterSubcategory));
                store.dispatch(
                    FilterBrandNameAction(store.state.filterBrandName));
                store.dispatch(
                    FilterCategoryNameAction(store.state.filterCategoryName));
                store.dispatch(FilterSubCategoryNameAction(
                    store.state.filterSubCategoryName));
              });
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(2.8 * SizeConfig.imageSizeMultiplier),
              child: Text(
                "FILTER BY PRICE",
                style: KTextStyle.subtitle3.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: 13 * SizeConfig.imageSizeMultiplier,
                  width: 34 * SizeConfig.imageSizeMultiplier,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        width: 0.9,
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[800]!,
                      )),
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.8),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: (store.state.filterMinPrice == null)
                            ? 'Minimum'
                            : minText,
                        labelStyle: KTextStyle.bodyText4.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onChanged: (minText) {
                        store
                            .dispatch(FilterMinPriceAction(int.parse(minText)));
                      },
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.horizontal_rule,
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.grey[400],
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: 13 * SizeConfig.imageSizeMultiplier,
                  width: 34 * SizeConfig.imageSizeMultiplier,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        width: 0.9,
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[800]!,
                      )),
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.8),
                    child: TextField(
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: (store.state.filterMaxPrice == null)
                            ? 'Maximum'
                            : maxText,
                        labelStyle: KTextStyle.bodyText4.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onChanged: (maxText) {
                        store
                            .dispatch(FilterMaxPriceAction(int.parse(maxText)));
                      },
                    ),
                  ),
                ),
              ],
            ),

            //Brand
            Padding(
              padding: EdgeInsets.all(2.8 * SizeConfig.imageSizeMultiplier),
              child: Text(
                "BRAND",
                style: KTextStyle.subtitle3.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: 2.8 * SizeConfig.imageSizeMultiplier,
                    right: 2.8 * SizeConfig.imageSizeMultiplier,
                    bottom: 2.0 * SizeConfig.imageSizeMultiplier),
                child: GestureDetector(
                  onTap: () {
                    showCustomBrandDialog(context);
                  },
                  child: Container(
                    height: 14 * SizeConfig.imageSizeMultiplier,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.grey[200]
                          : Colors.grey[900],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            store.state.filterBrandName == null
                                ? 'All'
                                : brandTitle,
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.filterBrandName == null
                                  ? Colors.grey
                                  : Colors.grey,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),

            //Color
            Padding(
              padding: EdgeInsets.all(2.8 * SizeConfig.imageSizeMultiplier),
              child: Text(
                "COLOR",
                style: KTextStyle.subtitle3.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: 2.8 * SizeConfig.imageSizeMultiplier,
                    right: 2.8 * SizeConfig.imageSizeMultiplier,
                    bottom: 2.0 * SizeConfig.imageSizeMultiplier),
                child: GestureDetector(
                  onTap: () {
                    showCustomColorDialog(context);
                  },
                  child: Container(
                    height: 14 * SizeConfig.imageSizeMultiplier,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.grey[200]
                          : Colors.grey[900],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            store.state.filterColor == null
                                ? 'All'
                                : colorTitle,
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.filterColor == null
                                  ? Colors.grey
                                  : Colors.grey,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),

            //Category
            Padding(
              padding: EdgeInsets.all(2.8 * SizeConfig.imageSizeMultiplier),
              child: Text(
                "CATEGORY",
                style: KTextStyle.subtitle3.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: 2.8 * SizeConfig.imageSizeMultiplier,
                    right: 2.8 * SizeConfig.imageSizeMultiplier,
                    bottom: 2.0 * SizeConfig.imageSizeMultiplier),
                child: GestureDetector(
                  onTap: () {
                    showCustomCategoryDialog(context);
                  },
                  child: Container(
                    height: 14 * SizeConfig.imageSizeMultiplier,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.grey[200]
                          : Colors.grey[900],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            store.state.filterCategoryName == null
                                ? 'All'
                                : categoryTitle,
                            style: KTextStyle.bodyText4.copyWith(
                              color: store.state.filterCategoryName == null
                                  ? Colors.grey
                                  : Colors.grey,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),

            //SubCategory
            store.state.filterCategoryName != null
                ? Padding(
                    padding:
                        EdgeInsets.all(2.8 * SizeConfig.imageSizeMultiplier),
                    child: Text(
                      "SUBCATEGORY",
                      style: KTextStyle.subtitle3.copyWith(
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  )
                : Container(),
            store.state.filterCategoryName != null
                ? Padding(
                    padding: EdgeInsets.only(
                        left: 2.8 * SizeConfig.imageSizeMultiplier,
                        right: 2.8 * SizeConfig.imageSizeMultiplier,
                        bottom: 2.0 * SizeConfig.imageSizeMultiplier),
                    child: GestureDetector(
                      onTap: () {
                        showCustomSubCategoryDialog(context);
                      },
                      child: Container(
                        height: 14 * SizeConfig.imageSizeMultiplier,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.grey[200]
                              : Colors.grey[900],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                store.state.filterSubCategoryName == null
                                    ? 'All'
                                    : subCategoryTitle,
                                style: KTextStyle.bodyText4.copyWith(
                                  color:
                                      store.state.filterSubCategoryName == null
                                          ? Colors.grey
                                          : Colors.grey,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                : Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(2.8 * SizeConfig.imageSizeMultiplier),
                  child: Text(
                    "PRODUCTS TAGS",
                    style: KTextStyle.subtitle3.copyWith(
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Wrap(
                              //s: 5.0,
                              //runSpacing: 3.0,
                              spacing: 7,
                              runSpacing: -4,
                              children: List.generate(
                                store.state.tagState.length,
                                (index) => FilterChipWidget(
                                  chipName: store.state.tagState[index]['name'],
                                  chipId: store.state.tagState[index]['id'],
                                ),
                              ).toList()))),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.white
            : Colors.grey[900],
        elevation: 10,
        notchMargin: 5,
        child: Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey[400]!
                      : Colors.grey[800]!,
                  width: 0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _resetEveryFilter();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 10 * SizeConfig.imageSizeMultiplier,
                    width: 45 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.white
                            : Colors.grey[700],
                        border: Border.all(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.grey[900]!,
                          width: 1,
                        )),
                    child: Text(
                      "RESET",
                      textAlign: TextAlign.center,
                      style: KTextStyle.buttonText3.copyWith(
                        color: store.state.darkModeState == null ||
                                store.state.darkModeState == false
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShopPageProduct(
                                groupCategoryValue: null,
                              )));
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 10 * SizeConfig.imageSizeMultiplier,
                    width: 45 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )),
                    child: Text(
                      "APPLY",
                      textAlign: TextAlign.center,
                      style: KTextStyle.buttonText3.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  //Brand
  showCustomBrandDialog(BuildContext context) => showDialog(
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
                      "SELECT BRAND",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  //SizedBox(height: 12),
                  Container(
                      color: Colors.white,
                      height: 400.0, // Change as per your requirement
                      width: 300.0, // Change as per your requirement
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              store.state.brandState.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    brandTitle =
                                        store.state.brandState[index]['name'];
                                    store.dispatch(FilterBrandAction(
                                        store.state.brandState[index]['id']));
                                    store.dispatch(FilterBrandNameAction(
                                        store.state.brandState[index]['name']));
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 12 * SizeConfig.imageSizeMultiplier,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 0.8,
                                      ))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0 *
                                            SizeConfig.imageSizeMultiplier),
                                    child: Text(
                                        store.state.brandState[index]['name']),
                                  ),
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
  //Color
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
                      height: 400.0, // Change as per your requirement
                      width: 300.0, // Change as per your requirement
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              store.state.colorState.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    colorTitle =
                                        store.state.colorState[index]['color'];
                                    store.dispatch(FilterColorAction(store
                                        .state.colorState[index]['color']));
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 12 * SizeConfig.imageSizeMultiplier,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 0.8,
                                      ))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0 *
                                            SizeConfig.imageSizeMultiplier),
                                    child: Text(
                                        store.state.colorState[index]['color']),
                                  ),
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

  //Category
  showCustomCategoryDialog(BuildContext context) => showDialog(
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
                      "SELECT CATEGORY",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 400.0, // Change as per your requirement
                    width: 300.0, // Change as per your requirement
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...List.generate(
                            store.state.categoryState.length,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  categoryTitle = store
                                      .state.categoryState[index]['groupName'];
                                  store.dispatch(FilterCategoryAction(
                                      store.state.categoryState[index]['id']));
                                  store.dispatch(FilterCategoryNameAction(store
                                      .state
                                      .categoryState[index]['groupName']));
                                  store.state.categoryState.indexWhere((e2) =>
                                      categoryTitle == e2["id"].toString());
                                  subcategoryArray = store
                                      .state.categoryState[index]['category'];
                                  //var value = store.state.categoryState[index]['groupName'];
                                  //_selectCategory(value);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 12 * SizeConfig.imageSizeMultiplier,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                      color: Colors.grey[300]!,
                                      width: 0.8,
                                    ))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          5.0 * SizeConfig.imageSizeMultiplier),
                                  child: Text(store.state.categoryState[index]
                                      ['groupName']),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  )
                ]),
          ),
        );
      });

  //SubCategory
  showCustomSubCategoryDialog(BuildContext context) => showDialog(
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
                      "SELECT SUBCATEGORY",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 300.0, // Change as per your requirement
                    width: 300.0, // Change as per your requirement
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...subcategoryArray.map(
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  subCategoryTitle = index['catName'];
                                  store.dispatch(
                                      FilterSubcategoryAction(index['id']));
                                  store.dispatch(FilterSubCategoryNameAction(
                                      index['catName']));
                                });
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 12 * SizeConfig.imageSizeMultiplier,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                      color: Colors.grey[300]!,
                                      width: 0.8,
                                    ))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          5.0 * SizeConfig.imageSizeMultiplier),
                                  child: Text(index['catName']),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  )
                ]),
          ),
        );
      });

  _resetEveryFilter() {
    store.state.filterCategory = null;
    store.state.filterMaxPrice = null;
    store.state.filterMinPrice = null;
    store.state.filterTag = null;
    store.state.filterBrand = null;
    store.state.filterColor = null;
    store.state.filterSubcategory = null;
    store.state.filterBrandName = null;
    store.state.filterCategoryName = null;
    store.state.filterSubCategoryName = null;
    setState(() {
      store.dispatch(FilterCategoryAction(store.state.filterCategory));
      store.dispatch(FilterMaxPriceAction(store.state.filterMaxPrice));
      store.dispatch(FilterMinPriceAction(store.state.filterMinPrice));
      store.dispatch(FilterTagAction(store.state.filterTag));
      store.dispatch(FilterBrandAction(store.state.filterBrand));
      store.dispatch(FilterColorAction(store.state.filterColor));
      store.dispatch(FilterSubcategoryAction(store.state.filterSubcategory));
      store.dispatch(FilterBrandNameAction(store.state.filterBrandName));
      store.dispatch(FilterCategoryNameAction(store.state.filterCategoryName));
      store.dispatch(
          FilterSubCategoryNameAction(store.state.filterSubCategoryName));
    });
    //print('category');
    //     print(store.state.filterCategory);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShopPageProduct(
                  groupCategoryValue: null,
                )));
  }
}
