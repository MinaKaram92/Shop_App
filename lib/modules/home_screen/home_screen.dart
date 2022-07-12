import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/category_products_screen/category_products_screen.dart';
import 'package:shop_app/modules/product_details_screen/product_details_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ChangeFavsSuccessState) {
          if (state.favoritesAddingRemovingModel!.status == true) {
            showToast(
                msg: state.favoritesAddingRemovingModel!.message!,
                state: ToastStates.Success);
          } else {
            showToast(
                msg: state.favoritesAddingRemovingModel!.message!,
                state: ToastStates.Error);
          }
        }
      },
      builder: (context, stete) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categories != null,
          builder: (context) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              cubit.GetCategoryProducts(cubit
                                  .categories!.data!.categories![index].id!);
                              navigateTo(
                                  context,
                                  CategoryProductsScreen(
                                      categoryId: cubit.categories!.data!
                                          .categories![index].id!));
                            },
                            child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0),
                                  child: Text(
                                    '${cubit.categories!.data!.categories![index].name}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 20.0,
                        ),
                        itemCount: cubit.categories!.data!.categories!.length,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0,
                      childAspectRatio: 1 / 1.7,
                      children: List.generate(
                        cubit.homeModel!.data!.products!.length,
                        (index) {
                          return buildHomeProductItem(
                            context,
                            cubit.homeModel!.data!.products![index],
                          );
                        },
                      ),
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

  Widget buildHomeProductItem(
    context,
    ProductModel model,
  ) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getProductDetailsById(model.id!);
        navigateTo(context, ProductDetailsScreen(model.id!));
      },
      child: Container(
        //width: 200.0,
        child: Card(
          color: Colors.white,
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 90.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              '${model.image}',
                            ),
                          ),
                        ),
                      ),
                      if (model.discount > 0)
                        Container(
                          color: Colors.red,
                          child: Text(
                            'DISCOUNT',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text('EGP'),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorite(
                          model.id!,
                        );
                      },
                      color: Colors.blue,
                      padding: EdgeInsets.all(0),
                      icon: favorites[model.id]!
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                    ),
                  ],
                ),
                if (model.discount > 0)
                  Text(
                    '${model.oldPrice}',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                ConditionalBuilder(
                  condition: !inCart[model.id]!,
                  builder: (context) => Container(
                    width: double.infinity,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        ShopCubit.get(context).addToCart(model.id!);
                      },
                      child: Text('Add to cart'),
                    ),
                  ),
                  fallback: (context) {
                    return Container(
                      width: double.infinity,
                      child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          ShopCubit.get(context).addToCart(model.id!);
                        },
                        child: Text('In cart'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
