import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoriesModel/categories_model.dart';
import 'package:shop_app/models/homeModel/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (BuildContext context, state) {
          if (state is ShopSuccessChangeFavoritesState){
            if (!state.model.status){
              showToast(text: state.model.message, state:ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
                condition: cubit.homeModel != null && cubit.categoriesModel != null ,
              builder: (context) => ProductsBuilder(cubit.homeModel,cubit.categoriesModel,context),
              fallback: (context) => Center(child: CircularProgressIndicator())
          );
        }
    );
  }

  Widget ProductsBuilder(HomeModel? model ,CategoriesModel? categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          // ال item محتاج list of widget  بجيب من homeModel ال banner وبمر عليه وحدة وحدة وباخد الصورة
            items: model!.data.banners.map((e) =>Image(
                image: NetworkImage('${e.image}'),
                fit: BoxFit.cover,
                width: double.infinity,)
            ).toList(),
            options: CarouselOptions(
              // الطول
              height: 200,
              // حبدأ من أول صورة
              initialPage: 0,
              // عشان الصورة تملئ الصفحة
              viewportFraction: 1.0,
              // يضل يلف
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              // التحريك التلقائي كل 3 ثواني بغير الصورة لحاله
              autoPlayInterval: Duration(seconds: 3),
              // مدة الانتقال ثانية
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index) => buildCategoryItem(categoriesModel!.data!.data[index]),
                    separatorBuilder: (context , index) => SizedBox(width: 10,),
                    itemCount: categoriesModel!.data!.data.length),
              ),
              SizedBox(height: 20,),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.grey[300],
          child: GridView.count (
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            // مسافات من الأعلى والأسفل
            mainAxisSpacing: 1,
            // مسافات من الجوانب
            crossAxisSpacing: 1,
            // العرض الاول على الطول
            childAspectRatio: 1 / 1.74,
            children: List.generate(
                model.data.products.length,
                    (index) => buildGridProducts( model.data.products[index],context)),
          ),
        ),
      ],
    ),
  );

  Widget buildGridProducts(ProductsModel model,context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200,
            ),
            if (model.discount != 0)
              Container(
              color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8
                  ),
                )
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(width: 5,),
                  if (model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      // بحط خط على السعر القديم
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: (ShopCubit.get(context).favorites[model.id])! ? Colors.red : Colors.grey,
                    child: IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id);
                        print(model.id);
                      },
                      icon: Icon(Icons.favorite),
                      iconSize: 14,
                      color: Colors.white ,
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),

      ],
    ),
  );

  Widget buildCategoryItem([DataModel? data]) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(
        image: NetworkImage('${data!.image}'),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        // تعتيم
        color: Colors.black.withOpacity(0.8),
        width: 100,
        child: Text(
          '${data.name}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}