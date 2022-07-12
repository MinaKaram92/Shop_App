import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/carts_model.dart';
import 'package:shop_app/modules/category_products_screen/category_products_screen.dart';
import 'package:shop_app/modules/product_details_screen/product_details_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CartsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: cubit.cartsModel != null,
            builder: (context) {
              return ConditionalBuilder(
                condition: cubit.cartsModel!.data!.cartItems!.length > 0,
                builder: (context) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return buildCartProductItem(
                        context,
                        cubit.cartsModel!.data!.cartItems![index],
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: cubit.cartsModel!.data!.cartItems!.length,
                  );
                },
                fallback: (context) => Center(
                    child: Text(
                  'There are no items',
                  style: TextStyle(fontSize: 20.0),
                )),
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildCartProductItem(context, CartItemModel model) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getProductDetailsById(model.product!.id!);
        navigateTo(context, ProductDetailsScreen(model.product!.id!));
      },
      child: Container(
        width: 140.0,
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              '${model.product!.image}',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '${model.product!.price}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${model.product!.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${model.product!.description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Container(
                          color: Colors.blue,
                          child: IconButton(
                            onPressed: () {
                              int quantity = model.quantity!;
                              quantity++;
                              ShopCubit.get(context).changeQuantity(
                                quantity,
                                model.id!,
                              );
                            },
                            icon: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                              '${ShopCubit.get(context).quantities[model.product!.id!]}'),
                        ),
                        Container(
                          color: Colors.blue,
                          child: IconButton(
                            onPressed: () {
                              int quantity = model.quantity!;
                              quantity--;
                              ShopCubit.get(context).changeQuantity(
                                quantity,
                                model.id!,
                              );
                            },
                            icon: Icon(Icons.remove),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          color: Colors.blue,
                          iconSize: 30.0,
                          onPressed: () {
                            ShopCubit.get(context).deleteCart(model.id!);
                          },
                          icon: Icon(
                            Icons.delete,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
