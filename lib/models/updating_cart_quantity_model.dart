class UpdatingCartQuantityModel {
  bool? status;
  String? message;
  UpdatingCartDataModel? data;

  UpdatingCartQuantityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UpdatingCartDataModel.fromJson(json['data']);
  }
}

class UpdatingCartDataModel {
  UpdatingCartModel? cart;

  UpdatingCartDataModel.fromJson(Map<String, dynamic> json) {
    cart = UpdatingCartModel.fromJson(json['cart']);
  }
}

class UpdatingCartModel {
  int? id;
  int? quantity;
  UpdatingCartProductModel? product;

  UpdatingCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = UpdatingCartProductModel.fromJson(json['product']);
  }
}

class UpdatingCartProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  UpdatingCartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
