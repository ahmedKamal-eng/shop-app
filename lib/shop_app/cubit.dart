import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/categories/category_screen.dart';
import 'package:shop_app/favorite/favorite_screen.dart';
import 'package:shop_app/models/user/shop_app/Category_model.dart';
import 'package:shop_app/models/user/shop_app/home_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';
import 'package:shop_app/products/products_screen.dart';
import 'package:shop_app/settings/settings_screen.dart';
import 'package:shop_app/shop_app/states.dart';

import '../constant.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      printFullText(homeModel.data.banners[0].image);

      print(homeModel.status);

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoryDataState());
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorCategoryDataState());
    });
  }
}
