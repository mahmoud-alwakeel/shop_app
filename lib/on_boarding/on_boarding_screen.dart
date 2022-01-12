import 'package:flutter/material.dart';
import 'package:shopp_app/modules/login/login_screen.dart';
import 'package:shopp_app/shared/components/components.dart';
import 'package:shopp_app/shared/network/local/cache_helper.dart';
import 'package:shopp_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
});
}
class OnBoardingScreen extends StatefulWidget
{
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard1.jpeg',
        title: 'onBoard title 1',
        body: 'onBoard 1 body'),
    BoardingModel(
        image: 'assets/images/onboard1.jpeg',
        title: 'onBoard title 2',
        body: 'onBoard 2 body'),
    BoardingModel(
        image: 'assets/images/onboard1.jpeg',
        title: 'onBoard title 3',
        body: 'onBoard 3 body'),
  ];

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key:'onBoarding' ,value: true).then((value) {
      if(value){
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          defaultTextButton(
              function: submit,
              text: 'skip',
        ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index)
                {
                  if(index == boarding.length - 1)
                  {
                    setState(() {
                      isLast = true;
                    });
                    print('last');
                  }else{
                    setState(() {
                      isLast = false;
                    });
                    print('not last');
                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotWidth: 10,
                      spacing: 4,
                      dotHeight: 10,
                      expansionFactor: 5,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast)
                      {
                        submit();
                        //print('login screen');
                        //navigateTo(context, LoginScreen());
                      }else{
                        boardController.nextPage(
                          duration: Duration(
                              milliseconds: 750
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,);

                      }

                    },

                child: Icon(
                  Icons.arrow_forward_ios
                ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage('${model.image}')
        ),
      ),

      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
          height: 30.0),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
          height: 30.0),
    ],
  );
}
