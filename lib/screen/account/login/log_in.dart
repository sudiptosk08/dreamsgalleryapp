import 'package:dream_gallary/component/pushnotificatio.dart';
import 'package:dream_gallary/home_screen/home_screen.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/account/registration/regist_screen.dart';
import 'package:dream_gallary/screen/cart/cart_screen.dart';
import 'package:dream_gallary/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dream_gallary/api/api.dart';
import '../../../constant.dart';
import '../../../k_text_style.dart';
import '../../../main.dart';
import '../forgotpass/forgot_password.dart';
import 'dart:convert';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String phone;
  late String password;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool remember = false;
  bool _isLoading = false;
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
              controller: phoneController,
              keyboardType: TextInputType.phone,
              onSaved: (newValue) => phone = newValue!,
              onChanged: (value) {},
              onTap: () {
                setState(() {
                  store.dispatch(FloatingButtonAction("true"));
                  print("true");
                });
              },
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
                  FontAwesomeIcons.phoneAlt,
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 7 * SizeConfig.imageSizeMultiplier),
          Container(
            width: double.maxFinite,
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
              controller: passwordController,
              obscureText: isPasswordVisible,
              onSaved: (newValue) => password = newValue!,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                    vertical: 4 * SizeConfig.imageSizeMultiplier),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: 'Password',
                hintStyle: KTextStyle.bodyText4.copyWith(
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  icon: isPasswordVisible
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () =>
                      setState(() => isPasswordVisible = !isPasswordVisible),
                ),
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 1.5 * SizeConfig.imageSizeMultiplier),
          Row(
            children: [
              Checkbox(
                overlayColor: MaterialStateProperty.all(Colors.white),
                checkColor: Colors.red,
                value: remember,
                activeColor: store.state.darkModeState == null ||
                        store.state.darkModeState == false
                    ? kPrimaryColor
                    : Colors.white,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              Text(
                "Remember me",
                style: KTextStyle.bodyText4.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.grey[400],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PasswordReset()));
                },
                child: Text(
                  "Forgot Password?",
                  style: KTextStyle.bodyText4.copyWith(
                    color: store.state.darkModeState == null ||
                            store.state.darkModeState == false
                        ? Colors.black
                        : Colors.grey[400],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 8 * SizeConfig.imageSizeMultiplier,
          ),
          InkWell(
            onTap: () {
              _handleSignIn();
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
                  child: Text(_isLoading ? 'Please Wait...' : 'SIGN IN',
                      style: KTextStyle.buttonText3.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center)),
            ),
          ),
          SizedBox(
            height: 14 * SizeConfig.imageSizeMultiplier,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: KTextStyle.caption.copyWith(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.black
                      : Colors.grey[400],
                ),
              ),
              SizedBox(
                width: 1 * SizeConfig.imageSizeMultiplier,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()));
                },
                child: Text(
                  "Sign Up",
                  style: KTextStyle.caption.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    print('on login button click');
    if (phoneController.text.isEmpty) {
      return _showMsg('Phone can\'t be empty!', 1);
    }
    if (passwordController.text.isEmpty) {
      return _showMsg('Password can\'t be empty!', 1);
    }
    String fcmtoken = FCM.fcmtoken;
    print("FCMTOKEN $fcmtoken");

    var data = {
      'contact': phoneController.text,
      'password': passwordController.text,
      'deviceToken': fcmtoken,
    };

    setState(() {
      _isLoading = true;
    });

    var res = await CallApi().withoutTokenPostData(data, '/app/appLogin');
    var body = json.decode(res.body);
    print("body - $body");
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg(body['message'], 2);

      store.state.logoutUserData == null
          ? Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomeScreen()),
              ModalRoute.withName('/'),
            )
          : Container();
      store.state.logoutUserData == "CartPage"
          ? Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => CartScreen()),
              ModalRoute.withName('/'),
            )
          : Container();
      store.state.logoutUserData == "WishList"
          ? Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomeScreen()),
              ModalRoute.withName('/'),
            )
          : Container();
      store.state.logoutUserData == "ProfileScreen"
          ? Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomeScreen()),
              ModalRoute.withName('/'),
            )
          : Container();
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('userData', json.encode(body['user']));
    } else {
      _showMsg("Invalid Information! ", 1);
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
