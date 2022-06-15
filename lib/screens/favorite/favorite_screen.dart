import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/components/coustom_bottom_nav_bar.dart';
import 'package:shop_online_mobile/common/enums.dart';

import '../../models/ProductCartModel.dart';
import 'components/body.dart';

class FavoriteScreen extends StatefulWidget {
  static String routeName = "/favorite";

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
      appBar: AppBar(
        title:  Align(
            alignment: Alignment.center,
            child: Text("FAVORITE", style: TextStyle(
                fontSize: getProportionateScreenWidth(22),
                color: Colors.black,
                fontWeight: FontWeight.w600
            ),)
        ),
        automaticallyImplyLeading: false,
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favorite, numOfItem: numOfItem),
    );
  }
}
