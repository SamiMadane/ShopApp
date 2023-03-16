// نفس كلاس ال LoginModel عادي لو استخدمت هداك وخلص

class UserModel {
  late bool? status;
  late String? message;
  late UserData? data;

  UserModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = UserData.fromJson(json['data']);
  }
}

class UserData{
  late int? id;
  late String? name;
  late String? email;
  late String? phone;
  late String? image;
  late int? points;
  late int? credit;
  late String? token;


  UserData.fromJson(Map<String,dynamic> json)
  {

    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}