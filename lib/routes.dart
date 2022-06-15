import 'package:flutter/widgets.dart';
import 'package:shop_online_mobile/screens/cart/cart_screen.dart';
import 'package:shop_online_mobile/screens/checkout/checkout_screen.dart';
import 'package:shop_online_mobile/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_online_mobile/screens/details/details_screen.dart';
import 'package:shop_online_mobile/screens/favorite/favorite_screen.dart';
import 'package:shop_online_mobile/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_online_mobile/screens/home/home_screen.dart';
import 'package:shop_online_mobile/screens/order_history/order_history_screen.dart';
import 'package:shop_online_mobile/screens/payment_method/payment_screen.dart';
import 'package:shop_online_mobile/screens/product/product_screen.dart';
import 'package:shop_online_mobile/screens/product_filter/product_filter_screen.dart';
import 'package:shop_online_mobile/screens/profile/profile_screen.dart';
import 'package:shop_online_mobile/screens/profile_detail/profile_detail_screen.dart';
import 'package:shop_online_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:shop_online_mobile/screens/splash/splash_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  FavoriteScreen.routeName: (context) => FavoriteScreen(),
  ProductScreen.routeName: (context) => ProductScreen(),
  ProductFilterScreen.routeName: (context) => ProductFilterScreen(),
  ProfileDetailScreen.routeName: (context) => ProfileDetailScreen(),
  OrderHistoryScreen.routeName: (context) => OrderHistoryScreen(),
  CheckOutScreen.routeName: (context) => CheckOutScreen(),
  PaymentScreen.routeName: (context) => PaymentScreen()
};

String currentRoute = HomeScreen.routeName;