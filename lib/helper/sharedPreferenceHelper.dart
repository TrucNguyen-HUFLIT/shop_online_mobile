import 'dart:convert';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_online_mobile/helper/utilities.dart';
import 'package:shop_online_mobile/models/ProductCartModel.dart';

class SharedPreferenceHelper {
  static const String TOKEN = "TOKEN";
  static const String CARTS = "CARTS";
  static const String USER_INFO = "USER_INFO";
  static String AVATAR = "${Utilities.url}/img/Mobile/avatar-icon-images-4.jpg";

  late SharedPreferences prefs;

  Future<void> setUserToken({required String? userToken}) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN, userToken!);
  }

  Future<String?> getUserToken() async {
    prefs = await SharedPreferences.getInstance();
    String? userToken;

    try {
      userToken = prefs.getString(TOKEN);
      Map<String, dynamic> claims = Jwt.parseJwt(userToken!);
      AVATAR = Utilities.url + claims['avatar'].replaceAll("Avatar", "Mobile");
    } catch (ex) {
      userToken = '';
    }

    return userToken;
  }

  Future<void> getCarts() async {
    prefs = await SharedPreferences.getInstance();
    String? cartsJson;

    try {
      cartsJson = prefs.getString(CARTS);
      if (cartsJson!.isNotEmpty) {
        ProductCartModel.carts = (jsonDecode(cartsJson) as List)
            .map((e) => ProductCartModel(
                productDetailId: e["productDetailId"],
                id: e["id"],
                name: e["name"],
                priceUSD: e["priceUSD"],
                priceVND: e["priceVND"],
                image: e["image"],
                quantity: e["quantity"],
                size: e["size"]))
            .toList();
      } else {
        ProductCartModel.carts = [];
      }
    } catch (ex) {
      cartsJson = '';
    }
  }

  Future<void> setCarts() async {
    prefs = await SharedPreferences.getInstance();
    var listJsonCart =
        ProductCartModel.carts.map((cart) => cart.toJson()).toList();
    var stringEncodeCarts = jsonEncode(listJsonCart);
    await prefs.setString(CARTS, stringEncodeCarts);
  }
}
