import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_online_mobile/common/constants.dart';

import '../../../common/size_config.dart';
import '../../../routes.dart';

class CustomAppBar extends StatelessWidget {

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(45),
              width: getProportionateScreenWidth(20),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: kPrimaryColor,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, currentRoute);
                },
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
