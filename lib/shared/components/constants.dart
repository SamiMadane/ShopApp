import 'package:flutter/cupertino.dart';

import '../../modules/login/login.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void singOut(contex){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value){
      navigateAndFinish(contex, LoginScreen());
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}
// هاي مخزنة في ال main بس يلي في ال main مش حقدر اوصللها بال cubit ف حطيتها هنا constants
String? token = '';