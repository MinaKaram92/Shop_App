import 'package:shop_app/models/home_model.dart';

class ProductDetailsModel {
  bool? status;
  ProductModel? product;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    product = ProductModel.fromJson(json['data']);
  }
}
