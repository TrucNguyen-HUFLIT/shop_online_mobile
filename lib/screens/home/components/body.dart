import 'package:flutter/material.dart';

import '../../../common/size_config.dart';
import 'shop_slider.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'brands.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            ShopSlider(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Brands(),
            SizedBox(height: getProportionateScreenWidth(20)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(20)),
          ],
        ),
      ),
    );
  }
}
