
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'modules/onBoarding/on_boarding.dart';

void main() async {
  //  بتأكد انه كل حاجة هنا خلصت من الميثود وبعدين بشغل الابليكيشن (مهمة)
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  var onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print ('token is : ${token}');
  // عرفت متغيرwidget
  Widget widget;
  // بدي افحص انا شو خلصت وشو ما خلصت من السكرينات ولوين واصل اسجل بالمتغير widget
  if (onBoarding != null){
    if (token != null) widget = ShopLayout();
    else widget = LoginScreen();
  }else{
    widget = onBoardingScreen();
  }
  // حبعت المتغير يلي فيه الشاشةيلي واصللها انا لشاشة البداية
  runApp(
      MyApp(startWidget: widget,)
  );

}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({
     required this.startWidget,
});

  @override
  Widget build(BuildContext context) {
    // Provider بشكل عام عشان اوصله من اي مكان بالتطبيق
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme:darkTheme ,
        home:startWidget,

      ),
    );
  }
}
