import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/models/CheckOutModel.dart';
import 'package:shop_online_mobile/models/ProductCartModel.dart';

import '../../components/default_button.dart';
import '../order_history/order_history_screen.dart';
import 'components/body.dart';

class PaymentScreen extends StatelessWidget {
  static String routeName = "/payment";

  @override
  Widget build(BuildContext context) {
    final PaymentDetailsArguments agrs =
    ModalRoute.of(context)!.settings.arguments as PaymentDetailsArguments;

    return Scaffold(
      appBar: buildAppBar(context, agrs.totalPrice),
      body: Body(paymentMethod: agrs.paymentMethod,),
       bottomNavigationBar: Container(
         padding: EdgeInsets.symmetric(
           vertical: getProportionateScreenWidth(15),
           horizontal: getProportionateScreenWidth(30),
         ),
         // height: 174,
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: const BorderRadius.only(
             topLeft: Radius.circular(30),
             topRight: Radius.circular(30),
           ),
           boxShadow: [
             BoxShadow(
               offset: const Offset(0, -15),
               blurRadius: 20,
               color: const Color(0xFFDADADA).withOpacity(0.15),
             )
           ],
         ),
         child: SafeArea(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 children: [
                   SizedBox(
                     width: getProportionateScreenWidth(300),
                     child: DefaultButton(
                       text: "Let's check your order",
                       press: () =>
                           Navigator.pushNamedAndRemoveUntil(
                               context,
                               OrderHistoryScreen.routeName,
                                   (Route<dynamic> route) => true)
                     ),
                   ),
                 ],
               ),
             ],
           ),
         ),
       )
    );
  }

  AppBar buildAppBar(BuildContext context, int totalPrice) {
    return AppBar(
      title: Container(
        transform: Matrix4.translationValues(80.0, 0.0, 0.0),
        child: Column(
          children: [
            Text("PAYMENT METHOD",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
            Text(
              "Total: \$$totalPrice",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  color: Colors.orange,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDetailsArguments {
  final PaymentMethods paymentMethod;
  final int totalPrice;

  PaymentDetailsArguments({required this.paymentMethod, required this.totalPrice});
}