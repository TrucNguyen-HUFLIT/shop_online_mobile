import '../helper/utilities.dart';

class ProductModel {
  late int id;
  late String name;
  late bool isFavorite;
  late int priceUSD;
  late int priceVND;
  late String description;
  late List<String> images;
  late List<ProductSize> productSizes;

  ProductModel({
    required this.id,
    required this.images,
    required this.name,
    this.isFavorite = false,
    required this.priceUSD,
    required this.priceVND,
    required this.description,
    required this.productSizes
  });

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    isFavorite = json['isFavorite'];
    priceUSD = json['priceUSD'];
    priceVND = json['priceVND'];
    description = json['description'];
    images = [];
    images.add(Utilities.url + json['pic']);
    images.add(Utilities.url + json['pic2']);
    images.add(Utilities.url + json['pic3']);
    productSizes = (json['productSizes'] as List).map((productSize) =>
        ProductSize.fromJson(productSize)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['isFavorite'] = isFavorite;
    data['priceUSD'] = priceUSD;
    data['priceVND'] = priceVND;
    data['images'] = images;
    data['description'] = description;
    data['productSizes'] = productSizes;

    return data;
  }
}

var exampleProduct = ProductModel(id: 0,
    images: [ "assets/images/Image Popular Product 2.png"],
    name: "Example Product",
    priceUSD: 50,
    priceVND: 50*22,
    description: "This is an example product",
    productSizes: List<ProductSize>.filled(1, ProductSize(id: 0, quantity: 2, size: 41)));

class ProductSize {
  late int id;
  late bool isAvailable;
  late int quantity;
  late int size;

  ProductSize({
    required this.id,
    this.isAvailable = false,
    required this.quantity,
    required this.size,
  });

  ProductSize.fromJson(Map<String, dynamic> json){
    id = json['id'];
    quantity = json['quantity'];
    isAvailable = json['isAvailable'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['quantity'] = quantity;
    data['isAvailable'] = isAvailable;
    data['size'] = size;

    return data;
  }
}