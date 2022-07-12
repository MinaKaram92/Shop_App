import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/on_boarding_model.dart';
import 'package:shop_app/modules/login_screen/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageControllder = PageController();

  bool islastOnboarding = false;

  List<OnboardingModel> onboardingModel = [
    OnboardingModel(
      image: 'assets/photo1.jpg',
      title: 'Shop App',
      text: 'A simple Shopping app to buy your needs',
    ),
    OnboardingModel(
      image: 'assets/photo3.png',
      text: 'Lets go to buy some products',
    ),
  ];

  void gotoLayout() {
    CacheHelper.saveData('islastOnboarding', islastOnboarding).then((value) {
      navigateAndFinish(context, ShopLoginScreen());
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      islastOnboarding = true;
                    });
                    gotoLayout();
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.blue, fontSize: 20.0),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return buildOnBoardingScreen(
                        context, onboardingModel[index]);
                  },
                  physics: BouncingScrollPhysics(),
                  allowImplicitScrolling: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: onboardingModel.length,
                  controller: pageControllder,
                  onPageChanged: (index) {
                    if (index == onboardingModel.length - 1) {
                      setState(() {
                        islastOnboarding = true;
                      });
                    } else {
                      setState(() {
                        islastOnboarding = false;
                      });
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 30.0,
                    child: SmoothPageIndicator(
                      controller: pageControllder,
                      count: onboardingModel.length,
                      axisDirection: Axis.horizontal,
                      effect: ExpandingDotsEffect(
                        expansionFactor: 3,
                        activeDotColor: Colors.blue,
                        dotColor: Colors.black,
                        spacing: 10.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    child: Icon(
                      Icons.forward,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (islastOnboarding) {
                        gotoLayout();
                      } else {
                        pageControllder.nextPage(
                          duration: Duration(seconds: 5),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOnBoardingScreen(context, OnboardingModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          height: 250.0,
          image: AssetImage(model.image!),
        ),
        if (model.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              model.title!,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.blue,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        if (model.title == null)
          SizedBox(
            height: 50.0,
          ),
        Text(
          model.text!,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
