import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/user/shop_app/change_favorite_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

//home states
class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

//category states
class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

//favorite states
class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

//profile states
class ShopLoadingGetProfileState extends ShopStates {}

class ShopSuccessGetProfileState extends ShopStates {}

class ShopErrorGetProfileState extends ShopStates {}

//update States
class ShopLoadingUpdateState extends ShopStates {}

class ShopSuccessUpdateState extends ShopStates {}

class ShopErrorUpdateState extends ShopStates {}
