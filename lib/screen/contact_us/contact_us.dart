import 'dart:convert';
import 'package:dream_gallary/api/api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constant.dart';
import '../../k_text_style.dart';
import '../../main.dart';
import '../../size_config.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController description = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == false ||
              store.state.darkModeState == null
          ? Colors.white
          : Color(0xFF0F0E0E),
      appBar: AppBar(
        elevation: 0.6,
        backgroundColor: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? Colors.white
            : Colors.grey[900],
        centerTitle: true,
        title: Text(
          "Contact Us",
          style: KTextStyle.headline5.copyWith(
            color: store.state.darkModeState == false ||
                    store.state.darkModeState == null
                ? Colors.black
                : Colors.grey[400],
          ),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 6 * SizeConfig.imageSizeMultiplier,
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
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
              "Contact Us",
              style: KTextStyle.subtitle1.copyWith(
                color: store.state.darkModeState == false ||
                        store.state.darkModeState == null
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(
                  Icons.house,
                  size: 7 * SizeConfig.imageSizeMultiplier,
                  color: store.state.darkModeState == false ||
                          store.state.darkModeState == null
                      ? Colors.black
                      : Colors.grey[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Address",
                  style: KTextStyle.subtitle2.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(
                    left: 4.0 * SizeConfig.imageSizeMultiplier,
                    top: 2.5 * SizeConfig.imageSizeMultiplier),
                child: Text(
                  "Showroom 1",
                  style: KTextStyle.bodyText3.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 4.0 * SizeConfig.imageSizeMultiplier,
                    top: 2.5 * SizeConfig.imageSizeMultiplier),
                child: Text(
                  "#904, City Centre, 9th floor, Zindabazar, Sylhet",
                  maxLines: 2,
                  style: KTextStyle.bodyText3.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 4.0 * SizeConfig.imageSizeMultiplier,
                    top: 2.5 * SizeConfig.imageSizeMultiplier),
                child: Text(
                  "Showroom 2",
                  style: KTextStyle.bodyText3.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 4.0 * SizeConfig.imageSizeMultiplier,
                    top: 2.5 * SizeConfig.imageSizeMultiplier),
                child: Text(
                  "#Shop 04, Ground Floor, Elegant Shopping Mall, Zindabazar, Sylhet",
                  maxLines: 2,
                  style: KTextStyle.bodyText3.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            height: 0.5 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(
                  Icons.mark_email_unread_outlined,
                  color: store.state.darkModeState == false ||
                          store.state.darkModeState == null
                      ? Colors.black
                      : Colors.grey[400],
                  size: 6 * SizeConfig.imageSizeMultiplier,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Email",
                  style: KTextStyle.subtitle2.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(
                    left: 4.0 * SizeConfig.imageSizeMultiplier,
                    top: 2.5 * SizeConfig.imageSizeMultiplier),
                child: Text(
                  "info@dreamgallerybd.com",
                  style: KTextStyle.bodyText3.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 4.0 * SizeConfig.imageSizeMultiplier,
                    top: 2.5 * SizeConfig.imageSizeMultiplier),
                child: Text(
                  "support@dreamgallerybd.com",
                  style: KTextStyle.bodyText3.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            height: 0.2 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
          ),
          Padding(
            padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(
                  Icons.phone,
                  color: store.state.darkModeState == false ||
                          store.state.darkModeState == null
                      ? Colors.black
                      : Colors.grey[400],
                  size: 6 * SizeConfig.imageSizeMultiplier,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Phone",
                  style: KTextStyle.subtitle2.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(
                    left: 4.0 * SizeConfig.imageSizeMultiplier,
                    top: 2.5 * SizeConfig.imageSizeMultiplier),
                child: Text(
                  "Mobile: +09678120120",
                  style: KTextStyle.bodyText3.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[400],
            indent: 4 * SizeConfig.imageSizeMultiplier,
            endIndent: 4 * SizeConfig.imageSizeMultiplier,
            height: 0.2 * SizeConfig.imageSizeMultiplier,
            thickness: 0.4,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
            child: Text(
              "Tell Us Your Message",
              style: KTextStyle.subtitle1.copyWith(
                color: store.state.darkModeState == false ||
                        store.state.darkModeState == null
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextFormField(
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.white,
                      ),
                      controller: name,
                      //onSaved: (newValue) => password = newValue,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                            vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Name*',
                        hintStyle: KTextStyle.bodyText4.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextFormField(
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.white,
                      ),
                      controller: email,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                            vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Email',
                        hintStyle: KTextStyle.bodyText4.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextFormField(
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.white,
                      ),
                      controller: contact,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                            vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Contact',
                        hintStyle: KTextStyle.bodyText4.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextFormField(
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.white,
                      ),
                      controller: subject,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                            vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Subject',
                        hintStyle: KTextStyle.bodyText4.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.only(
                      left: 2.1 * SizeConfig.imageSizeMultiplier,
                      right: 2.1 * SizeConfig.imageSizeMultiplier),
                  child: Container(
                    width: double.infinity,
                    height: 40 * SizeConfig.imageSizeMultiplier,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextFormField(
                      style: KTextStyle.bodyText4.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.white,
                      ),
                      controller: description,
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                            vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Type your message here...',
                        hintStyle: KTextStyle.bodyText4.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.5 * SizeConfig.imageSizeMultiplier),
                Padding(
                  padding: EdgeInsets.all(2.1 * SizeConfig.imageSizeMultiplier),
                  child: InkWell(
                    onTap: () {
                      _sendMessage();
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
                          child: Text(
                              _isLoading ? 'Please Wait...' : "Send Message",
                              style: KTextStyle.subtitle3.copyWith(
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

  Future<void> _sendMessage() async {
    print('on login button click');
    if (name.text.isEmpty) {
      return _showMsg('Name can\'t be empty !', 1);
    }
    if (email.text.isEmpty) {
      return _showMsg('Email can\'t be empty !', 1);
    }
    if (contact.text.isEmpty) {
      return _showMsg('Contact can\'t be empty !', 1);
    }
    if (subject.text.isEmpty) {
      return _showMsg('Subject can\'t be empty !', 1);
    }
    if (description.text.isEmpty) {
      return _showMsg('Description can\'t be empty !', 1);
    }

    setState(() {
      _isLoading = true;
    });
    var data = {
      'contact': contact.text,
      'content': description.text, //Controller.text
      'email': email.text,
      'name': name.text,
      'subject': subject.text,
    };

    print(data);

    var res = await CallApi().postData(data, '/app/contactus');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Send Message Succeed", 2);
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
