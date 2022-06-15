import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/enums.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/components/coustom_bottom_nav_bar.dart';
import '../../models/ProductCartModel.dart';
import 'components/body.dart';
class ProductFilterScreen extends StatefulWidget {
  static String routeName = "/product_filter";

  @override
  State<ProductFilterScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductFilterScreen> {
  int numOfItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      numOfItem = ProductCartModel.carts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductOfFilterArguments agrs = ModalRoute.of(context)!.settings.arguments as ProductOfFilterArguments;

    return Scaffold(
      body: Body(searchTerm: agrs.searchTerm),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home, numOfItem: numOfItem),
    );
  }
}

class ProductOfFilterArguments {
  final String searchTerm;

  ProductOfFilterArguments({required this.searchTerm});
}