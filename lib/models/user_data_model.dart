class UserDataModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  UserDataModel({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.image,
    this.token,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'token': token,
    };
  }
}
