import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/home_screen/home_screen.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/profile/body.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void initState() {
    _getPreOrderCart();
    _getAllDistrictApiData();
    super.initState();
  }

  Future<void> _getAllDistrictApiData() async {
    var resAllFilterDistrict =
        await CallApi().withoutTokengetData('/app/zones');
    if (resAllFilterDistrict.statusCode == 200) {
      var body = json.decode(resAllFilterDistrict.body);
      store.dispatch(DistrictAction(body['zones']));
      print("store.state.districtState");
      print(store.state.districtState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  Future<void> _getPreOrderCart() async {
    //var data = store.state.cartDataState;
    var resAllCart = await CallApi().getData('/app/pre-order-cart');
    print(resAllCart);
    if (resAllCart.statusCode == 200) {
      var body = json.decode(resAllCart.body);
      print('body -=-=-=-=--=-=-=-=-= $body');

      store.dispatch(PreOrderCartAction(body['allCarts']));
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false)); //false chilo
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        store.state.logoutUserData = null;
        return await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      },
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
