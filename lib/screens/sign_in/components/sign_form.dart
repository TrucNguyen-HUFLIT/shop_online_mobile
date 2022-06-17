import 'package:flutter/material.dart';
import 'package:shop_online_mobile/components/custom_surfix_icon.dart';
import 'package:shop_online_mobile/components/form_error.dart';
import 'package:shop_online_mobile/helper/keyboard.dart';
import 'package:shop_online_mobile/helper/sharedPreferenceHelper.dart';
import 'package:shop_online_mobile/helper/shopToast.dart';
import 'package:shop_online_mobile/helper/utilities.dart';
import 'package:shop_online_mobile/models/LoginModel.dart';
import 'package:shop_online_mobile/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_online_mobile/screens/home/home_screen.dart';

import '../../../components/default_button.dart';
import '../../../common/constants.dart';
import '../../../common/size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? email;
  String? password;
  bool isCanSubmit = true;

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
    // email = "ngoctruc020100@gmail.com";
    // password = "612312";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          !isCanSubmit
              ? Column(
            children: [
              SizedBox(height: getProportionateScreenWidth(20)),
              const CircularProgressIndicator(
                color: Colors.black,
              ),
            ],
          )
              : DefaultButton(
            text: "Sign In",
            press: () async {
              setState(() {
                isCanSubmit = false;
              });
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                try{
                  var token = await Utilities().login(LoginModel(email!, password!));
                  SharedPreferenceHelper().setUserToken(userToken: token);
                  Navigator.pushNamed(context, HomeScreen.routeName);
                  ShopToast.SuccessfullyToast("Login successfully");
                }
                catch (msg){
                  ShopToast.FailedToast(msg.toString().replaceFirst("Exception: ", ""));
                }
                KeyboardUtil.hideKeyboard(context);
              }
              setState(() {
                isCanSubmit = true;
              });
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      initialValue: password,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
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
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      initialValue: email,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
