import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/onBoarding/on_boarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initState(){
    super.initState();
    Timer(Duration(seconds: 3),
        ()=>Navigator.pushReplacement(context, 
        MaterialPageRoute(builder: (context) => onBoardingScreen(),
        ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: Image(
                  image: AssetImage('assets/images/shopping.png')
              ),
            ),
            SizedBox(height: 20,),
            Text('MyShop',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),),
            SizedBox(height: 20,),
            Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
