import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  var token;
  var user;
  final _formKey = GlobalKey<FormState>();
  String fullName = store.state.userDataState['name'];
  String email = store.state.userDataState['email'];
  String contact = store.state.userDataState['contact'];
  String district = store.state.userDataState['customer']['zone'] == null
      ? "District"
      : store.state.userDataState['customer']['zone'];
  late int zoneId;
  var districtName = store.state.districtName;
  String postalCode = store.state.userDataState['customer']['postCode'];
  String fullAddress = store.state.userDataState['customer']['address'];
  String facebook = store.state.userDataState['customer']['facebook'];
  String instagram = store.state.userDataState['customer']['instagram'];
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  //bool _isChecked = false;
  bool _isLoading = false;
  final List<String> errors = [];

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 1.5 * SizeConfig.imageSizeMultiplier),
          Padding(
            padding: EdgeInsets.only(
                left: 2.1 * SizeConfig.imageSizeMultiplier,
                right: 2.1 * SizeConfig.imageSizeMultiplier),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Full Name*",
                  style: KTextStyle.caption.copyWith(
                    color: store.state.darkModeState == false ||
                            store.state.darkModeState == null
                        ? Colors.black
                        : Colors.grey[400],
                  ),
                ),
                SizedBox(
                  height: 1.6 * SizeConfig.imageSizeMultiplier,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    //controller:  fullNameController ,

                    initialValue: fullName,
                    keyboardType: TextInputType.name,
                    onSaved: (newValue) => fullName = newValue!,
                    onChanged: (value) {
                      setState(() {
                        fullName = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                          vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Full Name',
                      hintStyle: KTextStyle.bodyText4.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    style: KTextStyle.bodyText4.copyWith(
                      color: Colors.grey[600],
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
                  "Email*",
                  style: KTextStyle.caption.copyWith(
                    color: store.state.darkModeState == false ||
                            store.state.darkModeState == null
                        ? Colors.black
                        : Colors.grey[400],
                  ),
                ),
                SizedBox(
                  height: 1.6 * SizeConfig.imageSizeMultiplier,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextFormField(
                    initialValue: email,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (newValue) => email = newValue!,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                          vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: KTextStyle.bodyText4.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    style: KTextStyle.bodyText4.copyWith(
                      color: Colors.grey[600],
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
                  "Contact*",
                  style: KTextStyle.caption.copyWith(
                    color: store.state.darkModeState == false ||
                            store.state.darkModeState == null
                        ? Colors.black
                        : Colors.grey[400],
                  ),
                ),
                SizedBox(
                  height: 1.6 * SizeConfig.imageSizeMultiplier,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextFormField(
                    initialValue: contact,
                    keyboardType: TextInputType.phone,
                    onSaved: (newValue) => contact = newValue!,
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                          vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Phone Number',
                      hintStyle: KTextStyle.bodyText4.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    style: KTextStyle.bodyText4.copyWith(
                      color: Colors.grey[600],
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
                      "District*",
                      style: KTextStyle.caption.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                    ),
                    SizedBox(
                      height: 1.6 * SizeConfig.imageSizeMultiplier,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 0.2 * SizeConfig.imageSizeMultiplier,
                            right: 0.2 * SizeConfig.imageSizeMultiplier,
                            bottom: 2.0 * SizeConfig.imageSizeMultiplier),
                        child: GestureDetector(
                          onTap: () {
                            showCustomBrandDialog(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                              vertical: 1.8 * SizeConfig.imageSizeMultiplier,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.grey[200]
                                  : Colors.grey[900],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    store.state.districtName == null
                                        ? district
                                        : district, //brandTitle
                                    style: TextStyle(
                                      color: store.state.districtName == null
                                          ? Colors.grey[600]
                                          : Colors.grey[600],
                                      fontSize:
                                          3.8 * SizeConfig.imageSizeMultiplier,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ])),
          SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
          Padding(
            padding: EdgeInsets.only(
                left: 2.1 * SizeConfig.imageSizeMultiplier,
                right: 2.1 * SizeConfig.imageSizeMultiplier),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Postal Code*",
                  style: KTextStyle.caption.copyWith(
                    color: store.state.darkModeState == false ||
                            store.state.darkModeState == null
                        ? Colors.black
                        : Colors.grey[400],
                  ),
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
                    initialValue: postalCode,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        postalCode = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                          vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Postal Code',
                      hintStyle: KTextStyle.bodyText4.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    style: KTextStyle.bodyText4.copyWith(
                      color: Colors.grey[600],
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
                  "Full Address*",
                  style: KTextStyle.caption.copyWith(
                    color: store.state.darkModeState == false ||
                            store.state.darkModeState == null
                        ? Colors.black
                        : Colors.grey[400],
                  ),
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
                    initialValue: fullAddress,
                    onChanged: (value) {
                      setState(() {
                        fullAddress = value;
                      });
                    },
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                          vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Full Address',
                      hintStyle: KTextStyle.bodyText4.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    style: KTextStyle.bodyText4.copyWith(
                      color: Colors.grey,
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
                  "Facebook Profile",
                  style: KTextStyle.caption.copyWith(
                    color: store.state.darkModeState == false ||
                            store.state.darkModeState == null
                        ? Colors.black
                        : Colors.grey[400],
                  ),
                ),
                SizedBox(
                  height: 1.6 * SizeConfig.imageSizeMultiplier,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    initialValue: facebook,
                    keyboardType: TextInputType.url,
                    onChanged: (value) {
                      setState(() {
                        facebook = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                          vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'facebook',
                      hintStyle: KTextStyle.bodyText4.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    style: KTextStyle.bodyText4.copyWith(
                      color: Colors.grey[600],
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
                  "Instagram Profile",
                  style: KTextStyle.caption.copyWith(
                    color: store.state.darkModeState == false ||
                            store.state.darkModeState == null
                        ? Colors.black
                        : Colors.grey[400],
                  ),
                ),
                SizedBox(
                  height: 1.6 * SizeConfig.imageSizeMultiplier,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    initialValue: instagram,
                    keyboardType: TextInputType.url,
                    onChanged: (value) {
                      setState(() {
                        instagram = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                          vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Instagram',
                      hintStyle: KTextStyle.bodyText4.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    style: KTextStyle.bodyText4.copyWith(
                      color: Colors.grey[600],
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
                setState(() {
                  _handleSaveChange();
                });
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
                    child: Text(_isLoading ? "Please Wait !" : "Save Changes",
                        style: KTextStyle.buttonText3.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center)),
              ),
            ),
          ),
          SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
        ],
      ),
    );
  }

  showCustomBrandDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: Colors.black),
                    child: Text(
                      "SELECT DISTRICT",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  //SizedBox(height: 12),
                  Container(
                      color: Colors.white,
                      height: 400.0, // Change as per your requirement
                      width: 300.0, // Change as per your requirement
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                              store.state.districtState.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    district = store.state.districtState[index]
                                        ['zoneName'];
                                    zoneId =
                                        store.state.districtState[index]['id'];
                                    store.dispatch(DistrictNameAction(store
                                        .state
                                        .districtState[index]['zoneName']));
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 12 * SizeConfig.imageSizeMultiplier,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 0.8,
                                      ))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0 *
                                            SizeConfig.imageSizeMultiplier),
                                    child: Text(store.state.districtState[index]
                                        ['zoneName']),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  )
                ]),
          ),
        );
      });

  Future<void> _handleSaveChange() async {
    print('on login button click');
    if (district == "") {
      return _showMsg("District can't be empty !", 1);
    }
    if (postalCode == '') {
      return _showMsg('District Postal Code can\'t be empty !', 1);
    }
    if (fullAddress == '') {
      return _showMsg('Address can\'t be empty!', 1);
    }

    print('store.state.userDataState');
    print(store.state.userDataState);
    print(store.state.userDataState['customer']['id']);
    var data = {
      'customer': {
        'address': fullAddress,
        'customerName': fullName,
        'email': email,
        'id': store.state.userDataState['customer']['id'],
        'facebook': facebook,
        'instagram': instagram,
        'postCode': postalCode,
        'userId': store.state.userDataState['id'],
        'zone': district,
        'zoneId': zoneId,
      },
      'email': email,
      'id': store.state.userDataState['id'],
      'name': fullName,

      // 'deviceToken': deviceToken
    };

    print(data);

    setState(() {
      _isLoading = true;
    });

    var res = await CallApi().postData(data, '/app/user/edit');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Profile Updated Successfully!", 2);
      setState(() {
        store.state.userDataState['email'] = email;
        store.state.userDataState['name'] = fullName;
        store.state.userDataState['customer']['customerName'] = fullName;
        store.state.userDataState['customer']['address'] = fullAddress;
        store.state.userDataState['customer']['email'] = email;
        store.state.userDataState['customer']['facebook'] = facebook;
        store.state.userDataState['customer']['instagram'] = instagram;
        store.state.userDataState['customer']['postCode'] = postalCode;
        store.state.userDataState['customer']['zone'] = district;
        store.state.userDataState['customer']['zoneId'] = zoneId;
      });

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'userData', json.encode(store.state.userDataState));
      setState(() {
        store.state.userDataState =
            json.decode(localStorage.getString('userData')!);
        store.dispatch(UserDataAction(store.state.userDataState));
      });
      Navigator.pop(context);
    } else {
      _showMsg(body['message'], 1);
      setState(() {
        _isLoading = false;
      });
    }
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
