import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:shop_online_mobile/helper/sharedPreferenceHelper.dart';
import 'package:shop_online_mobile/models/BrandModel.dart';
import 'package:shop_online_mobile/models/LoginModel.dart';
import 'package:shop_online_mobile/models/OrderModel.dart';
import 'package:shop_online_mobile/models/ProductDetailModel.dart';
import 'package:shop_online_mobile/models/ProductModel.dart';
import 'package:shop_online_mobile/models/ResetPasswordModel.dart';
import 'package:shop_online_mobile/models/UserModel.dart';

import '../models/CheckOutModel.dart';
import '../models/RegisterModel.dart';

class Utilities {
  static String urlAPI = 'http://27.71.225.23:1999/api/';
  static String url = 'http://27.71.225.23:1999/';
  // static String urlAPI = 'https://10.0.2.2:5001/api/';
  // static String url = 'https://10.0.2.2:5001/';

  Future<List<BrandModel>> getBrandList() async {
    Response response;
    Map<String, String> headers = { HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    try {
      response = await get(Uri.parse(urlAPI + 'Client/brands'), headers: headers);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final data = (body['data'] as List).map((i) => BrandModel.fromJson(i)).toList();
        return data;
      }
    } on Exception catch (msg) {
      print(msg);
    }
    return List.empty();
  }

  Future<List<ProductDetailModel>> getPopularProducts() async {
    Response response;
    Map<String, String> headers = { HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    try {
      response = await get(Uri.parse(urlAPI + 'Client/popular-products'), headers: headers);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final data = (body['data'] as List).map((i) => ProductDetailModel.fromJson(i)).toList();
        return data;
      }
    } on Exception catch (msg) {
      print(msg);
    }
    return List.empty();
  }

  Future<List<ProductDetailModel>> getFavoriteProducts() async {
    Response response;
    Map<String, String> headers = { HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    try {
      response = await get(Uri.parse(urlAPI + 'Client/favorite-products'), headers: headers);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final data = (body['data'] as List).map((i) => ProductDetailModel.fromJson(i)).toList();
        return data;
      }
    } on Exception catch (msg) {
      print(msg);
    }
    return List.empty();
  }

  Future<ProductModel?> getProductByIdDetail(int idProductDetail) async {
    Response response;
    Map<String, String> headers = { HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    try {
      response = await get(Uri.parse(urlAPI + 'Client/product-by-id-detail?idProductDetail=$idProductDetail'), headers: headers);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final data = ProductModel.fromJson(body['data']);
        return data;
      }
    } on Exception catch (msg) {
      print(msg);
    }
    return null;
  }

  Future<List<ProductDetailModel>> getProductsByIdBrand(int idBrand) async {
    Response response;
    Map<String, String> headers = { HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    try {
      response = await get(Uri.parse(urlAPI + 'Client/products-by-id-brand?idBrand=$idBrand'), headers: headers);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final data = (body['data'] as List).map((i) => ProductDetailModel.fromJson(i)).toList();
        return data;
      }
    } on Exception catch (msg) {
      print(msg);
    }
    return List.empty();
  }

  Future<List<ProductDetailModel>> getProductsByFilter(String searchTerm) async {
    Response response;
    Map<String, String> headers = { HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    try {
      response = await get(Uri.parse(urlAPI + 'Client/products-by-filter?searchTerm=$searchTerm'), headers: headers);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final data = (body['data'] as List).map((i) => ProductDetailModel.fromJson(i)).toList();
        return data;
      }
    } on Exception catch (msg) {
      print(msg);
    }
    return List.empty();
  }

  Future<String> login(LoginModel model) async {
    Response response;
    var body = model.toJson();
    Map<String, String> headers = {"Content-type": "application/json"};
    response = await post(Uri.parse(urlAPI + 'Account/login'), body: jsonEncode(body), headers: headers);
    final bodyResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      final accessToken = bodyResponse['data']['accessToken'];
      return accessToken;
    }
    else {
      final message = bodyResponse['Message'];
      throw Exception(message);
    }
  }

  Future register(RegisterModel model) async {
    Response response;
    var body = model.toJson();
    Map<String, String> headers = {"Content-type": "application/json"};
    response = await post(Uri.parse(urlAPI + 'Account/register'), body: jsonEncode(body), headers: headers);
    final bodyResponse = json.decode(response.body);
    if (response.statusCode != 200) {
      final message = bodyResponse['Message'];
      throw Exception(message);
    }
  }

  Future resetPassword(ResetPasswordModel model) async {
    Response response;
    var body = model.toJson();
    Map<String, String> headers = {"Content-type": "application/json"};
    response = await post(Uri.parse(urlAPI + 'Account/reset-password'), body: jsonEncode(body), headers: headers);
    final bodyResponse = json.decode(response.body);
    if (response.statusCode != 200) {
      final message = bodyResponse['Message'];
      throw Exception(message);
    }
  }

  Future<UserInforModel> getUserInfo() async {
    Response response;
    Map<String, String> headers = {"Content-type": "application/json", HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    response = await get(Uri.parse(urlAPI + 'Profile/customer'), headers: headers);
    final bodyResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return UserInforModel.fromJson(bodyResponse['data']);
    } else {
      final message = bodyResponse['Message'];
      throw Exception(message);
    }
  }

  Future<UserInforModel> updateUserInfo(UserInforModel model) async {
    Response response;
    var body = model.toJson();
    Map<String, String> headers = {"Content-type": "application/json", HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    response = await put(Uri.parse(urlAPI + 'Profile/customer'), body: jsonEncode(body), headers: headers);
    final bodyResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return UserInforModel.fromJson(bodyResponse['data']);
    } else {
      final message = bodyResponse['Message'];
      throw Exception(message);
    }
  }

  Future<List<OrderModel>> getHistoryOrder() async {
    Response response;
    Map<String, String> headers = {"Content-type": "application/json", HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    response = await get(Uri.parse(urlAPI + 'Client/order-history'), headers: headers);
    final bodyResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      final data = (bodyResponse['data'] as List).map((i) => OrderModel.fromJson(i)).toList();
      return data;
    } else {
      final message = bodyResponse['Message'];
      throw Exception(message);
    }
  }

  Future<bool> checkoutCart(CheckOutCartRequestModel model) async {
    Response response;
    var body = model.toJson();
    Map<String, String> headers = {"Content-type": "application/json", HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    response = await post(Uri.parse(urlAPI + 'Cart/check-out'), body: jsonEncode(body), headers: headers);
    final bodyResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      final message = bodyResponse['Message'];
      throw Exception(message);
    }
  }


  Future<bool> favorite(int idProductDetail) async {
    Response response;
    Map<String, String> headers = {"Content-type": "application/json", HttpHeaders.authorizationHeader: "Bearer ${await SharedPreferenceHelper().getUserToken()}"};
    response = await post(Uri.parse(urlAPI + 'Client/favorite/$idProductDetail'), headers: headers);
    final bodyResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      final message = bodyResponse['Message'];
      throw Exception(message);
    }
  }
}
