import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper/dio_helper.dart';

import '../../../shared/network/remote/end_point.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel ;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(
      // هاي ال Register هي ال endPoint
        url: REGISTER,
        // هاي ال data جبناها من postman برضو من ال Register بعدين body
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value) {
      print('trueeeeeeeeeeeeeeeeeee');
      loginModel = LoginModel.fromJson(value!.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      print ('falseeeeeeeeeeeeeee');
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
// لاخفاء واظهار كلمة السر
  IconData suffix = Icons.visibility;
  bool obscureText = true;
  void changePasswordVisibility(){
    obscureText = !obscureText;
    suffix = obscureText ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangPasswordVisibilityState());
  }


}