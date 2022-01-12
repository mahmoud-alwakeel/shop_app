import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/bloc/shop_second_cubit/bloc.dart';
import 'package:shopp_app/bloc/shop_second_cubit/bloc_states.dart';
import 'package:shopp_app/models/categories/categories_model.dart';

class CategoriesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state){},
      builder: (context, state){
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(ShopLayoutCubit.get(context).categoriesModel.data.data[index]),
        separatorBuilder: (context, index) => SizedBox(height: 10,),
        itemCount: ShopLayoutCubit.get(context).categoriesModel.data.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 80.0,
          height: 80.0,),
        SizedBox(width: 20.0,),
        Text(
          model.name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
