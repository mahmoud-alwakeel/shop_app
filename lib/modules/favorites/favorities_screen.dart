import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/bloc/shop_second_cubit/bloc.dart';
import 'package:shopp_app/bloc/shop_second_cubit/bloc_states.dart';
import 'package:shopp_app/models/favorites_model.dart';
import 'package:shopp_app/shared/components/components.dart';
import 'package:shopp_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state){},
      builder: (context, state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder:(context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(ShopLayoutCubit.get(context).favoritesModel.data.data[index].product, context),
            separatorBuilder: (context, index) => SizedBox(height: 10,),
            itemCount: ShopLayoutCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


}
