import 'package:shop_online_mobile/helper/utilities.dart';

class UserInforModel {
  late int id;
  late String email;
  late String fullName;
  late String address;
  late String phoneNumber;
  late String avatar;

  UserInforModel(
      {required this.id,
      required this.email,
      required this.address,
      required this.fullName,
      required this.phoneNumber,
      required this.avatar});

  UserInforModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['fullName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    avatar = Utilities.url + json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['fullName'] = fullName;
    data['address'] = address;
    data['phoneNumber'] = phoneNumber;
    data['avatar'] = avatar.replaceFirst(Utilities.url, "");

    return data;
  }
}
