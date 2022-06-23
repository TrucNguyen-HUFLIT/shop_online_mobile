import '../helper/shopDropDown.dart';

List<SelectItem> paymentMethods = [
  SelectItem(1, PaymentMethods.ShipCOD.toString().replaceAll("PaymentMethods.", "")),
  SelectItem(2, PaymentMethods.Momo.toString().replaceAll("PaymentMethods.", "")),
  SelectItem(3, PaymentMethods.Banking.toString().replaceAll("PaymentMethods.", "")),
];

enum PaymentMethods {
  ShipCOD, Momo, Banking
}

class CheckOutCartRequestModel {
  late List<ProductCheckOutModel> productCheckOutModels;
  late String address;
  late String paymentMethod;
  late bool isPaid;

  CheckOutCartRequestModel({
    required this.productCheckOutModels,
    required this.address,
    required this.paymentMethod,
    required this.isPaid,
  });

  CheckOutCartRequestModel.fromJson(Map<String, dynamic> json) {
    productCheckOutModels = (json['productCheckOutModels'] as List)
        .map((product) => ProductCheckOutModel.fromJson(product))
        .toList();
    address = json['address'];
    paymentMethod = json['paymentMethod'];
    isPaid = json['isPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productCheckOutModels'] = productCheckOutModels;
    data['address'] = address;
    data['isPaid'] = isPaid;

    switch (paymentMethod) {
      case "Momo":
        data['paymentMethod'] = "EWallet";
        break;
      case "Banking":
        data['paymentMethod'] = "BankTransfer";
        break;
      default:
        data['paymentMethod'] = paymentMethod;
    }
    return data;
  }
}

class ProductCheckOutModel {
  late int id;
  late int quantity;

  ProductCheckOutModel({
    required this.id,
    required this.quantity,
  });

  ProductCheckOutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['quantity'] = quantity;

    return data;
  }
}
