import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/screens/product_filter/components/products_of_filter.dart';

import '../../../common/constants.dart';
import '../../../helper/keyboard.dart';

class Body extends StatefulWidget {
  String searchTerm;

  Body({required this.searchTerm});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    String term = "";
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.89,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: TextEditingController(text: widget.searchTerm),
                    onChanged: (value) => term = value,
                    onEditingComplete: () {
                      KeyboardUtil.hideKeyboard(context);
                      setState(() {
                        widget.searchTerm = term;
                      });
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Search product",
                        prefixIcon: Icon(Icons.search)),
                  ),
                )
              ],
            ),
          ),
          ProductsOfFilter(searchTerm: widget.searchTerm),
          SizedBox(
            height: getProportionateScreenHeight(20),
          )
        ],
      ),
    ));
  }
}
