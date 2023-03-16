
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubit/cubit.dart';
import '../styles/colors.dart';

void navigatorTo (context,Widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => Widget
  ),
);
void navigateAndFinish (context,Widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context) => Widget
  ),
    (Route<dynamic> route) => false,
);
Widget myDivider () => Padding(
  padding: const EdgeInsetsDirectional.only(start: 10),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,
  ),
);
Widget defaultButton(
    {
      var color = Colors.blue,
      double width = double.infinity,
      bool isUpperCase = true,
      required VoidCallback function ,
      required String text ,

    }) =>  Container(
  color: color,
  width: width,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      '${isUpperCase?text.toUpperCase():text}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color:Colors.white,
      ),
    ),

  ),
);

Widget defaultFormFiled({
  double radius = 0 ,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  TextInputType? keyboardType,
  VoidCallback? onTap,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  bool obscureText = false,
  required TextEditingController newcontroller,
  required String text,
  String textValidator = '',


}) => TextFormField(
  validator: (value) {
    if (value!.isEmpty){
      return '${textValidator}';
    }
    return null;
  },
  obscureText:obscureText,
  controller: newcontroller,
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    labelText: text,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
  ),
  keyboardType: keyboardType,
  onTap:onTap,
  onChanged: onChange,
  onFieldSubmitted: onSubmit ,

);

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
  bool isBold = false,
  Color color = Colors.blue,
}) => TextButton(onPressed: function, child: Text(text.toUpperCase(),
  style: isBold? TextStyle(fontWeight: FontWeight.bold,color: color):TextStyle(fontWeight: FontWeight.normal),
)
);

// ************************************************
void showToast({
  required String text,
  required ToastStates state,
})=>Fluttertoast.showToast(
  msg: text,
  // وقت للاندرويد
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  // وقت لل ios و web
  timeInSecForIosWeb: 5,
  backgroundColor: choseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);
// لما اكون بدي اختار شي من اكتر من شي
enum ToastStates {SUCCESS,ERROR,WARNING}

Color choseToastColor(ToastStates state){
  Color color;
  switch (state){
    case ToastStates.SUCCESS:
    color = Colors.green;
    break;
    case ToastStates.ERROR:
    color = Colors.red;
    break;
    case ToastStates.WARNING:
    color = Colors.yellow;
    break;
  }
  return color;
}
// ************************************************

Widget buildListProduct(model , context , {
  bool isOldPrice = true,
}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120,
              height: 120,
            ),
            if (model.discount != 0 && isOldPrice)
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
        Expanded(
          child: Padding(
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
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                        fontSize: 12,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 5,),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        '${model.oldPrice}',
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
        ),

      ],
    ),
  ),
);
