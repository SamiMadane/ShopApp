import 'package:shop_app/models/loginModel/login_model.dart';
import 'package:shop_app/modules/login/login.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}
class LoginChangPasswordVisibilityState extends LoginStates{

}