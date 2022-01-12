import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/bloc/shop_second_cubit/bloc.dart';
import 'package:shopp_app/bloc/shop_second_cubit/bloc_states.dart';
import 'package:shopp_app/shared/components/components.dart';
import 'package:shopp_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context, state){
        if(state is ShopSuccessUserDataState){
          nameController.text = state.loginModel.data.name;
          emailController.text = state.loginModel.data.email;
        }
      },
      builder: (context, state){
        var model;

        // nameController.text = model.data.name;
        // emailController.text = model.data.email;


        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).userModel != null,
          builder:(context) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String value){
                    if(value.isEmpty){
                      return 'name  must not be empty';
                    }
                    return null;
                  },
                  label: 'name',
                  prefix: Icons.person,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String value){
                    if(value.isEmpty){
                      return 'email  must not be empty';
                    }
                    return null;
                  },
                  label: 'email',
                  prefix: Icons.email,
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String value){
                    if(value.isEmpty){
                      return 'phone  must not be empty';
                    }
                    return null;
                  },
                  label: 'phone',
                  prefix: Icons.phone,
                ),
                SizedBox(height: 20.0,),
                defaultButton(
                    function: (){
                      signOut(context);
                    },
                    text: 'Logout'),
              ],
            ),
          ) ,
          fallback: (context) => CircularProgressIndicator(),
        );
      },

    );
  }
}

