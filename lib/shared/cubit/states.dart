import 'package:shop_app/models/favorites_adding_removing_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ChangeShopBomNavState extends ShopStates {}

class GetHomeDataLoadingState extends ShopStates {}

class GetHomeDataSuccessState extends ShopStates {}

class GetHomeDataErrorState extends ShopStates {
  String error;
  GetHomeDataErrorState(this.error);
}

class GetCategoriesLoadingState extends ShopStates {}

class GetCategoriesSuccessState extends ShopStates {}

class GetCategoriesErrorState extends ShopStates {
  String error;
  GetCategoriesErrorState(this.error);
}

//favorites
class ChangeFavsSuccessState extends ShopStates {
  FavoritesAddingRemovingModel? favoritesAddingRemovingModel;
  ChangeFavsSuccessState(this.favoritesAddingRemovingModel);
}

class ChangeFavsErrorState extends ShopStates {
  String error;
  ChangeFavsErrorState(this.error);
}

class GetFavoritesModelSuccessState extends ShopStates {}

class GetFavoritesModelErrorState extends ShopStates {}

class GetCartsSuccessState extends ShopStates {}

class GetCartsErrorState extends ShopStates {}

class AddingCartSuccessState extends ShopStates {}

class AddingCartErrorState extends ShopStates {}

class ChangeCartQuantitySuccessState extends ShopStates {}

class ChangeCartQuantityErrorState extends ShopStates {}

class DeletingCartSuccessState extends ShopStates {}

class DeletingCartErrorState extends ShopStates {}

class GetProfileSuccessState extends ShopStates {}

class GetProfileErrorState extends ShopStates {}

class LogoutSuccessState extends ShopStates {}

class LogoutErrorState extends ShopStates {}

class SignoutSuccessState extends ShopStates {}

class SignoutErrorState extends ShopStates {}

// details

class GetProductDetailsLoadingState extends ShopStates {}

class GetProductDetailsSuccessState extends ShopStates {}

class GetProductDetailsErrorState extends ShopStates {
  final String error;
  GetProductDetailsErrorState(this.error);
}

// category products

class GetCategoryProductsLoadingState extends ShopStates {}

class GetCategoryProductsSuccessState extends ShopStates {}

class GetCategoryProductsErrorState extends ShopStates {
  String? error;
  GetCategoryProductsErrorState(error);
}
