class AddingRemovingCartModel {
  bool? status;
  String? message;
  UpdatingCartsDataModel? data;

  AddingRemovingCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UpdatingCartsDataModel.fromJson(json['data']);
  }
}

class UpdatingCartsDataModel {
  int? id;
  int? quantity;
  UpdatingCartsProductModel? product;

  UpdatingCartsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = UpdatingCartsProductModel.fromJson(json['product']);
  }
}

class UpdatingCartsProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  UpdatingCartsProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
