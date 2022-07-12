import 'package:shop_app/models/home_model.dart';

class CategoryProductsModel {
  bool? status;
  DataModel? data;

  CategoryProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  int? currentPage;
  List<ProductModel> data = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(ProductModel.fromJson(element));
    });
  }
}
