import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_products_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/product_details_screen/product_details_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoryProductsScreen extends StatelessWidget {
  final int categoryId;
  CategoryProductsScreen({required this.categoryId});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
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
            condition: cubit.categoryProducts != null,
            builder: (context) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: buildCategoryProductItem(context,
                              cubit.categoryProducts!.data!.data[index]),
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
                      itemCount: cubit.categoryProducts!.data!.data.length,
                    ),
                  ),
                ],
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildCategoryProductItem(context, model) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getProductDetailsById(model.id!);
        navigateTo(context, ProductDetailsScreen(model.id!));
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
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 100.0,
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
                    Row(
                      children: [
                        Text(
                          '${model.price}',
                          style: TextStyle(
                            fontSize: 20.0,
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
                          color: Colors.red,
                          padding: EdgeInsets.all(0),
                          icon: favorites[model.id]!
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                        ),
                      ],
                    ),
                    if (model.discount > 0)
                      Text('${model.oldPrice}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              decoration: TextDecoration.lineThrough)),
                    Text(
                      '${model.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildCartItem(model),
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
