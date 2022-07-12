import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen/shop_login_screen.dart';
import 'package:shop_app/modules/register_screen/cubit/cubit.dart';
import 'package:shop_app/modules/register_screen/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.userRegisterModel!.status!) {
              showToast(
                  msg: state.userRegisterModel!.message!,
                  state: ToastStates.Success);
              navigateAndFinish(context, ShopLoginScreen());
            } else {
              showToast(
                  msg: state.userRegisterModel!.message!,
                  state: ToastStates.Error);
            }
          }
        },
        builder: (context, state) {
          ShopRegisterCubit cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: defaultTextFormField(
                              controller: nameController,
                              label: 'Name',
                              prefix: Icons.person,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Name can not be empty';
                                }
                              }),
                        ),
                        defaultTextFormField(
                            controller: emailController,
                            label: 'Email',
                            prefix: Icons.email,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Email can not be empty';
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: defaultTextFormField(
                              controller: phoneController,
                              label: 'Phone',
                              prefix: Icons.phone,
                              type: TextInputType.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Phone can not be empty';
                                }
                              }),
                        ),
                        defaultTextFormField(
                            controller: passwordController,
                            label: 'Password',
                            prefix: Icons.lock,
                            suffix: cubit.suffixIcon,
                            isPassword: cubit.isPassword,
                            type: TextInputType.visiblePassword,
                            suffixPressed: () {
                              cubit.changeSuffixStatus();
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Password can not be empty';
                              }
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) {
                            return defaultMaterialButton(
                              pressed: () {
                                if (formkey.currentState!.validate()) {
                                  cubit.registerUser(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Register',
                              textSize: 20.0,
                              color: Colors.blue,
                              minWidth: double.infinity,
                              height: 40.0,
                              textTheme: ButtonTextTheme.primary,
                            );
                          },
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
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
