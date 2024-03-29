import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopp_app/bloc/shop_second_cubit/bloc.dart';
import 'package:shopp_app/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
  TextButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
    ),
  );


Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,


}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix
    ),
    suffixIcon: suffix != null ?IconButton(
      onPressed:  (){},
      icon: Icon(
        suffix
      ),
    ) :null,
    border: OutlineInputBorder(),

  ),
);

Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true
    }) =>
    Padding(
  padding: const EdgeInsets.all(14.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120.0,
              height: 120.0,

            ),
            if(model.discount != 0 && isOldPrice)
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
        SizedBox(width: 20.0,),
        Expanded(
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
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
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

                      }
                  )

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    )
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget,
    ),
      (route) {
          return false;
        },
);

void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM ,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state){

  Color color;
  switch(state){
    case ToastStates.SUCCESS:
    color = Colors.green;
    break;

    case ToastStates.WARNING:
      color = Colors.yellow;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }

  return color;
}

