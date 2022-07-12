class DeletingCartModel {
  bool? status;
  String? message;
  DeletingCartDataModel? data;

  DeletingCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = DeletingCartDataModel.fromJson(json['data']);
  }
}

class DeletingCartDataModel {
  DeletingDataCartModel? cart;

  DeletingCartDataModel.fromJson(Map<String, dynamic> json) {
    cart = DeletingDataCartModel.fromJson(json['cart']);
  }
}

class DeletingDataCartModel {
  int? id;
  int? quantity;
  DeletingCartProductModel? product;

  DeletingDataCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = DeletingCartProductModel.fromJson(json['product']);
  }
}

class DeletingCartProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  DeletingCartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
