import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/screens/product/components/products_of_brand.dart';

class Body extends StatelessWidget {
  final int idBrand;
  Body({required this.idBrand});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      child: Column(
        children: [
          ProductsOfBrand(idBrand: idBrand),
          SizedBox(height: getProportionateScreenHeight(20),)
        ],
      ),
    ));
  }
}
