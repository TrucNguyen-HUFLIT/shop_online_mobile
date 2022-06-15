import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/helper/sharedPreferenceHelper.dart';
import 'package:shop_online_mobile/helper/shopDropDown.dart';
import 'package:shop_online_mobile/helper/shopToast.dart';
import 'package:shop_online_mobile/screens/payment_method/payment_screen.dart';

import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../helper/utilities.dart';
import '../../../models/CheckOutModel.dart';
import '../../../models/ProductCartModel.dart';
import '../../../models/UserModel.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var address = TextEditingController();
  int totalPrice = 0;
  int shippingFee = 0;
  String fullName = "";
  String phoneNumber = "";
  var selectedPaymentMethod = PaymentMethods.ShipCOD;

  bool isCanSubmit = true;

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPrice = ProductCartModel.carts.fold(
        0,
        (previousValue, cart) =>
            previousValue + (cart.quantity * cart.priceUSD));
    shippingFee = totalPrice > 200 ? 0 : 2;
    totalPrice = totalPrice + shippingFee;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: FutureBuilder(
                future: Utilities().getUserInfo(),
                builder: (context, AsyncSnapshot<UserInforModel> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(
                            color: Colors.black,
                          )
                        ],
                      ),
                    );
                  } else {
                    address.text = snapshot.data!.address;
                    fullName = snapshot.data!.fullName;
                    phoneNumber = snapshot.data!.phoneNumber;

                    return Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        TextFormField(
                          controller: address,
                          decoration: const InputDecoration(
                            labelText: "Delivery address",
                            border: UnderlineInputBorder(),
                            hintText: 'Enter your address',
                          ),
                          onSaved: (value) {
                            setState(() {
                              address.text = value as String;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: "Please enter your address");
                              return "";
                            }
                            return null;
                          },
                        ),
                        FormError(errors: errors),
                        SizedBox(height: SizeConfig.screenHeight * 0.015),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Full name:",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            Text(
                              fullName,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.01),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Phone:",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            Text(
                              phoneNumber,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Payment method:",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            ShopDropDown(
                                items: paymentMethods,
                                onSelectItem: (dynamic newValue) {
                                  selectedPaymentMethod = PaymentMethods.values
                                      .firstWhere((e) =>
                                          e.toString() ==
                                          "PaymentMethods." + newValue.value);
                                }),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.015),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Shipping fee:",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            Text(
                              "\$$shippingFee",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            )
                          ],
                        ),
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "FREE SHIPPING: Applies to orders of \$200 or more.",
                              style: TextStyle(fontSize: 12),
                            )),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Total price:",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            Text(
                              "\$$totalPrice",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.1),
                        !isCanSubmit
                            ? Column(
                                children: [
                                  SizedBox(
                                      height: getProportionateScreenWidth(20)),
                                  const CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ],
                              )
                            : DefaultButton(
                                text: "Order",
                                press: () async {
                                  if (isCanSubmit) {
                                    setState(() {
                                      isCanSubmit = false;
                                    });

                                    var productCheckOutModels = ProductCartModel
                                        .carts
                                        .map((e) => ProductCheckOutModel(
                                            id: e.id, quantity: e.quantity))
                                        .toList();

                                    try {
                                      var isCheckoutSuccessfully =
                                          await Utilities().checkoutCart(
                                              CheckOutCartRequestModel(
                                                  productCheckOutModels:
                                                      productCheckOutModels,
                                                  address: address.text,
                                                  paymentMethod:
                                                      selectedPaymentMethod
                                                          .toString()
                                                          .replaceAll(
                                                              "PaymentMethods.",
                                                              "")));

                                      if (isCheckoutSuccessfully) {
                                        ProductCartModel.carts = [];
                                        await SharedPreferenceHelper()
                                            .setCarts();
                                        ShopToast.SuccessfullyToast(
                                            "Check out successfully!");
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            PaymentScreen.routeName,
                                            (Route<dynamic> route) => false,
                                            arguments: PaymentDetailsArguments(
                                                paymentMethod:
                                                    selectedPaymentMethod,
                                                totalPrice: totalPrice));
                                      }
                                    } catch (msg) {
                                      ShopToast.FailedToast(
                                          "Check out failed!");
                                    }
                                    setState(() {
                                      isCanSubmit = true;
                                    });
                                  }
                                },
                              ),
                      ],
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
