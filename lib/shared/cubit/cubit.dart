import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesModel/categories_model.dart';
import 'package:shop_app/models/favoritesModel/favorites_model.dart';
import 'package:shop_app/models/homeModel/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper/dio_helper.dart';

import '../../models/favoritesModel/change_favorites_model.dart';
import '../../models/userModel/user_model.dart';
import '../network/remote/end_point.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  // قائمة فيها الشاشات يلي رح اتنقل بينهم
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  // فانكشن عشان لما اضغط على عنصر من الbottomNav يرجعلي ال index تبعها واحطه بالحالي
  void changeBottom (int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  // هنا بدي اعمل Toogel اذا العنصر بالمفضلة ولا لا و بدل ما استخدم list بدي استخدم map
  // بعتت int عشان بتعبر عن ال id وبعتت bool عشان بتعبر عن حالة العنصر اذا هو بال favorite ولا لا
  Map <int , bool> favorites = {};
  void getHomeData(){
    emit(ShopLoadingHomeState());
    DioHelper.getData(
        url: Home,
      // هاي ال token مخزنة في ال constants
      token: token,
    ).then((value){
      // print('Success get data');
      homeModel = HomeModel.fromJson(value!.data);
      // printFullText(homeModel!.data!.banners[0].image!);

      // هيك بمر ع كل عنصر من عناصر ال products
      homeModel!.data.products.forEach((element)
      {
        // بضيف على ال map  ال id حالته لكل عنصر
        favorites.addAll({
          element.id : element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeState());
    }).catchError((error){
      // print('Error');
      print(error.toString());
      emit(ShopErrorHomeState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value){
      print('Success');
      categoriesModel = CategoriesModel.fromJson(value!.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print('Error');
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }


  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites (int productID){
    // بعكس الحالة من صح لخطأ والعكس عشان القلب ينور ويطفي بنفس لحظة الضغط
    favorites[productID] = !(favorites[productID])! ;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          // يلي بين علمتين تنصيص من ال postman من ال body
          'product_id':productID,
        },
         token: token,
    ).then((value) {
      // print('success change favorites');
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value!.data);
      print(value.data);

      // لو كان في مشكلة معينة ارجع اعكسلي الضو عشان يرجع للاصلي وميتغيرش زي ما بدو المستخدم عشان يفهم انو في مشكلة
      if (!changeFavoritesModel!.status){
        favorites[productID] = !(favorites[productID])! ;
      }else{
        // لما تكون تمام وصحيحة بدي اعمل getFavorites تاني عشان يحدث
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));

    }).catchError((error){
      // print('error change favorites');
      print(error.toString());
      // لو كان في مشكلة معينة ارجع اعكسلي الضو عشان يرجع للاصلي وميتغيرش زي ما بدو المستخدم عشان يفهم انو في مشكلة
      favorites[productID] = !(favorites[productID])! ;
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
        url: FAVORITES,
        lang: 'en',
        token: token,
    ).then((value){
      // print('Success get favorites');
      favoritesModel = FavoritesModel.fromJson(value!.data);
      // printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      // print('Error get favorites');
      print (error.toString());
      emit(ShopSuccessGetFavoritesState());
    });
  }

  UserModel? userModel;
  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value){
      print('Success get user data');
      userModel = UserModel.fromJson(value!.data);
      print(userModel!.data!.name);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error){
      print('Error get user data');
      print (error.toString());
      emit(ShopErrorUserDataState(error));
    });
  }

  void updateUserData({
  required String name,
  required String email,
  required String phone,
}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
      token: token,
    ).then((value){
      print('Success update user data');
      userModel = UserModel.fromJson(value!.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error){
      print('Error get user data');
      print (error.toString());
      emit(ShopErrorUpdateUserState(error));
    });
  }

}
