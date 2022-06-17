import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/constants.dart';
import 'package:shop_online_mobile/screens/home/home_screen.dart';
import 'package:shop_online_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:uiblock/uiblock.dart';

// This is the best practice
import '../../../helper/sharedPreferenceHelper.dart';
import '../../../helper/shopToast.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Dreams store, Let’s shop!",
      "image": "assets/icons/icon-title.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(flex: 3),
                    DefaultButton(
                      text: "Let's shop",
                      press: () async {
                        var tokenLogged =
                            await SharedPreferenceHelper().getUserToken();

                        var isLogged = tokenLogged.toString().isNotEmpty;
                        await SharedPreferenceHelper().getCarts();
                        if (isLogged) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeScreen.routeName,
                              (Route<dynamic> route) => false);
                          Future.delayed(const Duration(milliseconds: 500), () {
                            ShopToast.SuccessfullyToast("Login successfully");
                          });
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              SignInScreen.routeName,
                              (Route<dynamic> route) => false);
                        }
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
