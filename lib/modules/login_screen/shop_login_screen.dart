import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/modules/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              token = state.loginModel.data!.token;
              showToast(
                  msg: state.loginModel.message!, state: ToastStates.Success);
              ShopCubit.get(context).getProductHome();
              ShopCubit.get(context).getAllCategories();
              ShopCubit.get(context).getCarts();
              ShopCubit.get(context).getProfile();
              ShopCubit.get(context).getFavorites();
              ShopCubit.get(context).quantities = {};
              CacheHelper.saveData('token', state.loginModel.data!.token)
                  .then((value) {
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              showToast(
                  msg: state.loginModel.message!, state: ToastStates.Error);
            }
          }
        },
        builder: (context, state) {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Login'),
              actions: [
                TextButton(
                  onPressed: () {
                    CacheHelper.deleteCachedData(key: 'islastOnboarding');
                  },
                  child: Text(
                    'Delete on boarding',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          label: 'Username',
                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Email address can not be empty';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultTextFormField(
                          label: 'Password',
                          isPassword: cubit.isPassword,
                          prefix: Icons.lock,
                          suffix: cubit.suffixIcon,
                          suffixPressed: () {
                            cubit.changeSuffixStatus();
                          },
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Paasword address can not be empty';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state != ShopLoginLoadingState,
                          builder: (context) {
                            return defaultMaterialButton(
                                color: Colors.blue,
                                minWidth: double.infinity,
                                height: 40.0,
                                textTheme: ButtonTextTheme.primary,
                                textSize: 20.0,
                                text: 'Login',
                                pressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                });
                          },
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              child: Text(
                                'REGISTER',
                              ),
                            ),
                          ],
                        ),
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
