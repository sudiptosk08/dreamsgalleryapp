import 'dart:convert';
import 'dart:io';
import 'package:dream_gallary/api/api.dart';
import 'package:dream_gallary/k_text_style.dart';
import 'package:dream_gallary/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import '../../constant.dart';
import '../../main.dart';
import '../../size_config.dart';
import 'package:http_parser/http_parser.dart';

class ReportIssue extends StatefulWidget {
  @override
  _ReportIssueState createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  var userId = store.state.userDataState['id'];
  bool isFile = false;
  var reportImage;
  File? fileImage;
  String? valueChoose;
  List<String> listItem = [
    "Delivery agent took Extra/Less money",
    "Issue with delivery agent",
    "I want to cancel my order",
    "I want to change the delivery information",
    "I want to change my registered mobile number",
    "Mistakenly place a double order",
    "Order status wrong",
    "Payment status wrong",
    "Put the delivery on hold",
    "Request to Exchange my order",
    "Requesting deliver on a fixed time and date",
    "The product was damage",
    "The product has not been delivered yet"
  ];
  TextEditingController orderId = TextEditingController();
  TextEditingController description = TextEditingController();

  get newValue => null;

  void initState() {
    _getAllReportData();
    super.initState();
  }

  Future<void> _getAllReportData() async {
    var res = await CallApi().getData('/app/reports');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    setState(() {
      store.state.reportState = body['data']['data'];
      store.dispatch(ReportAction(store.state.reportState));
    });
    setState(() {
      store.dispatch(IsLoadingAction(false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: store.state.darkModeState == false ||
              store.state.darkModeState == null
          ? Colors.white
          : Color(0xFF0F0E0E),
      appBar: AppBar(
        backgroundColor: store.state.darkModeState == false ||
                store.state.darkModeState == null
            ? Colors.white
            : Colors.grey[900],
        elevation: 0.6,
        title: Text(
          "Report Issue",
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
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.black
                  : Colors.grey[400],
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.all(3.1 * SizeConfig.imageSizeMultiplier),
                      child: Text(
                        "Select Reason*",
                        style: KTextStyle.subtitle4.copyWith(
                          color: store.state.darkModeState == false ||
                                  store.state.darkModeState == null
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 3.1 * SizeConfig.imageSizeMultiplier,
                          right: 3.1 * SizeConfig.imageSizeMultiplier),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 3.1 * SizeConfig.imageSizeMultiplier,
                            right: 3.1 * SizeConfig.imageSizeMultiplier),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: kSecondaryColor.withOpacity(0.1),
                        ),
                        child: DropdownButton(
                          hint: Text(
                            "Select",
                            style: KTextStyle.bodyText4.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          dropdownColor: Colors.grey[250],
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                          ),
                          value: valueChoose,
                          onChanged: (newValue) {
                            setState(() {
                              valueChoose = newValue.toString();
                            });
                          },
                          items: listItem.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: KTextStyle.bodyText4.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5 * SizeConfig.imageSizeMultiplier,
                      top: 3.1 * SizeConfig.imageSizeMultiplier,
                      right: 5 * SizeConfig.imageSizeMultiplier,
                      bottom: 3.1 * SizeConfig.imageSizeMultiplier,
                    ),
                    child: Text(
                      "Order Id*",
                      style: KTextStyle.subtitle4.copyWith(
                        color: store.state.darkModeState == false ||
                                store.state.darkModeState == null
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 5 * SizeConfig.imageSizeMultiplier,
                        right: 5 * SizeConfig.imageSizeMultiplier),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: TextFormField(
                        style: KTextStyle.bodyText4.copyWith(
                          color: store.state.darkModeState == false ||
                                  store.state.darkModeState == null
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                        controller: orderId,
                        keyboardType: TextInputType.phone,
                        onSaved: (newValue),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                              vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Order Id',
                          hintStyle: KTextStyle.bodyText4.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 5 * SizeConfig.imageSizeMultiplier,
                  top: 3.1 * SizeConfig.imageSizeMultiplier,
                  right: 5 * SizeConfig.imageSizeMultiplier,
                  bottom: 3.1 * SizeConfig.imageSizeMultiplier,
                ),
                child: Text(
                  "Description*",
                  style: KTextStyle.subtitle4.copyWith(
                    color: store.state.darkModeState == false ||
                            store.state.darkModeState == null
                        ? Colors.black
                        : Colors.grey[400],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 5 * SizeConfig.imageSizeMultiplier,
                    right: 5 * SizeConfig.imageSizeMultiplier),
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
                          : Colors.grey[400],
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
                      hintText: 'Description',
                      hintStyle: KTextStyle.bodyText4.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //uploaded image

          if (fileImage != null) buildFileImage(),
          //if (memoryImage != null) buildMemoryImage(),
          Padding(
            padding: EdgeInsets.all(5 * SizeConfig.imageSizeMultiplier),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 2.1 * SizeConfig.imageSizeMultiplier,
                      vertical: 3.1 * SizeConfig.imageSizeMultiplier),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        multipartImageUpload();
                      });
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.insert_drive_file_outlined,
                            color: Colors.grey,
                          ),
                          Text(
                            "Upload The Attachtment ",
                            textAlign: TextAlign.center,
                            style: KTextStyle.bodyText4.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ]),
                  ),
                )),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
                5.0 * SizeConfig.imageSizeMultiplier,
                2.2 * SizeConfig.imageSizeMultiplier,
                5.0 * SizeConfig.imageSizeMultiplier,
                2.2 * SizeConfig.imageSizeMultiplier),
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
                    child: Text("Submit",
                        style: KTextStyle.buttonText3.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center)),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 3 * SizeConfig.imageSizeMultiplier,
              top: 3.1 * SizeConfig.imageSizeMultiplier,
              right: 2 * SizeConfig.imageSizeMultiplier,
              bottom: 1.5 * SizeConfig.imageSizeMultiplier,
            ),
            child: Text(
              "Report History*",
              style: KTextStyle.subtitle4.copyWith(
                color: store.state.darkModeState == false ||
                        store.state.darkModeState == null
                    ? Colors.black
                    : Colors.grey[400],
                decorationColor: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              color: store.state.darkModeState == false ||
                      store.state.darkModeState == null
                  ? Colors.white
                  : Colors.grey[900],
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 15 * SizeConfig.imageSizeMultiplier,
                            height: 8 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                              color: store.state.darkModeState == false ||
                                      store.state.darkModeState == null
                                  ? Colors.grey[200]
                                  : Colors.grey[900],
                              border: Border.all(
                                  color: Colors.grey[350]!, width: 1),
                            ),
                            child: Text(
                              "SN",
                              style: KTextStyle.bodyText4
                                  .copyWith(color: Colors.grey[700]),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 25 * SizeConfig.imageSizeMultiplier,
                            height: 8 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.grey[200]
                                    : Colors.grey[900],
                                border: Border(
                                  right: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  bottom: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  top: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                )),
                            child: Text(
                              "Report ID",
                              style: KTextStyle.bodyText4
                                  .copyWith(color: Colors.grey[700]),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 30 * SizeConfig.imageSizeMultiplier,
                            height: 8 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.grey[200]
                                    : Colors.grey[900],
                                border: Border(
                                  right: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  bottom: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  top: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                )),
                            child: Text(
                              "Date",
                              style: KTextStyle.bodyText4
                                  .copyWith(color: Colors.grey[700]),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 30 * SizeConfig.imageSizeMultiplier,
                            height: 8 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.grey[200]
                                    : Colors.grey[900],
                                border: Border(
                                  right: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  bottom: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  top: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                )),
                            child: Text(
                              "Order ID",
                              style: KTextStyle.bodyText4
                                  .copyWith(color: Colors.grey[700]),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 45 * SizeConfig.imageSizeMultiplier,
                            height: 8 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.grey[200]
                                    : Colors.grey[900],
                                border: Border(
                                  right: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  bottom: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  top: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                )),
                            child: Text(
                              "Reason",
                              style: KTextStyle.bodyText4
                                  .copyWith(color: Colors.grey[700]),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 45 * SizeConfig.imageSizeMultiplier,
                            height: 8 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.grey[200]
                                    : Colors.grey[900],
                                border: Border(
                                  right: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  bottom: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  top: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                )),
                            child: Text(
                              "Description",
                              style: KTextStyle.bodyText4
                                  .copyWith(color: Colors.grey[700]),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 20 * SizeConfig.imageSizeMultiplier,
                            height: 8 * SizeConfig.imageSizeMultiplier,
                            decoration: BoxDecoration(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.grey[200]
                                    : Colors.grey[900],
                                border: Border(
                                  right: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  bottom: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                  top: BorderSide(
                                      color: Colors.grey[350]!, width: 1),
                                )),
                            child: Text(
                              "Status",
                              style: KTextStyle.bodyText4
                                  .copyWith(color: Colors.grey[700]),
                            ),
                          ),
                        ]),
                    ...List.generate(
                      store.state.reportState.length,
                      (index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 15 * SizeConfig.imageSizeMultiplier,
                              height: 20 * SizeConfig.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                color: store.state.darkModeState == false ||
                                        store.state.darkModeState == null
                                    ? Colors.white
                                    : Colors.grey[800],
                                border: Border.all(
                                    color: Colors.grey[350]!, width: 1),
                              ),
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.grey[700]
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 25 * SizeConfig.imageSizeMultiplier,
                              height: 20 * SizeConfig.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.white
                                      : Colors.grey[800],
                                  border: Border(
                                    right: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    bottom: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    top: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                  )),
                              child: Text(
                                "RX${store.state.reportState[index]['id'].toString()}",
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.grey[700]
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: 30 * SizeConfig.imageSizeMultiplier,
                              height: 20 * SizeConfig.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.white
                                      : Colors.grey[800],
                                  border: Border(
                                    right: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    bottom: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    top: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                  )),
                              child: Text(
                                store.state.reportState[index]['created_at'],
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.grey[700]
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 30 * SizeConfig.imageSizeMultiplier,
                              height: 20 * SizeConfig.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.white
                                      : Colors.grey[800],
                                  border: Border(
                                    right: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    bottom: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    top: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                  )),
                              child: Text(
                                "${store.state.reportState[index]['orderId']}",
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.grey[700]
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 45 * SizeConfig.imageSizeMultiplier,
                              height: 20 * SizeConfig.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.white
                                      : Colors.grey[800],
                                  border: Border(
                                    right: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    bottom: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    top: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                  )),
                              child: Text(
                                store.state.reportState[index]['reason'],
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.grey[700]
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 45 * SizeConfig.imageSizeMultiplier,
                              height: 20 * SizeConfig.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.white
                                      : Colors.grey[800],
                                  border: Border(
                                    right: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    bottom: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    top: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                  )),
                              child: Text(
                                store.state.reportState[index]['description'],
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.grey[700]
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 20 * SizeConfig.imageSizeMultiplier,
                              height: 20 * SizeConfig.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                  color: store.state.darkModeState == false ||
                                          store.state.darkModeState == null
                                      ? Colors.white
                                      : Colors.grey[800],
                                  border: Border(
                                    right: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    bottom: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                    top: BorderSide(
                                        color: Colors.grey[350]!, width: 1),
                                  )),
                              child: Text(
                                store.state.reportState[index]['status'],
                                style: KTextStyle.bodyText4.copyWith(
                                  color: store.state.reportState[index]
                                              ['status'] ==
                                          "Solved"
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFileImage() => Column(
        children: [
          const SizedBox(height: 16),
          Image.file(
            fileImage!,
            width: 88 * SizeConfig.imageSizeMultiplier,
            height: 80 * SizeConfig.imageSizeMultiplier,
            fit: BoxFit.cover,
          ),
        ],
      );
  Future<void> _handleSaveChange() async {
    print('on submit button click');
    if (valueChoose!.isEmpty) {
      return _showMsg('Reason is empty !', 1);
    }
    if (orderId.text.isEmpty) {
      return _showMsg('OrderId can\'t be empty !', 1);
    }
    if (description.text.isEmpty) {
      return _showMsg('District PostalCode can\'t be empty !', 1);
    }
    List.generate(
      store.state.reportImageState.length,
      (index) => reportImage = store.state.reportImageState['file'],
    );
    print(reportImage);
    var data = {
      'reason': valueChoose,
      'orderId': orderId.text, //Controller.text
      'description': description.text,
      'image': reportImage,
      'userId': userId,
    };

    print(data);

    var res = await CallApi().postData(data, '/app/reports');
    var body = json.decode(res.body);
    print('body - $body');
    print('res.statusCode  - ${res.statusCode}');
    if (res.statusCode == 200 && body['success'] == true) {
      _showMsg("Submit Successful", 2);
      setState(() {
        valueChoose = "";
        orderId.clear();
        description.clear();
      });
    } else {
      _showMsg(body['message'], 1);
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
      setState(() {
        store.dispatch(ReportImageAction(json.decode(response.body)));
      });
      return response.body;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
