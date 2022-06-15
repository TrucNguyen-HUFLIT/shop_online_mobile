import 'package:flutter/material.dart';
import 'package:shop_online_mobile/helper/utilities.dart';
import 'package:shop_online_mobile/models/BrandModel.dart';
import 'package:shop_online_mobile/screens/product/product_screen.dart';

import '../../../common/size_config.dart';

class Brands extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Text(
              "BRANDS",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            )),
        FutureBuilder(
            future: Utilities().getBrandList(),
            builder: (context, AsyncSnapshot<List<BrandModel>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Column(
                  children: [
                    SizedBox(height: getProportionateScreenWidth(20)),
                    const CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    SizedBox(height: getProportionateScreenWidth(10)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        if (snapshot.data != null && snapshot.data!.isNotEmpty)
                          for (var brand in snapshot.data as List<BrandModel>)
                            SpecialOfferCard(
                                image: brand.image.toString(),
                                brand: brand.name,
                                numOfProducts: 18,
                                press: () => Navigator.pushNamed(
                                    context, ProductScreen.routeName,
                                    arguments:
                                        ProductOfBrandArguments(brand: brand)))
                      ]),
                    ),
                  ],
                );
              }
            }),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.brand,
    required this.image,
    required this.numOfProducts,
    required this.press,
  }) : super(key: key);

  final String brand, image;
  final int numOfProducts;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(135),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.1),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
