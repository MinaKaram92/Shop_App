import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/modules/category_products_screen/category_products_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categories != null,
          builder: (ontext) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return buildCategoryItem(
                          context, cubit.categories!.data!.categories![index]);
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: cubit.categories!.data!.categories!.length,
                  ),
                ],
              ),
            );
          },
          fallback: (ontext) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCategoryItem(context, CategoryDataModel model) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          CategoryProductsScreen(
            categoryId: model.id!,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20.0)),
          child: Center(
            child: Text(
              '${model.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
