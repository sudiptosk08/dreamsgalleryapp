import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constant.dart';
import '../../../main.dart';
import 'otp_activation.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();
  late String phone;
  late String password;
  bool remember = false;
  final List<String> errors = [];
  TextEditingController contactController = TextEditingController();

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
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
    return Scaffold(
        backgroundColor: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.white
            : Color(0xFF0F0E0E),
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 4 * SizeConfig.imageSizeMultiplier),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(height: 30 * SizeConfig.heightMultiplier),
                  Text(
                    "Password Reset",
                    style: KTextStyle.subtitle3.copyWith(
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 7 * SizeConfig.imageSizeMultiplier,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? kSecondaryColor.withOpacity(0.1)
                          : Colors.grey[900],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextFormField(
                      style: KTextStyle.bodyText4.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.black
                              : Colors.white),
                      controller: contactController,
                      keyboardType: TextInputType.phone,
                      onSaved: (newValue) => phone = newValue!,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                            vertical: 4 * SizeConfig.imageSizeMultiplier),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Phone Number',
                        hintStyle: KTextStyle.bodyText4.copyWith(
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.grey
                              : Colors.grey,
                        ),
                        prefixIcon: Icon(
                          Icons.call,
                          color: store.state.darkModeState == null ||
                                  store.state.darkModeState == false
                              ? Colors.grey
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3 * SizeConfig.imageSizeMultiplier,
                  ),
                  InkWell(
                    onTap: () {
                      resetPassword();
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
                ])),
          ),
        )));
  }

  Future<void> resetPassword() async {
    print('on login button click');

    if (contactController.text.isEmpty) {
      return _showMsg('Phone number isn\'t be empty!', 1);
    }

    var data = {
      'contact': contactController.text,
      // 'deviceToken': deviceToken
    };

    //print(data);

    setState(() {});

    var res =
        await CallApi().withoutTokenPostData(data, '/app/sendResetMessage');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg(body['message'], 2);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => OTPCode(),
      ));

      setState(() {
        store.dispatch(ResetPasswordContactAction(contactController.text));
      });
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
