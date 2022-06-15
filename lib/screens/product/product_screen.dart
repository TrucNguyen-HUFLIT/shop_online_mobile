import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/enums.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/components/coustom_bottom_nav_bar.dart';
import 'package:shop_online_mobile/models/BrandModel.dart';
import '../../models/ProductCartModel.dart';
import 'components/body.dart';
class ProductScreen extends StatefulWidget {
  static String routeName = "/product";

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
    final ProductOfBrandArguments agrs = ModalRoute.of(context)!.settings.arguments as ProductOfBrandArguments;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text("${agrs.brand.name.toUpperCase()}",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(22),
                color: Colors.black,
                fontWeight: FontWeight.w600
            ),),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Body(idBrand: agrs.brand.id,),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home, numOfItem: numOfItem),
    );
  }
}

class ProductOfBrandArguments {
  final BrandModel brand;

  ProductOfBrandArguments({required this.brand});
}