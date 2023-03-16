import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper/dio_helper.dart';

import '../../../shared/network/remote/end_point.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

   static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel ;

   void userLogin({
  required String email,
  required String password,
}){
     emit(LoginLoadingState());
     DioHelper.postData(
       // هاي ال LOGIN هي ال endPoint
         url: LOGIN,
         // هاي ال data جبناها من postman برضو من ال login بعدين body
         data: {
           'email':email,
           'password':password,
         }
     ).then((value) {
       print('success login');
       print(value!.data);
       loginModel = LoginModel.fromJson(value.data);
       print('success login 222222');
       emit(LoginSuccessState(loginModel));
     }).catchError((error){
       print('error login');
       print(error.toString());
       emit(LoginErrorState(error.toString()));
     });
   }
// لاخفاء واظهار كلمة السر
   IconData suffix = Icons.visibility;
   bool obscureText = true;
   void changePasswordVisibility(){
     obscureText = !obscureText;
     suffix = obscureText ? Icons.visibility : Icons.visibility_off;
     emit(LoginChangPasswordVisibilityState());
   }


}