
class OrderModel {
  late int id;
  late DateTime orderDay;
  late String statusOrder;
  late bool isPaid;
  late String payment;
  late int totalPrice;

  OrderModel({
    required this.id,
    required this.orderDay,
    required this.statusOrder,
    required this.isPaid,
    required this.payment,
    required this.totalPrice,
  });

  OrderModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    orderDay = DateTime.tryParse(json['orderDay'])!;
    statusOrder = json['statusOrder'];
    isPaid = json['isPaid'];
    payment = json['payment'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['orderDay'] = orderDay;
    data['statusOrder'] = statusOrder;
    data['isPaid'] = isPaid;
    data['payment'] = payment;
    data['totalPrice'] = totalPrice;

    return data;
  }
}

