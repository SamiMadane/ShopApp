import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/styles/colors.dart';

class SerachScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormFiled(
                      newcontroller: searchController,
                      text: 'Search',
                      prefixIcon: Icon(Icons.search),
                      textValidator: 'Enter the text you want to search for !!',
                      keyboardType: TextInputType.text,
                      onSubmit: (String text){
                        if (formKey.currentState!.validate())
                          SearchCubit.get(context).search(text);

                      },
                    ),
                    SizedBox(height: 20,),
                    if (state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context , index) =>  buildListProduct(cubit.model.data!.data[index], context,isOldPrice: false) ,
                        separatorBuilder: (context , index) => myDivider(),
                        itemCount: cubit.model.data!.data.length ,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}