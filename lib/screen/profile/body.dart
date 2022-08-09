import 'dart:convert';
import 'dart:io';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/screen/preOrderCart/pre_order_cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:dream_gallary/redux/action.dart';
import 'package:dream_gallary/screen/changeprofile/changeProfile_screen.dart';
import 'package:dream_gallary/screen/checkBalance/checkBalance_screen.dart';
import 'package:dream_gallary/screen/contact_us/contact_us.dart';
import 'package:dream_gallary/screen/myorder/myorder_screen.dart';
import 'package:dream_gallary/screen/notification/notification_screen.dart';
import 'package:dream_gallary/screen/paymentHistory/payment_h_screen.dart';
import 'package:dream_gallary/screen/preorder_list/preorder_screen.dart';
import 'package:dream_gallary/screen/profile/profile_circle_menu.dart';
import 'package:dream_gallary/screen/profile/profile_menu.dart';
import 'package:dream_gallary/screen/report_isue/report_isue_screen.dart';
import 'package:dream_gallary/screen/terms&condition/term&condition.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../../main.dart';
import '../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? fileImage;
  var userImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: store.state.darkModeState == null ||
              store.state.darkModeState == false
          ? Colors.white
          : Color(0xFF0F0E0E),
      padding:
          EdgeInsets.symmetric(vertical: 3 * SizeConfig.imageSizeMultiplier),
      child: Column(
        children: [
          SizedBox(height: 14 * SizeConfig.imageSizeMultiplier),
          Column(
            children: [
              fileImage != null
                  ? Container(
                      height: 27.6 * SizeConfig.imageSizeMultiplier,
                      width: 28.5 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(65)),
                          image: DecorationImage(
                              image: FileImage(
                                fileImage!,
                              ),
                              fit: BoxFit.fill)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 70, top: 62),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            setState(() {
                              multipartImageUpload();
                            });
                          },
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                      ))
                  : Container(
                      height: 27.6 * SizeConfig.imageSizeMultiplier,
                      width: 28.5 * SizeConfig.imageSizeMultiplier,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(65)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${store.state.userDataState['image']}"),
                              fit: BoxFit.fill)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 70, top: 62),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            setState(() {
                              multipartImageUpload();
                            });
                          },
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                      )),
              Padding(
                padding:
                    EdgeInsets.only(top: 0.5 * SizeConfig.heightMultiplier),
                child: Text(
                  store.state.userDataState['name'],
                  style: KTextStyle.bodyText3.copyWith(
                    color: store.state.darkModeState == null ||
                            store.state.darkModeState == false
                        ? Colors.grey[900]!.withOpacity(1)
                        : Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                height: 6.8 * SizeConfig.imageSizeMultiplier,
                color: Colors.black,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckBalance()));
                  _getUserBalanceData();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Text(
                  "Check Balance",
                  style: KTextStyle.buttonText4.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 4.4 * SizeConfig.imageSizeMultiplier,
                vertical: 0.5 * SizeConfig.imageSizeMultiplier),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileCircleMenu(
                    press: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyOrder())),
                    icon: Icons.list_alt,
                    text: "My Orders",
                  ),
                  ProfileCircleMenu(
                    press: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PreOrder())),
                    icon: Icons.format_list_bulleted_sharp,
                    text: "Pre Orders",
                  ),
                  ProfileCircleMenu(
                    press: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeProfile()));
                      setState(() {});
                    },
                    icon: Icons.person_outline_sharp,
                    text: "Profile",
                  ),
                  ProfileCircleMenu(
                    press: () {},
                    icon: Icons.message_outlined,
                    text: "Message",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2 * SizeConfig.imageSizeMultiplier,
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            height: 0.2 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
          ),
          ProfileMenu(
            text: "Pre-Order Cart",
            icon: CupertinoIcons.cart_badge_plus,
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => PreOrderCartScreen())),
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
            height: 0.2 * SizeConfig.imageSizeMultiplier,
          ),
          ProfileMenu(
            text: "Notification",
            icon: Icons.notifications_none_outlined,
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationScreen())),
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
            height: 0.2 * SizeConfig.imageSizeMultiplier,
          ),
          ProfileMenu(
            text: "Payment History",
            icon: Icons.receipt_long_outlined,
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaymentHistory())),
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            height: 0.2 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
          ),
          ProfileMenu(
            text: "Contact Us",
            icon: Icons.call,
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactUsScreen())),
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            height: 0.2 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
          ),
          ProfileMenu(
            text: "Terms & Conditions",
            icon: Icons.fact_check_outlined,
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => TermCondition())),
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            height: 0.2 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
          ),
          ProfileMenu(
            text: "Report Issue",
            icon: Icons.report_problem_outlined,
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReportIssue())),
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            height: 0.2 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
          ),
          ProfileMenu(
            text: "Sign Out",
            icon: Icons.logout,
            press: () async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.remove('token');
              localStorage.remove('userData');
              store.state.userDataState = null;
              store.state.notificationState = null;
              store.state.subTotalState = null;
              SharedPreferences getVariableProductStorage =
                  await SharedPreferences.getInstance();
              getVariableProductStorage.remove('variableProductData');
              store.state.cartProductState = [];
              store.state.getVariableProductState = null;
              store.state.promoCodeState = null;
              store.state.referralCodeState = null;
              store.state.cartDataState = [];
              store.state.giftVoucherState = null;
              store.state.logoutUserData = null;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => MyApp(),
              ));
            },
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            height: 0.2 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
          ),
        ],
      ),
    );
  }

  Future<void> _getUserBalanceData() async {
    var resUserBalance = await CallApi().getData('/app/user/balance/details');
    if (resUserBalance.statusCode == 200) {
      var body = json.decode(resUserBalance.body);
      print(body);
      setState(() {
        store.dispatch(UserBalanceAction(body));
      });
      setState(() {
        store.dispatch(IsLoadingAction(false)); //true chilo
      });
    }
  }

  Future<dynamic> multipartImageUpload() async {
    var fullUrl = 'https://dreamsgallerybd.com/app/upload-review-file';
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    File file = File(pickedFile.path);
    setState(() {
      fileImage = file;
    });
    var uri = Uri.parse(fullUrl);
    final mimeTypeData =
        lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', uri);

    // Attach the file in the request
    final files = await http.MultipartFile.fromPath('file', file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.files.add(files);

    // add headers if needed
    //imageUploadRequest.headers.addAll(<some-headers>);

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      setState(() async {
        store.dispatch(UserProfilePicAction(json.decode(response.body)));
        List.generate(store.state.userProfilePic.length,
            (index) => userImage = store.state.userProfilePic['file']);
        store.state.userDataState['image'] = userImage;
        print("======${store.state.userDataState['image']}");
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString(
            'userData', json.encode(store.state.userDataState));
        setState(() {
          store.state.userDataState =
              json.decode(localStorage.getString('userData')!);
          store.dispatch(UserDataAction(store.state.userDataState));
        });
        var data = {
          'customer': {
            'address': store.state.userDataState['customer']['address'],
            'customerName': store.state.userDataState['customer']
                ['customerName'],
            'email': store.state.userDataState['customer']['email'],
            'id': store.state.userDataState['customer']['id'],
            'facebook': store.state.userDataState['customer']['facebook'],
            'instagram': store.state.userDataState['customer']['instagram'],
            'postCode': store.state.userDataState['customer']['postCode'],
            'userId': store.state.userDataState['id'],
            'zone': store.state.userDataState['customer']['zone'],
            'zoneId': store.state.userDataState['customer']['zoneId'],
          },
          'email': store.state.userDataState['email'],
          'id': store.state.userDataState['id'],
          'name': store.state.userDataState['name'],
          'image': store.state.userDataState['image'],

          // 'deviceToken': deviceToken
        };

        var res = await CallApi().postData(data, '/app/user/edit');
        var body = json.decode(res.body);
        print('body - $body');
        print('res.statusCode  - ${res.statusCode}');
        if (res.statusCode == 200 && body['success'] == true) {
          _showMsg("Profile Updated Successfully!", 2);
        } else {
          _showMsg(body['message'], 1);
        }
      });

      return response.body;
    } catch (e) {
      print(e);
      return null;
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
