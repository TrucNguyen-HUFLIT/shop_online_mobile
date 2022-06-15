import 'package:flutter/material.dart';
import 'package:shop_online_mobile/models/RegisterModel.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    final CompleteProfileRegisterArguments args =
        ModalRoute.of(context)!.settings.arguments as CompleteProfileRegisterArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(registerModel: args.registerModel,),
    );
  }
}

class CompleteProfileRegisterArguments {
  final RegisterModel registerModel;

  CompleteProfileRegisterArguments({required this.registerModel});
}
