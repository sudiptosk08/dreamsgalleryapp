class AppState {
  var isLoadingState;
  var mainSliderState;
  var groupProductState;
  var brandProductState;
  var featureProductState;
  var promotionalSkinCardState;
  var promotionalMakeupCardState;
  var latestProductState;
  var discountState;
  var shopPageState;
  var brandState;
  var colorState;
  var categoryState;
  var subcategoryState;
  var tagState;

  ///var filterShopState;
  var filterBrand;
  var filterColor;
  var filterCategory;
  var filterSubcategory;
  var filterMaxPrice;
  var filterMinPrice;
  var filterTag;
  var filterHomeBrand;

  var filterBrandName;
  var filterCategoryName;
  var filterSubCategoryName;

  ///singleProductpage
  var singleProductColor;
  var singleProductSize;
  var singleProductRating;

  var relatedProductState;

  var productReviewState;

  var singleProductIdState;
  var singleProductInformationState;

  var groupCategoryState;

  /// user State
  var userDataState;
  var newUserDataState;
  var userContactState;

  var districtState;
  var zoneState;
  var areaState;
  var districtName;
  var zoneName;
  var areaName;

  ///notification
  var notificationState;

  ///order
  var myOrderState;
  var preOrderDataState;

  ///wishlist
  var wishListState;
  var wishListItem;

  var reportState;
  var homeBrandState;
  var categoryIndex;

  var resetPasswordContactState;
  var resetPasswordTokenState;

  var preOrderCartState;
  var userBalanceState;
  var reportImageState;
  var getVariableProductState;
  var cartDataState;
  var cartProductState;

  var subTotalState;
  var grandTotalState;

  var promoCodeState;
  var referralCodeState;
  var giftVoucherState;
  var statusState;
  var logoutUserData;

  var currentScreenState;
  var allImageState;
  var darkModeState;
  var cartGetState;

  var ratingState;
  var userState;
  var dateState;
  var textDescriptionState;
  var cartDataLogoutState;
  var canceledOrderState;
  var salePageState;
  var userProfilePic;
  var getVariableProductLogout;
  var floatingActionButton;

  //fcmtoken

  AppState({
    this.isLoadingState,
    this.mainSliderState,
    this.groupProductState,
    this.brandProductState,
    this.featureProductState,
    this.promotionalSkinCardState,
    this.promotionalMakeupCardState,
    this.latestProductState,
    this.discountState,
    this.shopPageState,
    this.brandState,
    this.colorState,
    this.categoryState,
    this.subcategoryState,
    this.tagState,
    this.filterBrand,
    this.filterColor,
    this.filterCategory,
    this.filterSubcategory,
    this.filterMaxPrice,
    this.filterMinPrice,
    this.filterTag,
    this.filterHomeBrand,
    this.filterBrandName,
    this.filterCategoryName,
    this.filterSubCategoryName,
    this.singleProductColor,
    this.singleProductSize,
    this.singleProductRating,
    this.relatedProductState,
    this.productReviewState,
    this.singleProductIdState,
    this.singleProductInformationState,
    this.groupCategoryState,
    this.userDataState,
    this.newUserDataState,
    this.userContactState,
    this.districtState,
    this.zoneState,
    this.areaState,
    this.districtName,
    this.zoneName,
    this.areaName,
    this.notificationState,
    this.myOrderState,
    this.preOrderDataState,
    this.wishListState,
    this.wishListItem,
    this.reportState,
    this.homeBrandState,
    this.categoryIndex,
    this.resetPasswordContactState,
    this.resetPasswordTokenState,
    this.preOrderCartState,
    this.userBalanceState,
    this.reportImageState,
    this.getVariableProductState,
    this.cartDataState,
    this.cartProductState,
    this.subTotalState,
    this.grandTotalState,
    this.promoCodeState,
    this.referralCodeState,
    this.giftVoucherState,
    this.statusState,
    this.logoutUserData,
    this.currentScreenState,
    this.allImageState,
    this.darkModeState,
    this.cartGetState,
    this.ratingState,
    this.userState,
    this.dateState,
    this.textDescriptionState,
    this.cartDataLogoutState,
    this.canceledOrderState,
    this.salePageState,
    this.userProfilePic,
    this.getVariableProductLogout,
    this.floatingActionButton,
  });

  AppState copywith({
    isLoadingState,
    mainSliderState,
    groupProductState,
    brandProductState,
    featureProductState,
    promotionalSkinCardState,
    promotionalMakeupCardState,
    latestProductState,
    discountState,
    shopPageState,
    brandState,
    colorState,
    categoryState,
    subcategoryState,
    tagState,
    //filterShopState,
    filterBrand,
    filterColor,
    filterCategory,
    filterSubcategory,
    filterMaxPrice,
    filterMinPrice,
    filterTag,
    filterHomeBrand,
    filterBrandName,
    filterCategoryName,
    filterSubCategoryName,
    singleProductColor,
    singleProductSize,
    singleProductRating,
    relatedProductState,
    productReviewState,
    singleProductIdState,
    singleProductInformationState,
    groupCategoryState,
    userDataState,
    newUserDataState,
    userContactState,
    districtState,
    zoneState,
    areaState,
    districtName,
    zoneName,
    areaName,
    notificationState,
    myOrderState,
    preOrderDataState,
    wishListState,
    wishListItem,
    reportState,
    homeBrandState,
    categoryIndex,
    resetPasswordContactState,
    resetPasswordTokenState,
    preOrderCartState,
    userBalanceState,
    reportImageState,
    getVariableProductState,
    cartDataState,
    cartProductState,
    subTotalState,
    grandTotalState,
    promoCodeState,
    referralCodeState,
    giftVoucherState,
    statusState,
    logoutUserData,
    currentScreenState,
    allImageState,
    darkModeState,
    cartGetState,
    ratingState,
    userState,
    dateState,
    textDescriptionState,
    cartDataLogoutState,
    canceledOrderState,
    salePageState,
    userProfilePic,
    getVariableProductLogout,
    floatingActionButton,
  }) {
    return AppState(
      isLoadingState: isLoadingState ?? this.isLoadingState,
      mainSliderState: mainSliderState ?? this.mainSliderState,
      groupProductState: groupProductState ?? this.groupProductState,
      brandProductState: brandProductState ?? this.brandProductState,
      featureProductState: featureProductState ?? this.featureProductState,
      promotionalSkinCardState: promotionalSkinCardState ?? this.promotionalSkinCardState,
      promotionalMakeupCardState: promotionalMakeupCardState ?? this.promotionalMakeupCardState,
      latestProductState: latestProductState ?? this.latestProductState,
      discountState: discountState ?? this.discountState,
      shopPageState: shopPageState ?? this.shopPageState,
      brandState: brandState ?? this.brandState,
      colorState: colorState ?? this.colorState,
      categoryState: categoryState ?? this.categoryState,
      subcategoryState: subcategoryState ?? this.subcategoryState,
      tagState: tagState ?? this.tagState,
      filterBrand: filterBrand ?? this.filterBrand,
      filterColor: filterColor ?? this.filterColor,
      filterSubcategory: filterSubcategory ?? this.filterSubcategory,
      filterCategory: filterCategory ?? this.filterCategory,
      filterMaxPrice: filterMaxPrice ?? this.filterMaxPrice,
      filterMinPrice: filterMinPrice ?? this.filterMinPrice,
      filterTag: filterTag ?? this.filterTag,
      filterHomeBrand: filterHomeBrand ?? this.filterHomeBrand,
      filterBrandName: filterBrandName ?? this.filterBrandName,
      filterCategoryName: filterCategoryName ?? this.filterCategoryName,
      filterSubCategoryName:
          filterSubCategoryName ?? this.filterSubCategoryName,
      singleProductColor: singleProductColor ?? this.singleProductColor,
      singleProductSize: singleProductSize ?? this.singleProductSize,
      singleProductRating: singleProductRating ?? this.singleProductRating,
      relatedProductState: relatedProductState ?? this.relatedProductState,
      productReviewState: productReviewState ?? this.productReviewState,
      singleProductIdState: singleProductIdState ?? this.singleProductIdState,
        singleProductInformationState:
            singleProductInformationState ?? this.singleProductInformationState,
      groupCategoryState: groupCategoryState ?? this.groupCategoryState,
      userDataState: userDataState ?? this.userDataState,
      newUserDataState: newUserDataState ?? this.newUserDataState,
      userContactState: userContactState ?? this.userContactState,
      districtState: districtState ?? this.districtState,
      zoneState: zoneState ?? this.zoneState,
      areaState: areaState ?? this.areaState,
      districtName: districtName ?? this.districtName,
      zoneName: zoneName ?? this.zoneName,
      areaName: areaName ?? this.areaName,
      notificationState: notificationState ?? this.notificationState,
      myOrderState: myOrderState ?? this.myOrderState,
      preOrderDataState: preOrderDataState ?? this.preOrderDataState,
      wishListState: wishListState ?? this.wishListState,
      wishListItem: wishListItem ?? this.wishListItem,
      reportState: reportState ?? this.reportState,
      homeBrandState: homeBrandState ?? this.homeBrandState,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      resetPasswordContactState:
          resetPasswordContactState ?? this.resetPasswordContactState,
      resetPasswordTokenState:
          resetPasswordTokenState ?? this.resetPasswordTokenState,
      preOrderCartState: preOrderCartState ?? this.preOrderCartState,
      userBalanceState: userBalanceState ?? this.userBalanceState,
      reportImageState: reportImageState ?? this.reportImageState,
      getVariableProductState:
          getVariableProductState ?? this.getVariableProductState,
      cartDataState: cartDataState ?? this.cartDataState,
      cartProductState: cartProductState ?? this.cartProductState,
      subTotalState: subTotalState ?? this.subTotalState,
      grandTotalState: grandTotalState ?? this.grandTotalState,
      promoCodeState: promoCodeState ?? this.promoCodeState,
      referralCodeState: referralCodeState ?? this.referralCodeState,
      giftVoucherState: giftVoucherState ?? this.giftVoucherState,
      statusState: statusState ?? this.statusState,
      logoutUserData: logoutUserData ?? this.logoutUserData,
      currentScreenState: currentScreenState ?? this.currentScreenState,
      allImageState: allImageState ?? this.allImageState,
      darkModeState: darkModeState ?? this.darkModeState,
      cartGetState: cartGetState ?? this.cartGetState,
      ratingState: ratingState ?? this.ratingState,
      userState: userState ?? this.userState,
      dateState: dateState ?? this.dateState,
      textDescriptionState: textDescriptionState ?? this.textDescriptionState,
      cartDataLogoutState: cartDataLogoutState ?? this.cartDataLogoutState,
      canceledOrderState: canceledOrderState ?? this.canceledOrderState,
      salePageState: salePageState ?? this.salePageState,
      userProfilePic: userProfilePic ?? this.userProfilePic,
      getVariableProductLogout:
          getVariableProductLogout ?? this.getVariableProductLogout,
      floatingActionButton: floatingActionButton ?? this.floatingActionButton,
    );
  }
}
