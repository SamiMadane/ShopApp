import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesModel/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context , index) => buildCatItem(cubit.categoriesModel!.data!.data[index]) ,
          separatorBuilder: (context , index) => myDivider(),
          itemCount: cubit.categoriesModel!.data!.data.length,
        );
      }
    );
  }

  Widget buildCatItem(DataModel data) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${data.image}'),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20,),
        Text(
          '${data.name}',
          maxLines: 1,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.arrow_forward_ios_outlined)
        ),
      ],
    ),
  );
}
