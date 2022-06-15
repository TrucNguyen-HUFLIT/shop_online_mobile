import 'package:flutter/material.dart';
import 'package:shop_online_mobile/components/custom_surfix_icon.dart';
import 'package:shop_online_mobile/components/default_button.dart';
import 'package:shop_online_mobile/components/form_error.dart';
import 'package:shop_online_mobile/helper/utilities.dart';
import 'package:shop_online_mobile/models/RegisterModel.dart';

import '../../../common/constants.dart';
import '../../../common/size_config.dart';
import '../../../helper/keyboard.dart';
import '../../../helper/shopToast.dart';
import '../../sign_in/sign_in_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  final RegisterModel registerModel;
  CompleteProfileForm({required this.registerModel});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  bool isCanSubmit = true;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate() && isCanSubmit) {
                setState(() {
                  isCanSubmit = false;
                });
                _formKey.currentState!.save();
                try{
                  await Utilities().register(widget.registerModel);
                  Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, (route) => false);
                  ShopToast.SuccessfullyToast("Register account successfully!");
                }
                catch (msg){
                  ShopToast.FailedToast(msg.toString().replaceFirst("Exception: ", ""));
                }
                KeyboardUtil.hideKeyboard(context);
                setState(() {
                  isCanSubmit = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      onSaved: (newValue) => widget.registerModel.phoneNumber = newValue!,
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
        labelText: "Phone",
        hintText: "Enter your phone",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
        CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => widget.registerModel.address = newValue!,
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

  TextFormField buildFullNameFormField() {
    return TextFormField(
      onSaved: (newValue) => widget.registerModel.fullName = newValue!,
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
        labelText: "Full Name",
        hintText: "Enter your full name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
