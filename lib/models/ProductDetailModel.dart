import '../helper/utilities.dart';

class ProductDetailModel {
  late int id;
  late String name;
  late bool isFavorite;
  late int priceUSD;
  late int priceVND;
  late String image;

  ProductDetailModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFavorite = false,
    required this.priceUSD,
    required this.priceVND,
});

  ProductDetailModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    isFavorite = json['isFavorite'];
    priceUSD = json['priceUSD'];
    priceVND = json['priceVND'];
    image = Utilities.url + json['pic'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['isFavorite'] = isFavorite;
    data['priceUSD'] = priceUSD;
    data['priceVND'] = priceVND;
    data['image'] = image;

    return data;
  }
}