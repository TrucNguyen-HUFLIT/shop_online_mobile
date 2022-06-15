import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_online_mobile/helper/shopToast.dart';
import 'package:shop_online_mobile/helper/utilities.dart';
import 'package:shop_online_mobile/models/OrderModel.dart';

import '../../../common/size_config.dart';
import '../../../models/OrderModel.dart';
import 'order_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Utilities().getHistoryOrder(),
        builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: Colors.black,
                  )
                ],
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: OrderCard(order: snapshot.data![index]),
                  );
                },
              ),
            );
          }
        });
  }
}
