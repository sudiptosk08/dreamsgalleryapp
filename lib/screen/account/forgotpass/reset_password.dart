import 'dart:convert';

import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/screen/account/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constant.dart';
import '../../../main.dart';
import '../../../size_config.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  late String password;
  late String conformPassword;
  final List<String> errors = [];
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == null ||
              store.state.darkModeState == false
          ? Colors.white
          : Color(0xFF0F0E0E),
      appBar: AppBar(
        elevation: 0.6,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: KTextStyle.headline5.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 6 * SizeConfig.imageSizeMultiplier,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
            child: Text(
              "Create New Password",
              style: KTextStyle.subtitle3.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
            child: Text(
              "Your password must be different \nform previous used password",
              style: KTextStyle.bodyText3.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Password*",
                        style: KTextStyle.caption,
                      ),
                      SizedBox(
                        height: 1.6 * SizeConfig.imageSizeMultiplier,
                      ),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: kSecondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: TextFormField(
                          style: KTextStyle.bodyText4,
                          controller: passwordController,
                          obscureText: isPasswordVisible,
                          onSaved: (newValue) => password = newValue!,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 4 * SizeConfig.imageSizeMultiplier),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.grey
                                  : Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: isPasswordVisible
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () => setState(
                                  () => isPasswordVisible = !isPasswordVisible),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Confirm Password*",
                        style: KTextStyle.caption,
                      ),
                      SizedBox(
                        height: 1.6 * SizeConfig.imageSizeMultiplier,
                      ),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: kSecondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: TextFormField(
                          style: KTextStyle.bodyText4,
                          controller: cPasswordController,
                          obscureText: isPasswordVisible,
                          onSaved: (newValue) => conformPassword = newValue!,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 4 * SizeConfig.imageSizeMultiplier),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Confirm Password',
                            hintStyle: KTextStyle.bodyText4.copyWith(
                              color: store.state.darkModeState == null ||
                                      store.state.darkModeState == false
                                  ? Colors.grey
                                  : Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: isPasswordVisible
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () => setState(
                                  () => isPasswordVisible = !isPasswordVisible),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
                  child: InkWell(
                    onTap: () {
                      _confirmReset();
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                              vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                          child: Text("Confirm",
                              style: KTextStyle.buttonText3.copyWith(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  Future<void> _confirmReset() async {
    print('on login button click');

    if (passwordController.text.isEmpty) {
      return _showMsg('Password can\'t be empty!', 1);
    }
    print(store.state.resetPasswordTokenState);
    var data = {
      'contact': store.state.resetPasswordContactState,
      'password': passwordController.text,
      'cpassword': cPasswordController.text,
      'token': store.state.resetPasswordTokenState,

      // 'deviceToken': deviceToken
    };

    //print(data);

    setState(() {});

    var res = await CallApi().withoutTokenPostData(data, '/app/reset-password');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg(body['message'], 2);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LogInScreen(),
      ));
    } else {
      _showMsg(body['message'], 1);
    }
    setState(() {});
  }

  _showMsg(msg, numb) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor:
            numb == 1 ? Colors.red.withOpacity(0.9) : Colors.green[400],
        textColor: Colors.white,
        fontSize: 13.0);
  }
}
