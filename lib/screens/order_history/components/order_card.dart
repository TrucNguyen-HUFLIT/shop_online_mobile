import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return Row(
      children: [
        Expanded(child: Text(DateFormat.yMMMd().format(order.orderDay))),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.payment == "BankTransfer"
                ? "Banking"
                : order.payment == "EWallet"
                    ? "Momo"
                    : "Ship Cod",
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                order.isPaid ? "(Paid)" : "(Unpaid)",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Text(order.statusOrder),
        ),
        Text('\$${order.totalPrice}', style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
