import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/screen/shoppage/shopPage_screen.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:dream_gallary/constant.dart';
import '../main.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 71 * SizeConfig.imageSizeMultiplier,
      decoration: BoxDecoration(
        color: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? kSecondaryColor.withOpacity(0.1)
            : Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        readOnly: true,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShopPageProduct(
                        groupCategoryValue: null,
                      )));
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
              vertical: 3.1 * SizeConfig.imageSizeMultiplier),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: 'What would you like to buy?',
          hintStyle: KTextStyle.overline.copyWith(
            color: store.state.darkModeState == false ||
                    store.state.darkModeState == null
                ? Colors.grey
                : Colors.grey,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: store.state.darkModeState == false ||
                    store.state.darkModeState == null
                ? Colors.grey
                : Colors.grey[350],
          ),
        ),
      ),
    );
  }
}
