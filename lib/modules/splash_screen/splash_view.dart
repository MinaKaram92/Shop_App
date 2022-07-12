import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/login_screen/shop_login_screen.dart';
import 'package:shop_app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 5),
      () {
        print('boardingFinished : $boardingFinished');
        if (boardingFinished != null) {
          if (token != null) {
            navigateAndFinish(context, ShopLayout());
          } else {
            navigateAndFinish(context, ShopLoginScreen());
          }
        } else {
          navigateAndFinish(context, OnboardingScreen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Shop App',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.blue,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Image(
                  height: 200.0,
                  image: AssetImage('assets/splash.png'),
                ),
              ),
              Text(
                'Welcome to Shop App',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.blue, fontSize: 30.0),
              ),
              SizedBox(
                height: 50.0,
              ),
              CircularProgressIndicator(
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
