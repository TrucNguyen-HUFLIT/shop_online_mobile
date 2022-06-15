import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_online_mobile/helper/shopToast.dart';
import 'package:shop_online_mobile/models/ProductCartModel.dart';

import '../../../common/size_config.dart';
import '../../../helper/sharedPreferenceHelper.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  Body({required this.remove});

  Function? remove;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  _removeFromCart(index)  {
    widget.remove!(index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: ProductCartModel.carts.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(ProductCartModel.carts[index].id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                _removeFromCart(index);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(productCart: ProductCartModel.carts[index]),
          ),
        ),
      ),
    );
  }
}
