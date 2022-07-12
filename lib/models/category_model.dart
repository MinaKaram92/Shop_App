class CategoryModel {
  bool? status;
  DataModel? data;

  CategoryModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.formJson(json['data']);
  }
}

class DataModel {
  List<CategoryDataModel>? categories = [];

  DataModel.formJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      categories!.add(CategoryDataModel.formJson(element));
    });
  }
}

class CategoryDataModel {
  int? id;
  String? name;
  String? image;

  CategoryDataModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
