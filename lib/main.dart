import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/layout/login/shop_login.dart';
import 'package:shop_app/layout/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shop_app/cubit.dart';
import 'package:shop_app/shop_app/shop_layout.dart';
import 'package:shop_app/styles/themes.dart';

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
  String token = CacheHelper.getData(key: 'token');

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
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(create: (BuildContext context) => NewsCubit()),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData()),
      ],
      child: BlocConsumer<AppCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
