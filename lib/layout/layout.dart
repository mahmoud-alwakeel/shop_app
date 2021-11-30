import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/modules/login/login_screen.dart';
import 'package:shopp_app/modules/login/shop_second_cubit/bloc.dart';
import 'package:shopp_app/modules/login/shop_second_cubit/bloc_states.dart';
import 'package:shopp_app/modules/search/search_screen.dart';
import 'package:shopp_app/shared/components/components.dart';
import 'package:shopp_app/shared/network/local/cache_helper.dart';

class LayoutScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state){},
      builder: (context, state){

        var cubit = ShopLayoutCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
                'shop'
            ),
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: (){
                navigateTo(context, SearchScreen());
              })
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.home,

                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.apps,

                ),
                label: 'categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.favorite,

                ),
                label: 'favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.settings,

                ),
                label: 'settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
