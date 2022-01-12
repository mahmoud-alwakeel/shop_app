import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/bloc/shop_second_cubit/bloc.dart';
import 'package:shopp_app/bloc/shop_second_cubit/bloc_states.dart';
import 'package:shopp_app/models/categories/categories_model.dart';
import 'package:shopp_app/models/users/home_model.dart';
import 'package:shopp_app/shared/components/components.dart';
import 'package:shopp_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state){
        // if(state is ShopSuccessChangeFavoritesState){
        //   if(!state.model.status){
        //     showToast(
        //         text: state.model.message,
        //         state: ToastStates.ERROR);
        //   }
        // }
      },
      builder: (context, state){
        return ConditionalBuilder(
            condition: ShopLayoutCubit.get(context).homeModel != null && ShopLayoutCubit.get(context).categoriesModel != null,
            builder: (context) => productsBuilder(ShopLayoutCubit.get(context).homeModel,ShopLayoutCubit.get(context).categoriesModel, context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      }

        );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel, context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
             horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
              ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(width: 10.0,),
                    itemCount: categoriesModel.data.data.length,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 1/1.42,
            children: List.generate(
                model.data.products.length,
                    (index) => buildGridProduct(model.data.products[index], context),

          ),
          ),
        ),
      ],
    ),
  );

  Widget buildCategoryItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(0.6),
        child: Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      )
    ],
  );

  Widget buildGridProduct(ProductModel model, context)=> Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,

              height: 160.0,
            ),
            if(model.discount != 0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  if(model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,

                    ),
                  ),
                  Spacer(),
                  IconButton(

                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopLayoutCubit.get(context).favorites[model.id] ? defaultColor : Colors.grey,
                        child: Icon(
                            Icons.favorite_border,
                            size: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: (){
                        ShopLayoutCubit.get(context).changeFavorites(model.id);
                        print(model.id);
                      }
                      )

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
