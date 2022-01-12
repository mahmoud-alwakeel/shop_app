import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/models/categories/categories_model.dart';
import 'package:shopp_app/models/change_favorites_model.dart';
import 'package:shopp_app/models/favorites_model.dart';
import 'package:shopp_app/models/users/home_model.dart';
import 'package:shopp_app/models/users/login_model.dart';
import 'package:shopp_app/models/users/user_model.dart';
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

    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
      ];

  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};
  
  void getHomeData(){
     emit(ShopLoadingHomeDataState());
     DioHelper.getData(
         url: HOME,
       token: token,
     ).then((value){
       print(value.data);
       homeModel = HomeModel.fromJson(value.data);

       //print(homeModel.data.banners[0].image);
       //print(homeModel.status);

       homeModel.data.products.forEach((element) {
         favorites.addAll({
           element.id : element.inFavorites,
         });
       });

       emit(ShopSuccessHomeDataState());
     }).catchError((error){
       print(error.toString());
       emit(ShopErrorHomeDataState());
     });
  }

      CategoriesModel categoriesModel;

      void getCategories(){
        DioHelper.getData(
          url: GET_CATEGORIES,
          token: token,
        ).then((value){
          print(value.data);
          categoriesModel = CategoriesModel.fromJson(value.data);


          emit(ShopSuccessCategoriesState());
        }).catchError((error){
          print(error.toString());
          emit(ShopErrorCategoriesState());
        });
      }

      ChangeFavoritesModel changeFavoritesModel;

      void changeFavorites(int productId){

        favorites[productId] = !favorites[productId];
        emit(ShopSuccessChangeFavoritesState());

        DioHelper.postData(
          url: FAVORITES,
            data: {
          'product_id': productId
        },
          token: 'token',
        ).then((value)  {
          changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

          if(!changeFavoritesModel.status){
            favorites[productId] = !favorites[productId];
          }else
            {
              getFavorites();
            }
          emit(ShopSuccessChangeFavoritesState());
        }).catchError((error){

          //favorites[productId] = !favorites[productId];
          emit(ShopErrorChangeFavoritesState());
        });
      }

      FavoritesModel favoritesModel;

      void getFavorites(){
        emit(ShopLoadingGetFavoritesState());
        DioHelper.getData(
          url: FAVORITES,
          token: token,
        ).then((value){
          print(value.data);
          favoritesModel = FavoritesModel.fromJson(value.data);
          print(value.data.toString());


          emit(ShopSuccessGetFavoritesState());
        }).catchError((error){
          print(error.toString());
          emit(ShopErrorGetFavoritesState());
        });
      }

      LoginModel userModel;

      void getUserData(){

        emit(ShopLoadingUserDataState());
        DioHelper.getData(
          url: PROFILE,
          token: token,
        ).then((value){
          print(value.data);
          userModel = LoginModel.fromJson(value.data);
          print(userModel.data.name);


          emit(ShopSuccessUserDataState(userModel));
        }).catchError((error){
          print(error.toString());
          emit(ShopErrorUserDataState());
        });
      }

}