import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/screen/account/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../constant.dart';
import '../../../k_text_style.dart';
import '../../../main.dart';
import '../../../size_config.dart';
import 'activation_code.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late String phone;
  late String email;
  late String password;
  late String conformPassword;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  final List<String> errors = [];

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44 * SizeConfig.imageSizeMultiplier,
                decoration: BoxDecoration(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? kSecondaryColor.withOpacity(0.1)
                      : Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  style: KTextStyle.bodyText4.copyWith(
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.black
                          : Colors.white),
                  controller: firstNameController,
                  onSaved: (newValue) => firstName = newValue!,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                        vertical: 4 * SizeConfig.imageSizeMultiplier),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'First Name',
                    hintStyle: KTextStyle.bodyText4.copyWith(
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.grey
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 4 * SizeConfig.imageSizeMultiplier,
              ),
              Container(
                width: 44 * SizeConfig.imageSizeMultiplier,
                decoration: BoxDecoration(
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? kSecondaryColor.withOpacity(0.1)
                      : Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  style: KTextStyle.bodyText4.copyWith(
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.black
                          : Colors.white),
                  controller: lastNameController,
                  onSaved: (newValue) => lastName = newValue!,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                        vertical: 4 * SizeConfig.imageSizeMultiplier),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Last Name',
                    hintStyle: KTextStyle.bodyText4.copyWith(
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: store.state.darkModeState == null ||
                              store.state.darkModeState == false
                          ? Colors.grey
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
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
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                    vertical: 4 * SizeConfig.imageSizeMultiplier),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: 'Phone Number',
                hintStyle: KTextStyle.bodyText4.copyWith(
                  color: Colors.grey,
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
          SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
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
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => email = newValue!,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                    vertical: 4 * SizeConfig.imageSizeMultiplier),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: 'Email',
                hintStyle: KTextStyle.bodyText4.copyWith(
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
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
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
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
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
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
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
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
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  color: store.state.darkModeState == null ||
                          store.state.darkModeState == false
                      ? Colors.grey
                      : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
          InkWell(
            onTap: () {
              _handleSignUp();
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
                  child: Text(_isLoading ? 'Please Wait...' : "SIGN UP",
                      style: KTextStyle.buttonText3.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center)),
            ),
          ),
          SizedBox(
            height: 11 * SizeConfig.imageSizeMultiplier,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
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
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogInScreen()));
                  });
                },
                child: Text(
                  "Sign In",
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

  Future<void> _handleSignUp() async {
    print('on login button click');

    if (firstNameController.text.isEmpty) {
      return _showMsg('FirstName can\'t be empty!', 1);
    }
    if (lastNameController.text.isEmpty) {
      return _showMsg('LastName can\'t be empty!', 1);
    }
    if (phoneController.text.isEmpty) {
      return _showMsg('Contact Number can\'t be empty!', 1);
    }
    if (emailController.text.isEmpty) {
      return _showMsg('Email can\'t be empty!', 1);
    }
    if (passwordController.text.isEmpty) {
      return _showMsg('Password can\'t be empty!', 1);
    }
    if (passwordController.text.length < 6) {
      return _showMsg('Password length 6 minimum character!', 1);
    }
    if (confirmPasswordController.text.isEmpty) {
      return _showMsg('ConfirmPassword can\'t be empty!', 1);
    }
    if (passwordController.text != confirmPasswordController.text) {
      return _showMsg('Password don\'t match', 1);
    }

    var data = {
      'contact': phoneController.text,
      'email': emailController.text,
      'name': firstNameController.text + " " + lastNameController.text,
      'password': passwordController.text,
      'username': phoneController.text,
      // 'deviceToken': deviceToken
    };

    print(data);

    setState(() {
      _isLoading = true;
    });

    var res = await CallApi().withoutTokenPostData(data, '/app/registration');
    var body = json.decode(res.body);

    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');

    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg(body['message'], 2);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ActivationCode(),
          ));

      store.state.userContactState = body['user'];
      store.dispatch(store.state.userContactState);
    } else {
      _showMsg(body['error']['messages'][0]['message'], 1);
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
