import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant.dart';
import '../../../k_text_style.dart';
import '../../../main.dart';

class ActivationCode extends StatefulWidget {
  @override
  _ActivationCodeState createState() => _ActivationCodeState();
}

class _ActivationCodeState extends State<ActivationCode> {
  final _formKey = GlobalKey<FormState>();
  late String number;
  bool _isLoading = false;
  final List<String> errors = [];
  TextEditingController tokenController = TextEditingController();

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Activation Code",
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
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: TextFormField(
                  style: KTextStyle.bodyText4,
                  controller: tokenController,
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) => number = newValue!,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                        vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'OTP(one time activation code)',
                    hintStyle: KTextStyle.bodyText4.copyWith(
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.call,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3 * SizeConfig.imageSizeMultiplier,
              ),
              InkWell(
                onTap: () {
                  _confirmRegistration();
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
                          vertical: 4 * SizeConfig.imageSizeMultiplier),
                      child: Text(_isLoading ? 'Please Wait...' : "Confirm",
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

  Future<void> _confirmRegistration() async {
    print('on login button click');

    if (tokenController.text.isEmpty) {
      return _showMsg('Activation code can\'t be empty!', 1);
    }

    var data = {
      'email': store.state.userContactState['contact'],
      'token': tokenController.text,
      // 'deviceToken': deviceToken
    };

    setState(() {
      _isLoading = true;
    });
    var res = await CallApi().withoutTokenPostData(data, '/app/activeAccount');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg(body['message'], 2);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyApp(),
      ));

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('userData', json.encode(body['user']));
    } else {
      _showMsg(body['message'], 1);
    }
    setState(() {
      _isLoading = false;
    });
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
