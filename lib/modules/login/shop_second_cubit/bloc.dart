import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/models/users/home_model.dart';
import 'package:shopp_app/modules/categories/categories.dart';
import 'package:shopp_app/modules/favorites/favorities_screen.dart';
import 'package:shopp_app/modules/products/products_screen.dart';
import 'package:shopp_app/modules/settings/settings_screen.dart';
import 'package:shopp_app/shared/components/constants.dart';
import 'package:shopp_app/shared/network/end_points.dart';
import 'package:shopp_app/shared/network/remote/dio_helper.dart';

import 'bloc_states.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
      ShopLayoutCubit() : super(ShopInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    SettingsScreen(),
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
      ];

  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  
  void getHomeData(){
     emit(ShopLoadingHomeDataState());
     DioHelper.getData(
         url: HOME,
       token: token,
     ).then((value){
       homeModel = HomeModel.fromJson(value.data);

       print(homeModel.data.banners[0].image);
       print(homeModel.status);
       emit(ShopSuccessHomeDataState());
     }).catchError((error){
       emit(ShopErrorHomeDataState());
     });
  }
}