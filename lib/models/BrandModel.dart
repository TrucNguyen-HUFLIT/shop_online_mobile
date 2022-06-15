import 'package:shop_online_mobile/helper/utilities.dart';

class BrandModel {
  late int id;
  late String name;
  late String image;

  BrandModel(this.id, this.name);

  BrandModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = Utilities.url + json['pic'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}