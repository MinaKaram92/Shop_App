import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ProductDetailsScreen extends StatelessWidget {
  int id;
  ProductDetailsScreen(this.id);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        /* if (state is ChangeDetailsFavSuccessState) {
          if (state.favoritesAddingRemovingModel!.status == true) {
            showToast(
                msg: state.favoritesAddingRemovingModel!.message!,
                state: ToastStates.Success);
          } else {
            showToast(
                msg: state.favoritesAddingRemovingModel!.message!,
                state: ToastStates.Error);
          }
        } */
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              color: Colors.blue,
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: ConditionalBuilder(
            condition: cubit.productDetailsModel != null,
            builder: (context) {
              return Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${'${cubit.productDetailsModel!.product!.image}'}',
                                      ),
                                    ),
                                  ),
                                ),
                                if (cubit.productDetailsModel!.product!
                                        .discount >
                                    0)
                                  Container(
                                    color: Colors.red,
                                    child: Text(
                                      'DISCOUNT',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                '${'${cubit.productDetailsModel!.product!.name}'}',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${'${cubit.productDetailsModel!.product!.price}'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 20.0),
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text('EGP'),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    ShopCubit.get(context).changeFavorite(cubit
                                        .productDetailsModel!.product!.id!);
                                  },
                                  color: Colors.red,
                                  padding: EdgeInsets.all(0),
                                  icon: favorites[id]!
                                      ? Icon(Icons.favorite)
                                      : Icon(Icons.favorite_border),
                                ),
                              ],
                            ),
                            if (cubit.productDetailsModel!.product!.discount >
                                0)
                              Text(
                                '${'${cubit.productDetailsModel!.product!.oldPrice}'}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              '${'${cubit.productDetailsModel!.product!.description}'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  buildCartItem(cubit.productDetailsModel!.product),
                ],
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
