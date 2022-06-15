import 'package:flutter/material.dart';
import 'package:shop_online_mobile/components/coustom_bottom_nav_bar.dart';
import 'package:shop_online_mobile/common/enums.dart';

import '../../models/ProductCartModel.dart';
import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int numOfItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      numOfItem = ProductCartModel.carts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile, numOfItem: numOfItem),
    );
  }
}
