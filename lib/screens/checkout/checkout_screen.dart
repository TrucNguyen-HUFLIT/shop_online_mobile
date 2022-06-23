import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';

import 'components/body.dart';

class CheckOutScreen extends StatefulWidget {
  static String routeName = "/check_out";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool isChargedPaypal = false;

  setCharged() {
    setState(() {
      isChargedPaypal = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: !isChargedPaypal
            ? buildAppBar(context)
            : buildAppBarWithoutLeading(context),
        body: Body(setCharged: setCharged),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset(
          "icon-arrow-down.png",
          width: getProportionateScreenWidth(15),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Container(
        transform: Matrix4.translationValues(55.0, 0.0, 0.0),
        child: Text("CHECKING OUT",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                color: Colors.black,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  AppBar buildAppBarWithoutLeading(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        transform: Matrix4.translationValues(110.0, 0.0, 0.0),
        child: Text("CHECKING OUT",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                color: Colors.black,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
