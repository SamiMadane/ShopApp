import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper/dio_helper.dart';

class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // CircleAvatar(
                  //   radius: 50,
                  //   child: Image(image: NetworkImage('${ cubit.userModel!.data!.image!}')),
                  // ),
                  // SizedBox(height: 20,),
                  if (state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  defaultFormFiled(
                    newcontroller: nameController,
                    text: 'Name',
                    keyboardType: TextInputType.name,
                    textValidator: 'Name must not be empty',
                    prefixIcon: Icon(Icons.person),
                  ),
                  SizedBox(height: 20,),

                  defaultFormFiled(
                    newcontroller: emailController,
                    text: 'Name',
                    keyboardType: TextInputType.emailAddress,
                    textValidator: 'Email must not be empty',
                    prefixIcon: Icon(Icons.email),
                  ),
                  SizedBox(height: 20,),

                  defaultFormFiled(
                    newcontroller: phoneController,
                    text: 'Phone',
                    keyboardType: TextInputType.emailAddress,
                    textValidator: 'Phone must not be empty',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  SizedBox(height: 30,),

                  defaultButton(
                    function: (){
                      if(formKey.currentState!.validate()){
                        cubit.updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'UPDATE',
                  ),
                  SizedBox(height: 20,),
                  defaultButton(
                      function: (){
                        singOut(context);
                        },
                      text: 'LOGOUT',
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}