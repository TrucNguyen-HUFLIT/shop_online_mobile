import 'package:flutter/material.dart';
import 'package:shop_online_mobile/models/ProductCartModel.dart';
import 'package:shop_online_mobile/routes.dart';
import 'package:shop_online_mobile/screens/cart/cart_screen.dart';
import 'package:shop_online_mobile/screens/details/details_screen.dart';

import '../../../common/constants.dart';
import '../../../common/size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.productCart,
  }) : super(key: key);

  final ProductCartModel productCart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        previousRoute = currentRoute;
        currentRoute = CartScreen.routeName;
        Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(id: productCart.productDetailId),
        );
      },
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(productCart.image),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(230),
                child: Text(
                  productCart.name,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "Size ${productCart.size}  \$${productCart.priceUSD}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: " x ${productCart.quantity}",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
