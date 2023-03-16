import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favoritesModel/favorites_model.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopCubit,ShopStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
              condition: state is !ShopLoadingUserDataState,
              builder: (context) => cubit.favoritesModel!.data!.data!.length != 0 ? ListView.separated(
              physics: BouncingScrollPhysics(),
          itemBuilder: (context , index) =>  buildListProduct(cubit.favoritesModel!.data!.data![index].product,context) ,
          separatorBuilder: (context , index) => myDivider(),
          itemCount: cubit.favoritesModel!.data!.data!.length,
          ) : emptyScreen() ,
              fallback:(context) => Center(child: CircularProgressIndicator()),
          );
        }
    );
  }
  Widget emptyScreen() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Soory No Item Now!!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        )
      ],
    ),
  );
  // cubit.favoritesModel!.data!.data!.length ==0 ?
}