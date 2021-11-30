import 'package:flutter/material.dart';
import 'package:shopp_app/modules/login/login_screen.dart';
import 'package:shopp_app/shared/network/local/cache_helper.dart';

import 'components.dart';

// void navigateTo(BuildContext context, LoginScreen loginScreen){
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => LoginScreen()),
//   );
// }

void signOut(context){
  CacheHelper.removeData(key: 'token',).then((value) {
    if(value){
      navigateAndFinish(context, LoginScreen());
    }
  });
}

String token = '';