import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shopp_app/layout/layout.dart';
import 'package:shopp_app/modules/login/cubit/cubit.dart';
import 'package:shopp_app/modules/login/login_screen.dart';
import 'package:shopp_app/on_boarding/on_boarding_screen.dart';
import 'package:shopp_app/shared/network/local/cache_helper.dart';
import 'package:shopp_app/shared/network/remote/dio_helper.dart';
import 'package:shopp_app/shared/styles/themes.dart';

import 'modules/login/cubit/states.dart';
import 'modules/login/shop_second_cubit/bloc.dart';
import 'modules/login/shop_second_cubit/bloc_states.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key:'isDark');

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  bool token = CacheHelper.getData(key: 'token');


  if(onBoarding != null){
    if(token != null){
      widget = LayoutScreen();
    } else  widget = LoginScreen();
  } else  widget = OnBoardingScreen();
  print(onBoarding);

  //widget = LayoutScreen();

  runApp(MyApp(
    isDark: isDark,
     startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp({this.isDark, this.startWidget});



  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (BuildContext context) => ShopLoginCubit()),
        BlocProvider(create: (BuildContext context) => ShopLayoutCubit()..getHomeData()),
    ],
    child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
    listener: (context,ShopLayoutStates state){},
    builder: (context,ShopLayoutStates state){
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: startWidget,

    );
  },
    ),
    );
  }
}
