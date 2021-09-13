import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/login/cubit/cubit.dart';
import 'package:shop_app/login/shop_login.dart';
import 'package:shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/register/cubit/cubit.dart';
import 'package:shop_app/search/cubit/cubit.dart';
import 'package:shop_app/shop_app/cubit.dart';
import 'package:shop_app/shop_app/shop_layout.dart';
import 'package:shop_app/shop_app/states.dart';
import 'package:shop_app/styles/themes.dart';

import 'constant.dart';
import 'cubit/app_cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/obServer.dart';
import 'cubit/states.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  //we use this line when we use the async
  //this line ensure all things in the main method is initialized
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  Widget widget;

  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  // to execute the observer
  Bloc.observer = MyBlocObserver();

  runApp(MyApp(onBoarding: onBoarding, startWidget: widget));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Widget startWidget;
  MyApp({this.onBoarding, this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getProfile(),
          ),
          BlocProvider(
            create: (context) => SearchCubit(),
          )
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                home: startWidget);
          },
        ));
  }
}

// return BlocProvider(
// create: (BuildContext context) => ShopCubit()
// ..getHomeData()
// ..getCategories()
// ..getFavorites()
// ..getProfile(),
// child: BlocConsumer<ShopCubit, ShopStates>(
// listener: (context, state) {},
// builder: (context, state) {
// return MaterialApp(
// debugShowCheckedModeBanner: false,
// theme: lightTheme,
// darkTheme: darkTheme,
// themeMode: ThemeMode.light,
// home: startWidget,
// );
// },
// ),
// );
