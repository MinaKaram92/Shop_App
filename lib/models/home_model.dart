class HomeModel {
  bool? status;
  DataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<BannerModel>? banners = [];
  List<ProductModel>? products = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners!.add(BannerModel.formJson(element));
    });
    json['products'].forEach((element) {
      products!.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? description;
  List<dynamic>? images;
  String? name;
  bool? inFavorite;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    images = json['images'];
    name = json['name'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
