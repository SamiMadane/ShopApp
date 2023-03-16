import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}
class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(image: 'assets/images/onboarding.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body',
    ),
    BoardingModel(image: 'assets/images/onboarding.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body',
    ),
    BoardingModel(image: 'assets/images/onboarding.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body',
    ),
  ];

  var boardController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: (){
                submit();
                },
              text: 'skip'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if (index == boarding.length-1){
                    setState((){
                      isLast = true;
                    });
                  }else{
                    setState((){
                      isLast = false;
                    });
                }
                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: defaultColor,
                      spacing: 5,
                      expansionFactor: 4,
                    ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if (isLast){
                      submit();
                    }else{
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,);
                    }
                },
                  child: Icon(Icons.arrow_forward_ios),),
              ],
            ),
          ],
        ),
      ) ,
    );
  }

// دالة عشان لمااضغط سكيب اواخلص من الon boardin انتقل للشاشة التالية واحفظ بال sharedPrefrence اني خلصت هنا
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value){
        navigateAndFinish(context, LoginScreen());
      }
    });
  }
  Widget buildBoardingItem (BoardingModel model) =>  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'),)),
      SizedBox(height: 30,),
      Text('${model.title}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
      SizedBox(height: 15,),
      Text('${model.body}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
    ],
  );
}
