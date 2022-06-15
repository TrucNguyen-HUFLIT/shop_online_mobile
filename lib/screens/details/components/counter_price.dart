import 'package:flutter/material.dart';
import 'package:shop_online_mobile/components/rounded_icon_btn.dart';
import 'package:shop_online_mobile/helper/shopDropDown.dart';
import 'package:shop_online_mobile/models/ProductModel.dart';

import '../../../common/constants.dart';
import '../../../common/size_config.dart';

class CounterPrice extends StatefulWidget {
  CounterPrice(
      {Key? key, required this.product, required this.quantitySelected, required this.onSelectItem, required this.onIncreaseQuantity, required this.onDecreaseQuantity})
      : super(key: key);

  final ProductModel product;
  int quantitySelected;
  Function onSelectItem;
  Function onIncreaseQuantity;
  Function onDecreaseQuantity;

  @override
  State<CounterPrice> createState() => _CounterPriceState();
}

class _CounterPriceState extends State<CounterPrice> {
  List<SelectItem> productSizes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productSizes = widget.product.productSizes
        .map((productSize) =>
            SelectItem(productSize.id, productSize.size.toString()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          Text(
            "\$${widget.product.priceUSD}",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
          const Spacer(
            flex: 5,
          ),
          ShopDropDown(
            items: productSizes,
            onSelectItem: (dynamic newValue){
              widget.onSelectItem(newValue);
            },
          ),
          const Spacer(
            flex: 1,
          ),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              setState(() {
                widget.onDecreaseQuantity();
              });
            },
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Text(
            widget.quantitySelected.toString(),
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                widget.onIncreaseQuantity();
              });
            },
          ),
        ],
      ),
    );
  }
}
