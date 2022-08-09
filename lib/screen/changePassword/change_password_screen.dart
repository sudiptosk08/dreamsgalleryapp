import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  late String password;
  late String conformPassword;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.6,
        backgroundColor: store.state.darkModeState == null ||
                store.state.darkModeState == false
            ? Colors.white
            : Colors.grey,
        centerTitle: true,
        title: Text(
          "Password Change",
          style: KTextStyle.headline5.copyWith(
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
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
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Old Password*",
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
                          obscureText: isPasswordVisible,
                          onSaved: (newValue) => password = newValue!,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 3.1 * SizeConfig.imageSizeMultiplier),
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
                          obscureText: isPasswordVisible,
                          onSaved: (newValue) => password = newValue!,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 3.1 * SizeConfig.imageSizeMultiplier),
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
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 3 * SizeConfig.imageSizeMultiplier),
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
                          obscureText: isPasswordVisible,
                          onSaved: (newValue) => conformPassword = newValue!,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    2.1 * SizeConfig.imageSizeMultiplier,
                                vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Confirm Password',
                            hintStyle: KTextStyle.bodyText4.copyWith(
                              color: Colors.grey,
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
                    onTap: () {},
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
}
