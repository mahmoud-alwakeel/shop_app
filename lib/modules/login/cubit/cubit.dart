import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/models/users/login_model.dart';
import 'package:shopp_app/modules/login/cubit/states.dart';
import 'package:shopp_app/modules/login/shop_second_cubit/bloc_states.dart';
import 'package:shopp_app/shared/network/end_points.dart';
import 'package:shopp_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);


  LoginModel loginModel;
  //int currentIndex = 0;

  void userLogin({
  @required String email,
  @required String password,
})
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data:{
          'email': email,
          'password': password,
    }).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data.token);
      print(loginModel.status);
      print(loginModel.message);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      // print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });

  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    print('suffix changed');
    emit(ShopPasswordInvisibility());
  }


}