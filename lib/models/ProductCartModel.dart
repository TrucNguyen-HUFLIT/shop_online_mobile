
class ProductCartModel {
  late int id;
  late String name;
  late String image;
  late int priceUSD;
  late int priceVND;
  late int quantity;
  late int size;

  static List<ProductCartModel> carts = [];

  ProductCartModel({
    required this.id,
    required this.name,
    required this.priceUSD,
    required this.priceVND,
    required this.image,
    required this.quantity,
    required this.size,
  });

  ProductCartModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    priceUSD = json['priceUSD'];
    priceVND = json['priceVND'];
    image = json['image'];
    quantity = json['quantity'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['priceUSD'] = priceUSD;
    data['priceVND'] = priceVND;
    data['quantity'] = quantity;
    data['image'] = image;
    data['size'] = size;

    return data;
  }
}

