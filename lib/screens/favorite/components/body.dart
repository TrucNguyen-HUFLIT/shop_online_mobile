import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/screens/favorite/components/favorite_product.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FavoriteProducts(),
            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }
}
