import 'package:flutter/material.dart';
import 'package:shop_online_mobile/components/coustom_bottom_nav_bar.dart';
import 'package:shop_online_mobile/common/enums.dart';

import '../../models/ProductCartModel.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home, numOfItem: numOfItem),
    );
  }
}
