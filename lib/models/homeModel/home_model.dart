// من ضمن الشاشات يلي في ال bottomNav  كان عندي شاشة home وبدي اهندلها
// بروح لل postMan وبقتح على ال home وبعمل send عشان اشوف شو عندي وبحولهم هنا لمتغيرات
class HomeModel {
  late bool status;
  late HomeDataModel data;
  // ال message سيبنا منها لانها عطول حترجعلي null
  //String message;

  //named costructor
  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data =  HomeDataModel.fromJson(json['data']);

  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  //named costructor
  HomeDataModel.fromJson(Map<String, dynamic> json){
    // هيك مش حينفع لانو ال banners عبارة عن list
    //banners = json['banners'];

    // لانها عبارة عن list ف من الطبيعي اني اعبيها بال froEach
    json['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });

    // لانها عبارة عن list ف من الطبيعي اني اعبيها بال froEach
    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

// عملت الكلاسات هاي عشان اخلي ال list من نوعها واخد راحتي فيها جوا
class BannersModel {
  // من ال postMan برضو رح  اشوف شو المتغيرات يلي جوا ال banners
  late int id ;
  late String image;
  BannersModel.fromJson(Map<String, dynamic> json)
  {
    id=json['id'];
    image=json['image'];
  }
}

class ProductsModel {
  // من ال postMan برضو رح  اشوف شو المتغيرات يلي جوا ال products
  late int id;
  dynamic price;
  //  الاسم في postMan كان old_price بس هنا رح اسميها oldPrice
  dynamic oldPrice;
  dynamic discount;
  late String image;
  late String name;
  //  الاسم في postMan كان in_favorites بس هنا رح اسميها inFavorites
  late bool inFavorites;
  //  الاسم في postMan كان in_cart بس هنا رح اسميها inCart
  late bool inCart;

  ProductsModel.fromJson(Map<String, dynamic> json){
    // الأسماء يلي جوا ال json['..']  لازم ناخدها من الpostMan مش من المتغيرات يلي فوق
    id=json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

