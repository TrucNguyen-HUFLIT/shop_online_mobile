import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ShopSlider extends StatelessWidget {
  const ShopSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 162.5,
        width: double.infinity,
        child: Carousel(
          images: [
            Image.asset("assets/background-1.png",height: double.infinity,width: double.infinity,),
            Image.asset("assets/background-2.png",height: double.infinity,width: double.infinity,),
            Image.asset("assets/background-3.png",height: double.infinity,width: double.infinity,),
          ],
          indicatorBgPadding: 0,
          dotSize: 0,
        ));
  }
}
