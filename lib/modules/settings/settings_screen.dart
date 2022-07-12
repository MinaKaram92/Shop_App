import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.profile != null,
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(
                        cubit.profile!.data!.image!,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(Icons.person),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                color: Colors.blue,
                                width: 1.0,
                                height: 60.0,
                              ),
                            ),
                            Text(cubit.profile!.data!.name!),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(Icons.email),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              color: Colors.blue,
                              width: 1.0,
                              height: 60.0,
                            ),
                          ),
                          Text(cubit.profile!.data!.email!),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            Icon(Icons.phone),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                color: Colors.blue,
                                width: 1.0,
                                height: 60.0,
                              ),
                            ),
                            Text(cubit.profile!.data!.phone!),
                          ],
                        ),
                      ),
                    ),
                    defaultMaterialButton(
                      text: 'SignOut',
                      pressed: () {
                        cubit.signOut(context);
                      },
                      minWidth: double.infinity,
                      height: 40.0,
                      color: Colors.blue,
                      textTheme: ButtonTextTheme.primary,
                      textSize: 20.0,
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
