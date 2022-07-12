import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/adding_removing_carts_model.dart';
import 'package:shop_app/models/carts_model.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/category_products_model.dart';
import 'package:shop_app/models/deleting_carts_model.dart';
import 'package:shop_app/models/favorites_adding_removing_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/product_details_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/models/updating_cart_quantity_model.dart';
import 'package:shop_app/models/user_data_model.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/favorites_screen/favorites_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/login_screen/shop_login_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.category,
      ),
      label: 'Category',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<String> titles = ['Home', 'Categories', 'Favorites', 'Settings'];

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeShopBomNavState());
  }

  HomeModel? homeModel;
  void getProductHome() {
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({element.id!: element.inFavorite!});
        inCart.addAll({element.id!: element.inCart!});
      });
      emit(GetHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetHomeDataErrorState(error.toString()));
    });
  }

  CategoryModel? categories;

  void getAllCategories() {
    DioHelper.getData(url: CATEGORIES).then((value) {
      categories = CategoryModel.formJson(value.data);
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoriesErrorState(error));
    });
  }

  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      favoritesAddingRemovingModel =
          FavoritesAddingRemovingModel.fromJson(value.data);
      if (favoritesAddingRemovingModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
        emit(ChangeFavsSuccessState(favoritesAddingRemovingModel));
      }
    }).catchError((error) {
      print(error.toString());
      emit(ChangeFavsErrorState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(GetFavoritesModelSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoritesModelErrorState());
    });
  }

  Map<int, int> quantities = {};

  CartsModel? cartsModel;

  void getCarts() {
    DioHelper.getData(url: CARTS, token: token).then((value) {
      cartsModel = CartsModel.fromJson(value.data);
      cartsModel!.data!.cartItems!.forEach((element) {
        quantities.addAll({
          element.product!.id!: element.quantity!,
        });
      });
      emit(GetCartsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCartsErrorState());
    });
  }

  AddingRemovingCartModel? addingRemovingCartModel;

  void addToCart(int productId) {
    inCart[productId] = !inCart[productId]!;
    DioHelper.postData(
        url: CARTS,
        token: token,
        data: {'product_id': productId}).then((value) {
      addingRemovingCartModel = AddingRemovingCartModel.fromJson(value.data);
      if (addingRemovingCartModel!.status == false) {
        inCart[productId] = !inCart[productId]!;
      } else {
        getCarts();
        emit(AddingCartSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(AddingCartErrorState());
    });
  }

  UpdatingCartQuantityModel? updatingCartQuantityModel;

  void changeQuantity(int quantity, int cartId) {
    DioHelper.updateData(
        url: '$CARTS/$cartId',
        token: token,
        data: {'quantity': quantity}).then((value) {
      updatingCartQuantityModel =
          UpdatingCartQuantityModel.fromJson(value.data);
      if (updatingCartQuantityModel!.status == true) {
        emit(ChangeCartQuantitySuccessState());
        getCarts();
        if (quantity < 1) {
          inCart[updatingCartQuantityModel!.data!.cart!.product!.id!] = false;
          deleteCart(cartId);
        }
      }
    }).catchError((error) {
      print(error.toString());
      emit(ChangeCartQuantityErrorState());
    });
  }

  DeletingCartModel? deletingCartModel;

  void deleteCart(int cartId) {
    DioHelper.deleteData(url: '$CARTS/$cartId', token: token).then((value) {
      deletingCartModel = DeletingCartModel.fromJson(value.data);
      if (deletingCartModel!.status == true) {
        inCart[deletingCartModel!.data!.cart!.product!.id!] = false;
        getCarts();
        emit(DeletingCartSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(DeletingCartErrorState());
    });
  }

  void signOut(context) {
    CacheHelper.deleteCachedData(key: 'token', context: context).then((value) {
      navigateAndFinish(context, ShopLoginScreen());
      emit(SignoutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SignoutErrorState());
    });
  }

  ProfileModel? profile;

  void getProfile() {
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profile = ProfileModel.fromJson(value.data);
      emit(GetProfileSuccessState());
    }).catchError((error) {
      emit(GetProfileErrorState());
      print(error.toString());
    });
  }

  // product details

  ProductDetailsModel? productDetailsModel;

  void getProductDetailsById(int id) {
    productDetailsModel = null;
    DioHelper.getData(url: '$PRODUCTS/$id').then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(GetProductDetailsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProductDetailsErrorState(error.toString()));
    });
  }

  // category products

  CategoryProductsModel? categoryProducts;

  void GetCategoryProducts(int categoryId) {
    categoryProducts = null;
    DioHelper.getData(url: PRODUCTS, queryparams: {'category_id': categoryId})
        .then((value) {
      categoryProducts = CategoryProductsModel.fromJson(value.data);
      emit(GetCategoryProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryProductsErrorState(error.toString()));
    });
  }
}
