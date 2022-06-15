import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/models/ProductCartModel.dart';
import 'package:shop_online_mobile/screens/profile/profile_screen.dart';

import '../../common/constants.dart';
import 'components/body.dart';

class OrderHistoryScreen extends StatelessWidget {
  static String routeName = "/order_history";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset("icon-arrow-down.png", width: getProportionateScreenWidth(15),),
        onPressed: () =>
            Navigator.pushNamedAndRemoveUntil(context, ProfileScreen.routeName, (route) => false),
      ),
      title: Container(
        transform: Matrix4.translationValues(70.0, 0.0, 0.0),
        child: Text("YOUR ORDERS", style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            color: Colors.black,
            fontWeight: FontWeight.w600
        )),
      ),
    );
  }
}
