import 'package:flutter/material.dart';
import 'package:shop_online_mobile/components/custom_surfix_icon.dart';
import 'package:shop_online_mobile/components/default_button.dart';
import 'package:shop_online_mobile/components/form_error.dart';
import 'package:shop_online_mobile/helper/utilities.dart';
import 'package:shop_online_mobile/models/UserModel.dart';
import 'package:shop_online_mobile/screens/complete_profile/complete_profile_screen.dart';
import 'package:uiblock/uiblock.dart';

import '../../../common/constants.dart';
import '../../../common/size_config.dart';
import '../../../helper/shopToast.dart';

class UpdateProfileForm extends StatefulWidget {
  UserInforModel userInfor;

  UpdateProfileForm({required this.userInfor});

  @override
  _UpdateProfileFormState createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var fullName = TextEditingController();
  var phoneNumber = TextEditingController();
  var address = TextEditingController();
  var password = TextEditingController();

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
    email.text = widget.userInfor.email;
    fullName.text = widget.userInfor.fullName;
    phoneNumber.text = widget.userInfor.phoneNumber;
    address.text = widget.userInfor.address;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildFullNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(50)),
          DefaultButton(
            text: "Update",
            press: () async {
              UIBlock.block(
                context,
                customBuildBlockModalTransitions:
                    (context, animation, secondaryAnimation, child) {
                  return Column(
                    children: [
                      SizedBox(height: getProportionateScreenWidth(250)),
                      const CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ],
                  );
                },
              );

              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                try {
                  var userInfo = await Utilities().updateUserInfo(
                      UserInforModel(
                          id: widget.userInfor.id,
                          email: email.text,
                          address: address.text,
                          fullName: fullName.text,
                          phoneNumber: phoneNumber.text,
                          avatar: widget.userInfor.avatar));
                  ShopToast.SuccessfullyToast("Update successfully");
                  setState(() {
                    password.text = "";
                  });
                } catch (msg) {
                  ShopToast.FailedToast(
                      msg.toString().replaceFirst("Exception: ", ""));
                }
              }
              UIBlock.unblock(context);
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: email,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: "Email",
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneNumber,
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        setState(() {
          phoneNumber.text = value as String;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      controller: fullName,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        setState(() {
          fullName.text = value as String;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFullNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kFullNameNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Full name",
        hintText: "Enter your full name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User Icon.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: address,
      keyboardType: TextInputType.streetAddress,
      onSaved: (value) {
        setState(() {
          address.text = value as String;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: password,
      keyboardType: TextInputType.text,
      obscureText: true,
      onSaved: (value) {
        setState(() {
          password.text = value as String;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
