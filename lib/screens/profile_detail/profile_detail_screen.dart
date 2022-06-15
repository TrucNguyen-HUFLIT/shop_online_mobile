import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';

import 'components/body.dart';

class ProfileDetailScreen extends StatelessWidget {
  static String routeName = "/profile_detail";
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
              Navigator.pop(context),
        ),
      title: Container(
        transform: Matrix4.translationValues(20.0, 0.0, 0.0),
        child: Text("YOUR INFORMATION", style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            color: Colors.black,
            fontWeight: FontWeight.w600
        )),
      ),
    );
  }
}
