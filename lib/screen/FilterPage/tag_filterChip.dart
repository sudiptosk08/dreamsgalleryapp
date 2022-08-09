import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';

import '../../k_text_style.dart';
import '../../main.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final int chipId;

  FilterChipWidget({Key? key, required this.chipName, required this.chipId})
      : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: KTextStyle.bodyText4.copyWith(
          color: store.state.darkModeState == null ||
                  store.state.darkModeState == false
              ? _isSelected
                  ? Colors.white
                  : Colors.black
              : _isSelected
                  ? Colors.white
                  : Colors.grey,
          fontWeight: FontWeight.normal),
      selected: _isSelected,
      showCheckmark: false,
      disabledColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
          side: BorderSide(
            color: Colors.grey,
            width: 1.2,
          )),
      padding: EdgeInsets.only(
          left: 2.5 * SizeConfig.imageSizeMultiplier,
          right: 2.5 * SizeConfig.imageSizeMultiplier),
      backgroundColor: store.state.darkModeState == null ||
              store.state.darkModeState == false
          ? Colors.white
          : Colors.grey[900],
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          store.dispatch(FilterTagAction(widget.chipId));
        });
      },
      labelPadding: EdgeInsets.symmetric(horizontal: 7),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      selectedColor: Colors.black,
    );
  }
}
