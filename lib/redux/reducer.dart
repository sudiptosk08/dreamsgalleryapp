
import 'package:dream_gallary/redux/state.dart';

import 'action.dart';

AppState reducer(AppState state, dynamic action) {

  if(action is IsLoadingAction) {
    print('hi from reducer if TryAction');
    return state.copywith(isLoadingState: action.isLoadingAction);
  }
  else if (action is MainSliderAction) {
    return state.copywith(mainSliderState: action.mainSliderAction);
  }
  else if (action is GroupProductAction) {
    return state.copywith(groupProductState: action.groupProductAction);
  }
  else if (action is BrandProductAction) {
    return state.copywith(brandProductState: action.brandProductAction);
  }
  else if (action is FeatureProductAction) {
    return state.copywith(featureProductState: action.featureProductAction);
  }
  // else if(action is PromotionalCardAction){
  //   return state.copywith(promotionalCardState: action.promotionalCardAction);
  // }
  else if(action is LatestProductAction){
    return state.copywith(latestProductState: action.latestProductAction);
  }
  else if(action is DiscountAction){
    return state.copywith(discountState: action.discountAction);
  }
  else if(action is ShopPageAction){
    return state.copywith(shopPageState: action.shopPageAction);
  }
  else if(action is BrandAction){
    return state.copywith(brandState: action.brandAction);
  }
  else if(action is ColorAction){
    return state.copywith(colorState: action.colorAction);
  }
  else if(action is CategoryAction){
    return state.copywith(categoryState: action.categoryAction);
  }
  else if(action is SubCategoryAction){
    return state.copywith(subcategoryState: action.subcategoryAction);
  }
  else if(action is TagAction){
    return state.copywith(tagState: action.tagAction);
  }
  //else if(action is FilterShopAction){
  //     return state.copywith(filterShopState: action.filterShopAction);
  //   }
  else if(action is FilterBrandAction){
    return state.copywith(filterBrand: action.filterBrandAction);
  }
  else if(action is FilterColorAction){
    return state.copywith(filterColor: action.filterColorAction);
  }
  else if(action is FilterCategoryAction){
    return state.copywith(filterCategory: action.filterCategoryAction);
  }
  else if(action is FilterSubcategoryAction){
    return state.copywith(filterSubcategory: action.filterSubcategoryAction);
  }
  else if(action is FilterMaxPriceAction){
    return state.copywith(filterMaxPrice: action.filterMaxPriceAction);
  }
  else if(action is FilterMinPriceAction){
    return state.copywith(filterMinPrice: action.filterMinPriceAction);
  }
  else if(action is FilterTagAction){
    return state.copywith(filterTag: action.filterTagAction);
  }

  else if(action is FilterBrandNameAction){
    return state.copywith(filterBrandName: action.filterBrandNameAction );
  }

  else if(action is FilterCategoryNameAction){
    return state.copywith(filterCategoryName: action.filterCategoryNameAction);
  }
  else if(action is FilterSubCategoryNameAction){
    return state.copywith(filterSubCategoryName: action.filterSubCategoryNameAction);
  }

  else if(action is SingleProductColorAction){
    return state.copywith(singleProductColor: action.singleProductColorAction);
  }
  else if(action is SingleProductSizeAction){
    return state.copywith(singleProductSize: action.singleProductSizeAction);
  }

  else if(action is SingleProductRatingAction){
    return state.copywith(singleProductRating: action.singleProductRatingAction);
  }


  else if(action is RelatedProductAction){
    return state.copywith(relatedProductState: action.relatedProductAction);
  }
  else if(action is ProductReviewAction){
    return state.copywith(productReviewState: action.productReviewAction);
  }

  else if(action is SingleProductIdAction){
    return state.copywith(singleProductIdState: action.singleProductIdAction);
  }
  else if(action is SingleProductInformationAction){
    return state.copywith(singleProductInformationState: action.singleProductInformationAction);
  }

  else if(action is GroupCategoryAction){
    return state.copywith(groupCategoryState: action.groupCategoryAction);
  }
  else if(action is UserDataAction){
    return state.copywith(userDataState: action.userDataAction);
  }
  else if(action is NewUserDataAction){
    return state.copywith(newUserDataState: action.newUserDataAction);
  }
  else if(action is UserContactAction){
    return state.copywith(userContactState: action.userContactAction);
  }

  else if(action is DistrictAction){
    return state.copywith(districtState: action.districtAction);
  }

  else if(action is ZoneAction){
    return state.copywith(zoneState: action.zoneAction);
  }

  else if(action is AreasAction){
    return state.copywith(areaState: action.areasAction);
  }

  else if(action is DistrictNameAction){
    return state.copywith(districtName: action.districtNameAction);
  }

  else if(action is ZoneNameAction){
    return state.copywith(zoneName: action.zoneNameAction);
  }
  else if(action is AreaNameAction){
    return state.copywith(zoneName: action.areaNameAction);
  }

  else if(action is NotificationAction){
    return state.copywith(notificationState: action.notificationAction);
  }

  else if(action is MyOrderAction){
    return state.copywith(myOrderState: action.myOrderAction);
  }

  else if(action is PreOrderDataAction){
    return state.copywith(preOrderDataState: action.preOrderDataAction);
  }

  else if(action is WishListAction){
    return state.copywith(wishListState: action.wishListAction);
  }
  
  else if(action is WishListItemAction){
    return state.copywith(wishListItem: action.wishListItemAction);
  }
  else if(action is ReportAction){
    return state.copywith(reportState: action.reportAction);
  }
  else if(action is HomeBrandAction){
    return state.copywith(homeBrandState: action.homeBrandAction);
  }
  else if(action is HomeFilterBrandAction){
    return state.copywith(filterHomeBrand: action.homeFilterBrandAction);
  }
  else if(action is CategoryIndexAction){
    return state.copywith(categoryIndex: action.categoryIndexAction);
  }
  else if(action is ResetPasswordContactAction){
    return state.copywith(resetPasswordContactState: action.resetPasswordContactAction);
  }
  else if(action is ResetPasswordTokenAction){
    return state.copywith(resetPasswordTokenState: action.resetPasswordTokenAction);
  }

  else if(action is PreOrderCartAction){
    return state.copywith(preOrderCartState: action.preOrderCartAction);
  }
  else if(action is UserBalanceAction){
    return state.copywith(userBalanceState: action.userBalanceAction);
  }
  else if(action is ReportImageAction){
    return state.copywith(reportImageState: action.reportImageAction);
  }
  else if(action is GetVariableProductAction){
    return state.copywith(getVariableProductState: action.getVariableProductAction);
  }
  else if(action is CartDataAction){
    return state.copywith(cartDataState: action.cartDataAction);
  }
  else if(action is CartProductAction){
    return state.copywith(cartProductState: action.cartProductAction);
  }
  else if(action is SubTotalAction){
    return state.copywith(subTotalState: action.subTotalAction);
  }
  else if(action is GrandTotalAction){
    return state.copywith(grandTotalState: action.grandTotalAction);
  }
  else if(action is PromoCodeAction){
    return state.copywith(promoCodeState: action.promoCodeAction);
  }
  else if(action is ReferralCodeAction){
    return state.copywith(referralCodeState: action.referralCodeAction);
  }
  else if(action is GiftVoucherAction){
    return state.copywith(giftVoucherState: action.giftVoucherAction);
  }
  else if(action is StatusAction){
    return state.copywith(subTotalState: action.statusAction);
  }
  else if(action is LogoutUserAction){
    return state.copywith(logoutUserData: action.logoutUserAction);
  }
  else if(action is CurrentScreenAction){
    return state.copywith(currentScreenState: action.currentScreenAction);
  }
  else if(action is AllImageAction){
    return state.copywith(allImageState: action.allImageAction);
  }
  else if(action is DarkModeAction){
    return state.copywith(darkModeState: action.darkModeAction);
  }
  else if(action is CartGetAction){
    return state.copywith(cartGetState: action.cartGetAction);
  }
  else if(action is RatingAction){
    return state.copywith(ratingState: action.ratingAction);
  }
  else if(action is UserAction){
    return state.copywith(userState: action.userAction);
  }
  else if(action is DateAction){
    return state.copywith(dateState: action.dateAction);
  }
  else if(action is TextDescriptionAction){
    return state.copywith(textDescriptionState: action.textDescriptionAction);
  }
  else if(action is CanceledOrderAction){
    return state.copywith(canceledOrderState: action.canceledOrderAction);
  }
  else if(action is SalePageAction){
    return state.copywith(salePageState: action.salePageAction);
  }
  else if(action is UserProfilePicAction){
    return state.copywith(userProfilePic: action.userProfilePicAction);
  }
  else if(action is GetVariableProductLogout){
    return state.copywith(getVariableProductLogout: action.getVariableProductLogout);
  }
    else if(action is FloatingButtonAction){
    return state.copywith(floatingActionButton: action.floatingButtonAction);
  }



  return state;
}