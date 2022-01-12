import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/bloc/shop_second_cubit/bloc.dart';
import 'package:shopp_app/layout/layout.dart';
import 'package:shopp_app/modules/login/cubit/cubit.dart';
import 'package:shopp_app/modules/login/cubit/states.dart';
import 'package:shopp_app/modules/products/products_screen.dart';
import 'package:shopp_app/modules/register/register_screen.dart';
import 'package:shopp_app/shared/components/components.dart';
import 'package:shopp_app/shared/components/constants.dart';
import 'package:shopp_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopLoginCubit()),
        //BlocProvider(create: (BuildContext context) => ShopLayoutCubit()),
      ],
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context,ShopLoginStates state){
          if(state is ShopLoginSuccessState){
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
        builder: (context,ShopLoginStates state){
          return  Scaffold(
            appBar: AppBar(

            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text('login to view our products',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
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
                            if(formKey.currentState.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text ,
                                  password: passwordController.text
                              );
                            }
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
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                print('valid login');
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                navigateAndFinish(context, ProductsScreen());
                                print('after cubit');
                              }

                              else print('cannot login');
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  RegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        )
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
