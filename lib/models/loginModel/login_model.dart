class LoginModel {
//  بدي احط فيه داتا بناء على شكلها في postman
// حيكون في عندي  status و message وكمان كلاس تاني جوا هاد الكلاس اسمه data
 late bool? status;
 late String? message;
 late UserData? data;

// named constructor
LoginModel.fromJson(Map<String,dynamic> json)
{
  status = json['status'];
  message = json['message'];
  // هسا ال status وال message اجباري برجعو بقيم اما ال data ممكن ما ترجعلي قيم وترجع null
  // هنا بفحص اذا كان عندي ال data لا تساوي null يبقا جبلي التفاصيل من الكلاس التاني
  data = json['data'] !=null ? UserData.fromJson(json['data']) : null;
}
}

// هاد الكلاس التاني حستخدمه جوا الكلاس الاول لانه هو فيه متغيرات بحتاجها برضو
class UserData{
  late int? id;
  late String? name;
  late String? email;
  late String? phone;
  late String? image;
  late int? points;
  late int? credit;
  late String? token;
// هاد الكونستركتور الطبيعي بدناش ياه هان في الاحسن منه
//   UserData({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.image,
//     required this.points,
//     required this.credit,
//     required this.token,
// });

// الأفضل نستخدم ال named constructor
  UserData.fromJson(Map<String,dynamic> json)
  {
  // هاد اسم مني مش مهم شو هو fromJson
    // بعتت map لانو الداتا حترجعلي بشكل  map وسميتها json

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