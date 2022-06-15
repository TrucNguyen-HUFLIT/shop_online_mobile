
import 'package:flutter/material.dart';
import 'package:shop_online_mobile/components/default_button.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/helper/sharedPreferenceHelper.dart';
import 'package:shop_online_mobile/helper/shopToast.dart';
import 'package:shop_online_mobile/models/ProductCartModel.dart';
import 'package:shop_online_mobile/models/ProductModel.dart';
import 'counter_price.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final ProductModel product;

  Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int quantitySelected = 1;
  late ProductSize productSizeSelected;

  SharedPreferenceHelper sharedPrefLocator = SharedPreferenceHelper();

  _addToCart(
      ProductModel product, ProductSize productSizeSelected, int numOfItem) {
    if (ProductCartModel.carts.any((productCart) => productCart.id == productSizeSelected.id)) {
      ProductCartModel.carts
          .where((productCart) => productCart.id == productSizeSelected.id)
          .first
          .quantity += numOfItem;
    } else {
      ProductCartModel.carts.add(ProductCartModel(
          id: productSizeSelected.id,
          name: product.name,
          priceUSD: product.priceUSD,
          priceVND: product.priceVND,
          image: product.images[0],
          quantity: numOfItem,
          size: productSizeSelected.size));
    }
    sharedPrefLocator.setCarts();

    ShopToast.SuccessfullyToast("Add to cart successfully");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.product.productSizes.isNotEmpty) {
      widget.product.productSizes.sort((a, b) => (a.size.compareTo(b.size)));
      productSizeSelected = widget.product.productSizes[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    if (widget.product.productSizes.isNotEmpty) ...[
                      CounterPrice(
                        product: widget.product,
                        quantitySelected: quantitySelected,
                        onSelectItem: (dynamic newValue) {
                          setState(() {
                            productSizeSelected = widget.product.productSizes
                                .where((productSize) =>
                                    productSize.id == newValue.key)
                                .first;
                            if (quantitySelected >
                                productSizeSelected.quantity) {
                              quantitySelected = productSizeSelected.quantity;
                            }
                          });
                        },
                        onIncreaseQuantity: () {
                          setState(() {
                            int quantity = widget.product.productSizes
                                .where((productSize) =>
                                    productSize.id == productSizeSelected.id)
                                .first
                                .quantity;
                            if (quantity > quantitySelected) {
                              quantitySelected++;
                            }
                          });
                        },
                        onDecreaseQuantity: () {
                          setState(() {
                            if (quantitySelected > 1) {
                              quantitySelected--;
                            }
                          });
                        },
                      ),
                      TopRoundedContainer(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.15,
                            right: SizeConfig.screenWidth * 0.15,
                            bottom: getProportionateScreenWidth(40),
                            top: getProportionateScreenWidth(15),
                          ),
                          child: DefaultButton(
                            text: "Add To Cart",
                            press: () {
                              _addToCart(widget.product, productSizeSelected,
                                  quantitySelected);
                            },
                          ),
                        ),
                      ),
                    ] else if (widget.product.productSizes.isEmpty) ...[
                      Text(
                        "Out of stock",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(24),
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
