class FavoritesModel {
  bool? status;
  FavoritesDataModel? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = FavoritesDataModel.fromJson(json['data']);
  }
}

class FavoritesDataModel {
  int? currentPage;
  List<FavoritesDataProductsModel> data = [];

  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(FavoritesDataProductsModel.fromJson(element));
    });
  }
}

class FavoritesDataProductsModel {
  int? id;
  FavoriteProductModel? product;

  FavoritesDataProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = FavoriteProductModel.fromJson(json['product']);
  }
}

class FavoriteProductModel {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? description;
  String? name;

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    image = json['image'];
    name = json['name'];
    discount = json['discount'];
    description = json['description'];
  }
}
