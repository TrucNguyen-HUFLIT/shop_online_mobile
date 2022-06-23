import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/constants.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/helper/sharedPreferenceHelper.dart';
import 'package:shop_online_mobile/helper/shopDropDown.dart';
import 'package:shop_online_mobile/helper/shopToast.dart';
import 'package:shop_online_mobile/screens/payment_method/payment_screen.dart';
import 'package:uiblock/uiblock.dart';

import '../../../common/constants.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../helper/utilities.dart';
import '../../../models/CheckOutModel.dart';
import '../../../models/ProductCartModel.dart';
import '../../../models/UserModel.dart';
import '../../order_history/order_history_screen.dart';

class Body extends StatefulWidget {
  Function setCharged;
  Body({required this.setCharged});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var address = TextEditingController();
  int subTotal = 0;
  int totalPrice = 0;
  int shippingFee = 0;
  String fullName = "";
  String phoneNumber = "";
  var selectedPaymentMethod = PaymentMethods.ShipCOD;
  bool isChargedPaypal = false;

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
    subTotal = totalPrice;
    totalPrice = totalPrice + shippingFee;
  }

  @override
  Widget build(BuildContext context) {
    return !isChargedPaypal
        ? SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                      future: Utilities().getUserInfo(),
                      builder:
                          (context, AsyncSnapshot<UserInforModel> snapshot) {
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
                                    addError(
                                        error: "Please enter your address");
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
                                        selectedPaymentMethod = PaymentMethods
                                            .values
                                            .firstWhere((e) =>
                                                e.toString() ==
                                                "PaymentMethods." +
                                                    newValue.value);
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
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
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
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(10),
                                  )
                                ],
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.05),
                              DefaultButton(
                                text: "Order",
                                press: () async {
                                  UIBlock.block(
                                    context,
                                    customBuildBlockModalTransitions: (context,
                                        animation, secondaryAnimation, child) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                              height:
                                                  getProportionateScreenWidth(
                                                      250)),
                                          const CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  var productCheckOutModels = ProductCartModel
                                      .carts
                                      .map((e) => ProductCheckOutModel(
                                          id: e.id,
                                          quantity: e.quantity))
                                      .toList();

                                  try {
                                    var isCheckoutSuccessfully =
                                        await Utilities().checkoutCart(
                                            CheckOutCartRequestModel(
                                              isPaid: false,
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
                                      await SharedPreferenceHelper().setCarts();
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
                                    } else {
                                      UIBlock.unblock(context);
                                    }
                                  } catch (msg) {
                                    UIBlock.unblock(context);

                                    ShopToast.FailedToast("Check out failed!");
                                  }
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  primary: kPrimaryColor,
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          UsePaypal(
                                              sandboxMode: true,
                                              clientId:
                                                  "AY-kA2s-yKYMAWrOMy0jeYspQ_fxEokHHiwsxHX9101LL-HzU0qClKPfypBed1IU4IzmHzo3TIAKm54w",
                                              secretKey:
                                                  "ECT4Ucgj5XE_hnl93RBtS1wq48W0EH9uiDpjWILR_bqxyin7kcOyquq2DbNFejrvw-As6vMeLS8WeWKm",
                                              returnURL:
                                                  "https://samplesite.com/return",
                                              cancelURL:
                                                  "https://samplesite.com/cancel",
                                              transactions: [
                                                {
                                                  "amount": {
                                                    "total": totalPrice,
                                                    "currency": "USD",
                                                    "details": {
                                                      "subtotal": subTotal,
                                                      "shipping": shippingFee,
                                                    }
                                                  },
                                                  "description":
                                                      "The payment transaction description.",
                                                  // "payment_options": {
                                                  //   "allowed_payment_method":
                                                  //       "INSTANT_FUNDING_SOURCE"
                                                  // },
                                                  "item_list": {
                                                    "items": ProductCartModel
                                                        .carts
                                                        .map((e) => {
                                                              "name": e.name,
                                                              "quantity":
                                                                  e.quantity,
                                                              "price":
                                                                  e.priceUSD,
                                                              "currency": "USD"
                                                            })
                                                        .toList(),
                                                  },
                                                }
                                              ],
                                              note:
                                                  "Contact us for any questions on your order.",
                                              onSuccess: (Map params) async {
                                                setState(() {
                                                  isChargedPaypal = true;
                                                  widget.setCharged();
                                                });

                                                var productCheckOutModels =
                                                    ProductCartModel.carts
                                                        .map((e) =>
                                                            ProductCheckOutModel(
                                                                id: e.id,
                                                                quantity:
                                                                    e.quantity))
                                                        .toList();

                                                try {
                                                  var isCheckoutSuccessfully =
                                                      await Utilities().checkoutCart(
                                                          CheckOutCartRequestModel(
                                                          isPaid: true,
                                                              productCheckOutModels:
                                                                  productCheckOutModels,
                                                              address:
                                                                  address.text,
                                                              paymentMethod: PaymentMethods
                                                                          .Momo
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
                                                  }
                                                } catch (msg) {
                                                  ShopToast.FailedToast(
                                                      "Check out failed!");
                                                }
                                              },
                                              onError: (error) {
                                                //ShopToast.FailedToast("Check out failed!");
                                              },
                                              onCancel: (params) {
                                                print('cancelled: $params');
                                              }),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  "assets/icons/paypal.png",
                                  height: 120,
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenWidth(70)),
                Image.asset(
                  "assets/icons/icon-title.png",
                  height: getProportionateScreenHeight(265),
                  width: getProportionateScreenWidth(235),
                ),
                SizedBox(height: getProportionateScreenWidth(20)),
                const Text(
                  "               Thanks a lot!!!\nYour shoes will come to you soon.",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: getProportionateScreenWidth(50)),
                SizedBox(
                  width: getProportionateScreenWidth(320),
                  child: DefaultButton(
                      text: "Let's check your order",
                      press: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          OrderHistoryScreen.routeName,
                          (Route<dynamic> route) => true)),
                ),
              ],
            ));
  }
}
