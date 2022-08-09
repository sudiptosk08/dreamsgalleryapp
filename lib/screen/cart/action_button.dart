import 'dart:convert';
import 'package:dream_gallary/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../size_config.dart';

class ActionButton extends StatefulWidget {
  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  late int qty ;
  var getQty;
  @override
  void initState() {
    getAddToCart();
    super.initState();
  }
  void getAddToCart(){
    List.generate(store.state.cartProductState.length, (index) =>
    qty = store.state.cartProductState[index]['quantity'],
    );
    print("----------------$qty-----");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7 * SizeConfig.imageSizeMultiplier,
      width: 27 * SizeConfig.imageSizeMultiplier,
      color: Colors.grey[600]!.withOpacity(0.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                if (qty > 1) {
                  setState(()  {
                    qty = --qty;
                    store.state.cartProductState['quantity'] = qty;
                  });
                  SharedPreferences getVariableProductStorage = await SharedPreferences.getInstance();
                  getVariableProductStorage.setString('variableProductData',json.encode(qty));
                  setState(() {
                    qty = json.decode(getVariableProductStorage.getString('variableProductData')!);
                    store.dispatch(CartProductAction(qty));
                    print(store.state.cartProductState);
                  });
                }
              },
              child: Container(
                width: 6 * SizeConfig.imageSizeMultiplier,
                height: 5.95 * SizeConfig.imageSizeMultiplier,
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.black))),
                child: Icon(
                  FontAwesomeIcons.minus,
                  size: 1.7 * SizeConfig.imageSizeMultiplier,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              qty.toString(),
              style: TextStyle(
                  fontSize: 2 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  qty = ++qty;
                });
                SharedPreferences getVariableProductStorage = await SharedPreferences.getInstance();
                getVariableProductStorage.setString('variableProductData',json.encode(qty));
                setState(() {
                  qty = json.decode(getVariableProductStorage.getString('variableProductData')!);
                  store.dispatch(CartProductAction(qty));
                  print(store.state.cartProductState);
                });
              },
              child: Container(
                height: 5.95 * SizeConfig.imageSizeMultiplier,
                decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.black))),
                width: 6 * SizeConfig.imageSizeMultiplier,
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 1.7 * SizeConfig.imageSizeMultiplier,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
