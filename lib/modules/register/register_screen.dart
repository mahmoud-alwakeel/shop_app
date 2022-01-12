import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/layout/layout.dart';
import 'package:shopp_app/modules/register/cubit/cubit.dart';
import 'package:shopp_app/shared/components/components.dart';
import 'package:shopp_app/shared/components/constants.dart';
import 'package:shopp_app/shared/network/local/cache_helper.dart';

import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state){
          if(state is ShopRegisterSuccessState){
            if(state.loginModel.status){
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, LayoutScreen());
              });
            }else{
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text('Register to view our products',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'please enter your name';
                              }
                            },
                            label: 'name',
                            prefix: Icons.person
                        ),
                        SizedBox(height: 20.0,),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'please enter your email address';
                              }
                            },
                            label: 'Email address',
                            prefix: Icons.email
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.emailAddress,
                          // suffix: ShopLoginCubit.get(context).suffix,
                          // isPassword: ShopLoginCubit.get(context).isPassword,
                          // suffixPressed: (){
                          //   print('visibility changed');
                          //   ShopLoginCubit.get(context).changePasswordVisibility();
                          //
                          // },

                          onSubmit: (value)
                          {

                          },
                          validate: (String value){
                            if(value.isEmpty){
                              return 'please enter your password ';
                            }
                          },
                          label: 'password',
                          prefix: Icons.lock,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value){
                            if(value.isEmpty){
                              return 'please enter your phone';
                            }
                          },
                          label: 'phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is ! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                print('valid register');
                                navigateAndFinish(context, LayoutScreen());
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                              text: 'Register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),

                        //default button run error Cannot provide both a color and a decoration
                        // To provide both, use "decoration: BoxDecoration(color: color)".
                        // 'package:flutter/src/widgets/container.dart':
                        // Failed assertion: line 274 pos 15: 'color == null || decoration == null'
                        // defaultButton(
                        //     function: (){},
                        //     text: 'login',
                        //     isUppercase: true,
                        //
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
