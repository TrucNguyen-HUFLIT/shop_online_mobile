import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_online_mobile/screens/cart/cart_screen.dart';
import 'package:shop_online_mobile/screens/favorite/favorite_screen.dart';
import 'package:shop_online_mobile/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop_online_mobile/screens/home/home_screen.dart';
import 'package:shop_online_mobile/screens/profile/profile_screen.dart';

import '../common/constants.dart';
import '../common/enums.dart';
import '../helper/sharedPreferenceHelper.dart';
import '../models/ProductCartModel.dart';
import '../routes.dart';

class CustomBottomNavBar extends StatefulWidget {
  CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
    required this.numOfItem
  }) : super(key: key);

  int numOfItem = 0;
  final MenuState selectedMenu;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  SharedPreferenceHelper sharedPrefLocator = SharedPreferenceHelper();

  _showEmptyDiaLog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Cart is empty'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefLocator.getCarts();
    switch (widget.selectedMenu) {
      case MenuState.home:
        currentRoute = HomeScreen.routeName;
        break;
      case MenuState.favorite:
        currentRoute = FavoriteScreen.routeName;
        break;
      case MenuState.profile:
        currentRoute = ProfileScreen.routeName;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == widget.selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (Route<dynamic> route) => false);
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Heart Icon.svg",
                  color: MenuState.favorite == widget.selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  if(currentRoute != FavoriteScreen.routeName) {
                    Navigator.pushNamedAndRemoveUntil(context, FavoriteScreen.routeName, (Route<dynamic> route) => false);
                  }
                },
              ),
              IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                numOfitem: widget.numOfItem,
                press: () {
                  if (ProductCartModel.carts.isEmpty){
                    _showEmptyDiaLog();
                  } else {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  }
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == widget.selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  if(currentRoute != ProfileScreen.routeName) {
                    Navigator.pushNamedAndRemoveUntil(context, ProfileScreen.routeName, (Route<dynamic> route) => false);
                  }
                },
              ),
            ],
          )),
    );
  }
}
