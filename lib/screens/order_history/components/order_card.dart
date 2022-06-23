import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/models/OrderModel.dart';

import '../../../common/constants.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Order Id: ${order.id}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),
            SizedBox(width: getProportionateScreenWidth(85),),
            Expanded(
              child: Text(
                order.payment == "BankTransfer"
                    ? "Banking"
                    : order.payment == "EWallet"
                    ? "Momo"
                    : "Ship Cod",
                style: const TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 15,),
            order.isPaid ? const Text(
               "Paid" ,
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w600, color: Colors.green),
            )
            : const Text(
              "Unpaid" ,
              style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.w600, color: Colors.red),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: Text(DateFormat.yMMMd().add_Hm().format(order.orderDay),
              style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            )),
            const SizedBox(width: 15,),
            Expanded(
              child: Text(order.statusOrder,
                style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Text('\$${order.totalPrice + order.extraFeeUSD}', style: const TextStyle(fontSize: 16, color: Colors.orange, fontWeight: FontWeight.bold)),
          ],
        ),
        const Divider(
            color: Colors.black
        ),
      ],
    );
  }
}
