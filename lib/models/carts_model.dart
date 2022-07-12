class CartsModel {
  bool? status;
  CartsDataModel? data;

  CartsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CartsDataModel.fromJson(json['data']);
  }
}

class CartsDataModel {
  List<CartItemModel>? cartItems = [];

  CartsDataModel.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((element) {
      cartItems!.add(CartItemModel.fromJson(element));
    });
  }
}

class CartItemModel {
  int? id;
  int? quantity;
  CartProductModel? product;

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = CartProductModel.fromJson(json['product']);
  }
}

class CartProductModel {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? description;
  String? name;
  List<dynamic>? images;

  CartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    image = json['image'];
    name = json['name'];
    discount = json['discount'];
    description = json['description'];
    images = json['images'];
  }
}
