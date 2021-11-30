import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/models/users/home_model.dart';
import 'package:shopp_app/modules/login/shop_second_cubit/bloc.dart';
import 'package:shopp_app/modules/login/shop_second_cubit/bloc_states.dart';

class ProductsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state){},
      builder: (context, state){
        return ConditionalBuilder(
            condition: ShopLayoutCubit.get(context).homeModel != null,
            builder: (context) => productsBuilder(ShopLayoutCubit.get(context).homeModel ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      }

        );
  }

  Widget productsBuilder(HomeModel model) => Column(
    children: [
      CarouselSlider(
          items: model.data.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          )).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
      )
    ],
  );
}
