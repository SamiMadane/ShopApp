
import 'package:shop_app/models/loginModel/login_model.dart';

import '../../models/favoritesModel/change_favorites_model.dart';
import '../../models/userModel/user_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates {}
class ShopChangeBottomNavState extends ShopStates {}
class ShopLoadingHomeState extends ShopStates {}
class ShopSuccessHomeState extends ShopStates {}
class ShopErrorHomeState extends ShopStates {
  final String error;

  ShopErrorHomeState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}
class ShopErrorCategoriesState extends ShopStates {
  final String error;

  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavoritesState extends ShopStates {}
class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates {}
class ShopSuccessGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {
  final String error;

  ShopErrorGetFavoritesState(this.error);
}

class ShopLoadingUserDataState extends ShopStates {}
class ShopSuccessUserDataState extends ShopStates {
  final UserModel userModel;

  ShopSuccessUserDataState(this.userModel);
}
class ShopErrorUserDataState extends ShopStates {
  final String error;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserState extends ShopStates {}
class ShopSuccessUpdateUserState extends ShopStates {
  final UserModel userModel;

  ShopSuccessUpdateUserState(this.userModel);
}
class ShopErrorUpdateUserState extends ShopStates {
  final String error;

  ShopErrorUpdateUserState(this.error);
}