import 'package:dream_gallary/component/drawer_widget.dart';
import 'package:dream_gallary/component/drawer_widget_logout.dart';
import 'package:dream_gallary/home_screen/brand_categ.dart';
import 'package:dream_gallary/home_screen/discount_previlege.dart';
import 'package:dream_gallary/home_screen/skinCard.dart';
import 'package:flutter/material.dart';
import 'package:dream_gallary/home_screen/home_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'image_Banner.dart';
import 'dart:convert';
import 'package:dream_gallary/home_screen/p_categories.dart';
import 'package:dream_gallary/home_screen/feature_product.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:dream_gallary/home_screen/leatest_product.dart';
import 'package:dream_gallary/home_screen/makeupCard.dart';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/redux/action.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var token;
  var user;

  void initState() {
    _getAllLandingApiData();
    _getAllGroupApiData();
    _getAllBrandApiData();
    _getAllFeatureApiData();
    _getAllLatestApiData();
    _getAllDiscountApiData();
    getCredentials();
    _getAllHomeBrandApiData();

    print('Token');

    super.initState();
  }

  getCredentials() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    user = localStorage.getString('userData');
    print("tokenInfo = $token");
    print("userInfo = $user");
    setState(() {
      store.state.userDataState =
          json.decode(localStorage.getString('userData')!);
      print('.....${store.state.userDataState}');
    });
  }

  Future<void> _getAllLandingApiData() async {
    var resAllSliders = await CallApi().withoutTokengetData('/app/allSliders');
    if (resAllSliders.statusCode == 200) {
      var body = json.decode(resAllSliders.body);
      setState(() {
        store.dispatch(MainSliderAction(body));
      });
      setState(() {
        store.dispatch(IsLoadingAction(false)); //true chilo
      });
    }
  }

  Future<void> _getAllGroupApiData() async {
    var resAllGroups =
        await CallApi().withoutTokengetData('/app/allGroups?limit=6');
    if (resAllGroups.statusCode == 200) {
      var body = json.decode(resAllGroups.body);
      setState(() {
        store.dispatch(GroupProductAction(body['groups']));
      });
    }
    setState(() {
      store.dispatch(IsLoadingAction(false)); //true chilo
    });
  }

  Future<void> _getAllBrandApiData() async {
    var resAllBrand =
        await CallApi().withoutTokengetData('/app/allBrands?limit=6');
    if (resAllBrand.statusCode == 200) {
      var body = json.decode(resAllBrand.body);
      setState(() {
        store.dispatch(BrandProductAction(body['brands']));
      });
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  Future<void> _getAllFeatureApiData() async {
    var resAllFeature =
        await CallApi().withoutTokengetData('/app/featuredProducts');
    if (resAllFeature.statusCode == 200) {
      var body = json.decode(resAllFeature.body);
      store.dispatch(FeatureProductAction(body['f']));
    }

    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  Future<void> _getAllLatestApiData() async {
    var resAllLatest = await CallApi()
        .withoutTokengetData('/app/newProducts'); //app/newProducts
    if (resAllLatest.statusCode == 200) {
      var body = json.decode(resAllLatest.body);
      store.dispatch(LatestProductAction(body['n']));
      setState(() {
        store.dispatch(IsLoadingAction(false));
      });
    } else {
      print("hello");
    }
  }

  Future<void> _getAllDiscountApiData() async {
    var resAllDiscount = await CallApi()
        .withoutTokengetData('/app/restaurants'); //app/newProducts
    if (resAllDiscount.statusCode == 200) {
      var body = json.decode(resAllDiscount.body);
      setState(() {
        store.dispatch(DiscountAction(body['restaurants']));
      });
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  Future<void> _getAllHomeBrandApiData() async {
    var resAllBrand = await CallApi().withoutTokengetData('/app/AllBrands');
    if (resAllBrand.statusCode == 200) {
      var body = json.decode(resAllBrand.body);
      setState(() {
        store.dispatch(HomeBrandAction(body['brands']));
      });
      print("store.state.brandState");
      print(store.state.homeBrandState);
    } else {
      print("hello");
    }
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == false ||
              store.state.darkModeState == null
          ? Colors.white
          : Color(0xFF0F0E0E),
      drawer: token != null ? DrawerWidgetLogIn() : DrawerWidgetLogout(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              icon: Icon(
                Icons.menu_outlined,
              ),
              iconSize: 7 * SizeConfig.imageSizeMultiplier,
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
              onPressed: () => Scaffold.of(context).openDrawer());
        }),
        elevation: 0.0,
        actions: [HomeHeader()],
        backgroundColor: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? Colors.white
            : Color(0xFF0F0E0E),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 1.2 * SizeConfig.heightMultiplier,
              ),
              ImageSlider(),
              SizedBox(
                height: 1.2 * SizeConfig.heightMultiplier,
              ),
              PCategories(),
              SizedBox(
                height: 1.2 * SizeConfig.heightMultiplier,
              ),
              BrandCategory(),
              SizedBox(
                height: 2.5 * SizeConfig.heightMultiplier,
              ),
              FeatureProduct(),
              SizedBox(
                height: 1.2 * SizeConfig.heightMultiplier,
              ),
              SkinCard(),
              SizedBox(
                height: 1.2 * SizeConfig.heightMultiplier,
              ),
              LeatestProduct(),
              SizedBox(
                height: 1.2 * SizeConfig.heightMultiplier,
              ),
              MakeupCard(),
              SizedBox(
                height: 1.2 * SizeConfig.heightMultiplier,
              ),
              DisCountPrivilege(),
              SizedBox(
                height: 2.5 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
