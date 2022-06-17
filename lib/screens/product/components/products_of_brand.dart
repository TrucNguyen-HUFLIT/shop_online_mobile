import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/components/product_card.dart';
import 'package:shop_online_mobile/helper/utilities.dart';
import 'package:shop_online_mobile/models/ProductDetailModel.dart';
import 'package:shop_online_mobile/screens/home/home_screen.dart';

class ProductsOfBrand extends StatelessWidget {
  final int idBrand;

  ProductsOfBrand({required this.idBrand});

  @override
  Widget build(BuildContext context) {
    _showEmptyDiaLog() async {
      await Future.delayed(Duration(milliseconds: 50));
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Product list is empty'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, HomeScreen.routeName),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }

    return FutureBuilder(
        future: Utilities().getProductsByIdBrand(idBrand),
        builder: (context, AsyncSnapshot<List<ProductDetailModel>> snapshot) {
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
            if (snapshot.data!.isEmpty) {
              _showEmptyDiaLog();
            }
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.75),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: ProductCard(product: snapshot.data![index]),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
