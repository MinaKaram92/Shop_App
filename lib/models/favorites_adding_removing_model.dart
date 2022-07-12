class FavoritesAddingRemovingModel {
  bool? status;
  String? message;

  FavoritesAddingRemovingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
