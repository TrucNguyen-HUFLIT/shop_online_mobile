import 'package:flutter/material.dart';

import '../../../common/size_config.dart';
import '../../../models/CheckOutModel.dart';

class Body extends StatefulWidget {

  PaymentMethods paymentMethod;

  Body({required this.paymentMethod});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    switch (widget.paymentMethod){
      case PaymentMethods.ShipCOD:
        return Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(70)),
              Image.asset(
                "assets/icons/icon-title.png",
                height: getProportionateScreenHeight(265),
                width: getProportionateScreenWidth(235),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              const Text("               Thanks a lot!!!\nYour shoes will come to you soon.",
                style: TextStyle(fontSize: 20, color: Colors.black),),
            ],
          )
        );
      case PaymentMethods.Momo:
        return Align(
          alignment: Alignment.center,
          child: Image.asset("momo.jpg"),
        );
      case PaymentMethods.Banking:
        return Align(
          alignment: Alignment.center,
          child: Image.asset("banking-vpbank.jpg"),
        );
    }
  }
}
