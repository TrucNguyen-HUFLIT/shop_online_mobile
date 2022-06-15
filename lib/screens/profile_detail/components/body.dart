import 'package:flutter/material.dart';
import 'package:shop_online_mobile/common/size_config.dart';
import 'package:shop_online_mobile/helper/utilities.dart';
import 'package:shop_online_mobile/models/UserModel.dart';
import 'update_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            return SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        UpdateProfileForm(userInfor: snapshot.data as UserInforModel,),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
