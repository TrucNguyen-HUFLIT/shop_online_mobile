import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/constants.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/models/RegisterModel.dart';

import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  final RegisterModel registerModel;
  Body({required this.registerModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Complete Profile", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                CompleteProfileForm(registerModel: this.registerModel,),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
