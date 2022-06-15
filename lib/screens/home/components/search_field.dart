import 'package:flutter/material.dart';
import 'package:shop_online_mobile/screens/product_filter/product_filter_screen.dart';

import '../../../common/constants.dart';
import '../../../common/size_config.dart';

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
  }) : super(key: key);

  String searchTerm = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.89,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => searchTerm = value,
        onEditingComplete: () => {
          Navigator.pushNamed(context, ProductFilterScreen.routeName,
          arguments: ProductOfFilterArguments(searchTerm: searchTerm))
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
    );
  }
}
