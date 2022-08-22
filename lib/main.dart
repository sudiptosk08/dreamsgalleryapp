// @dart=2.9
import 'package:dream_gallary/myhomepage.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dream_gallary/redux/reducer.dart';
import 'package:dream_gallary/redux/state.dart';
import 'package:redux/redux.dart';


final store = Store<AppState>(reducer,
    initialState: AppState(
      isLoadingState: true,
      mainSliderState: [],
      groupProductState: [],
      brandProductState: [],
      featureProductState: [],
      //promotionalCardState: [],
      latestProductState: [],
      discountState: [],
      shopPageState: [],
      brandState: [],
      colorState: [],
      categoryState: [],
      subcategoryState: [],
      tagState: [],
      filterBrand: null,
      filterColor: null,
      filterCategory: null,
      filterSubcategory: null,
      filterMaxPrice: null,
      filterMinPrice: null,
      filterTag: null,
      groupCategoryState: null,
      singleProductColor: [],
      singleProductSize: [],
      singleProductRating: [],
      relatedProductState: [],
      productReviewState: [],
      singleProductInformationState: [],
      singleProductIdState: null,
      userDataState: [],
      newUserDataState: null,
      userContactState: null,
      districtState: [],
      zoneState: [],
      areaState: [],
      districtName: null,
      areaName: null,
      zoneName: null,
      notificationState: [],
      myOrderState: [],
      preOrderDataState: [],
      wishListState: [],
      wishListItem: [],
      reportState: [],
      homeBrandState: [],
      categoryIndex: null,
      resetPasswordContactState: null,
      resetPasswordTokenState: null,
      statusState: null,
      preOrderCartState: [],
      userBalanceState: [],
      reportImageState: [],
      getVariableProductState: null,
      getVariableProductLogout: null,
      cartDataState: [],
      cartProductState: [],
      subTotalState: null,
      darkModeState: null,
      logoutUserData: null,
      cartGetState: [],
      ratingState: null,
      userState: null,
      dateState: null,
      textDescriptionState: null,
      cartDataLogoutState: [],
      canceledOrderState: [],
      salePageState: [],
      allImageState: [],
      giftVoucherState: null,
      referralCodeState: null,
      promoCodeState: null,
      userProfilePic: [],
      floatingActionButton: null,
    ));
 


void main() {
  WidgetsFlutterBinding.ensureInitialized();
 
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return RefreshConfiguration(
            headerBuilder: () => WaterDropHeader(),
            // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
            footerBuilder: () => ClassicFooter(),
            // Configure default bottom indicator
            headerTriggerDistance: 80.0,
            // header trigger refresh trigger distance
            //springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // custom spring back animate,the props meaning see the flutter api
            maxOverScrollExtent: 100,
            //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
            maxUnderScrollExtent: 0,
            // Maximum dragging range at the bottom
            enableScrollWhenRefreshCompleted: true,
            //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
            enableLoadingWhenFailed: true,
            //In the case of load failure, users can still trigger more loads by gesture pull-up.
            hideFooterWhenNotFull: false,
            // Disable pull-up to load more functionality when Viewport is less than one screen
            enableBallisticLoad: true,
            // trigger load more by BallisticScrollActivity
            child: OverlaySupport(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                home: MyHomePage(),
              ),
            ));
      });
    });
  }
}
