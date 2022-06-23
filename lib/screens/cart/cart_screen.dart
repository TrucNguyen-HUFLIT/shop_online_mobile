import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/models/ProductCartModel.dart';

import '../../helper/sharedPreferenceHelper.dart';
import '../../helper/shopToast.dart';
import '../../routes.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  SharedPreferenceHelper sharedPrefLocator = SharedPreferenceHelper();

  int totalPrice = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPrice = ProductCartModel.carts.fold(0, (previousValue, cart) => previousValue + (cart.quantity * cart.priceUSD));

  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Body(remove: (index) {
          if (ProductCartModel.carts.isNotEmpty) {
            ProductCartModel.carts.removeAt(index);
            setState(() {
              totalPrice = ProductCartModel.carts.fold(0, (previousValue, cart) => previousValue + (cart.quantity * cart.priceUSD));
            });
            sharedPrefLocator.setCarts();
            ShopToast.SuccessfullyToast("Remove from carts successfully");
          }
          else {
            ShopToast.FailedToast("Carts are empty");
          }
        },),
        bottomNavigationBar: CheckoutCard(totalPrice: totalPrice,),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset("icon-arrow-down.png", width: getProportionateScreenWidth(15),),
        onPressed: () =>
            Navigator.pushNamed(context, currentRoute != CartScreen.routeName ? currentRoute : previousRoute)
      ),
      title: Container(
        transform: Matrix4.translationValues(70.0, 0.0, 0.0),
        child: Column(
          children: [
            Text("YOUR CART",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
            Text(
              "${ProductCartModel.carts.length} items",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}