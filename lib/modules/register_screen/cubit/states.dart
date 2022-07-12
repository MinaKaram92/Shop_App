import 'package:shop_app/models/register_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  UserRegisterModel? userRegisterModel;
  ShopRegisterSuccessState(this.userRegisterModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ChangeSuffixStatusRegisterState extends ShopRegisterStates {}
