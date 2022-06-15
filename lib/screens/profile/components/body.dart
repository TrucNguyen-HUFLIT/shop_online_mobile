import 'package:flutter/material.dart';
import 'package:shop_online_mobile/helper/sharedPreferenceHelper.dart';
import 'package:shop_online_mobile/screens/order_history/order_history_screen.dart';
import 'package:shop_online_mobile/screens/profile_detail/profile_detail_screen.dart';
import 'package:shop_online_mobile/screens/sign_in/sign_in_screen.dart';

import '../../../common/size_config.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(70)),
          ProfilePic(),
          SizedBox(height: getProportionateScreenHeight(30)),
          ProfileMenu(
            text: "My Information",
            icon: "assets/icons/User Icon.svg",
            press: () =>
                Navigator.pushNamed(context, ProfileDetailScreen.routeName),
          ),
          ProfileMenu(
            text: "Order History",
            icon: "assets/icons/User Icon.svg",
            press: () =>
                Navigator.pushNamed(context, OrderHistoryScreen.routeName),
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              await SharedPreferenceHelper().setUserToken(userToken: '');
              Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, (Route<dynamic> route) => false);
            }
          ),
        ],
      ),
    );
  }
}
