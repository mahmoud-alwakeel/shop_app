import 'package:shopp_app/models/change_favorites_model.dart';
import 'package:shopp_app/models/users/login_model.dart';

class ShopLayoutStates{}

class ShopInitialState extends ShopLayoutStates{}

class ShopChangeBottomNavState extends ShopLayoutStates{}

class ShopLoadingHomeDataState extends ShopLayoutStates{}

class ShopSuccessHomeDataState extends ShopLayoutStates{}

class ShopErrorHomeDataState extends ShopLayoutStates{}

class ShopSuccessCategoriesState extends ShopLayoutStates{}

class ShopErrorCategoriesState extends ShopLayoutStates{}

// class ShopChangeFavoritesState extends ShopLayoutStates{}

class ShopSuccessChangeFavoritesState extends ShopLayoutStates{
  //
  // final ChangeFavoritesModel model;
  //
  // ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopLayoutStates{}

class ShopLoadingGetFavoritesState extends ShopLayoutStates{}

class ShopSuccessGetFavoritesState extends ShopLayoutStates{}

class ShopErrorGetFavoritesState extends ShopLayoutStates{}

class ShopLoadingUserDataState extends ShopLayoutStates{}

class ShopSuccessUserDataState extends ShopLayoutStates{

  final LoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopLayoutStates{}


