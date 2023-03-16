
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';


class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (BuildContext context, state){
          // بفحص اذا كنت انا بال state تبعت ال success
          if(state is LoginSuccessState){
            print ('LoginSuccessState');
            // بفحص ال status اذا كانت true or false
            if (state.loginModel.status == true){
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token,
              ).then((value){
                token = state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            }
            else
            {
              print(state.loginModel.message);
              showToast(text:(state.loginModel.message)!,state:ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.bold,
                            color:Colors.black),
                        ),
                        Text('Login now to browes our hot offers',style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),),
                         const SizedBox(height: 30,),
                        defaultFormFiled(
                          newcontroller: emailController,
                          text: 'Email Address',
                          textValidator: 'please enter your email address',
                          prefixIcon: const Icon(Icons.email),
                          keyboardType:TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15,),
                        defaultFormFiled (
                          newcontroller: passwordController,
                          text: 'Password',
                          textValidator: 'password is too short',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: (){
                                LoginCubit.get(context).changePasswordVisibility();
                          },
                              icon:Icon(LoginCubit.get(context).suffix),
                          ),
                          keyboardType:TextInputType.visiblePassword,
                          obscureText: LoginCubit.get(context).obscureText,
                          // عشان بعد ما احط الباسورد واحط صح كاني ضغطت login
                          onSubmit: (value){
                            if (formKey.currentState!.validate()){
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          }

                        ),
                        const SizedBox(height: 30,),

                        ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defaultButton(
                                function: (){
                                  if (formKey.currentState!.validate()){
                                    LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'login',
                                isUpperCase: true
                            ),
                            fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?',style: const TextStyle(fontWeight: FontWeight.bold),),
                            defaultTextButton(function: (){
                              navigatorTo(context, RegisterScreen());
                            }, text: 'Register',isBold: true),
                          ],
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
