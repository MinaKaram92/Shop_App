import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/favorites_adding_removing_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/category_products_screen/category_products_screen.dart';
import 'package:shop_app/modules/product_details_screen/product_details_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

Widget defaultTextFormField({
  String? label,
  IconData? prefix,
  IconData? suffix,
  String? hint,
  Function? submit,
  Function? changed,
  Function? validate,
  VoidCallback? tap,
  VoidCallback? suffixPressed,
  TextEditingController? controller,
  bool suggestions = true,
  TextInputType? type,
  bool isPassword = false,
  TextStyle? textStyle,
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
              icon: Icon(suffix),
              onPressed: suffixPressed,
            )
          : null,
      hintText: hint,
      border: OutlineInputBorder(),
    ),
    onFieldSubmitted: (value) {
      if (submit != null) {
        submit(value);
      }
    },
    onChanged: (value) {
      if (changed != null) {
        changed(value);
      }
    },
    validator: (value) {
      if (validate != null) {
        return validate(value);
      }
    },
    onTap: tap,
    controller: controller,
    enableSuggestions: suggestions,
    keyboardType: type,
    obscureText: isPassword,
    style: textStyle,
  );
}

Widget defaultMaterialButton({
  required String? text,
  double? textSize,
  Color? color,
  double? elevation,
  double? height,
  Color? textColor,
  ButtonTextTheme? textTheme,
  double? minWidth,
  required VoidCallback pressed,
}) {
  return MaterialButton(
    child: Text(
      text!,
      style: TextStyle(fontSize: textSize),
    ),
    color: color,
    elevation: elevation,
    height: height,
    textColor: textColor,
    textTheme: textTheme,
    minWidth: minWidth,
    onPressed: pressed,
  );
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

enum ToastStates {
  Success,
  Error,
  Warning,
}

Color selectColorBasedStates(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.Success:
      color = Colors.green;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}

void showToast({
  required String msg,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: selectColorBasedStates(state),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    textColor: Colors.white,
  );
}

Widget buildCartItem(model) {
  return ConditionalBuilder(
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
  );
}

/* Widget favCartsBuilder({required List list,required Widget widget}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) {
      return ListView.separated(
        itemBuilder: (context, index) {
          return widget(index);
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,
          ),
        ),
        itemCount: list.length,
      );
    },
    fallback: (context) => Center(
        child: Text(
      'There are no items',
      style: TextStyle(
        fontSize: 20.0,
      ),
    )),
  );
} */
