import 'package:flutter/material.dart';
import 'package:shop_online_mobile/components/product_card.dart';
import 'package:shop_online_mobile/helper/utilities.dart';
import 'package:shop_online_mobile/models/ProductDetailModel.dart';

import '../../../common/size_config.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20)),
          child: Text(
            "POPULAR PRODUCTS",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
        FutureBuilder(
            future: Utilities().getPopularProducts(),
            builder: (context, AsyncSnapshot<List<ProductDetailModel>> snapshot) {
              if(snapshot.connectionState != ConnectionState.done) {
                return Column(
                  children: [
                    SizedBox(height: getProportionateScreenWidth(20)),
                    const CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ],
                );
              }
              else {
                return Column(
                  children: [
                    SizedBox(height: getProportionateScreenWidth(20)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          if (snapshot.data != null && snapshot.data!.isNotEmpty)
                            ...List.generate(
                              snapshot.data!.length,
                                  (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: ProductCard(product: snapshot.data![index]),
                                );
                              },
                            ),
                          SizedBox(width: getProportionateScreenWidth(20)),
                        ],
                      ),
                    )
                  ],
                );
              }
            }),
      ],
    );
  }
}
