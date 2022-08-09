import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';

// ignore: must_be_immutable
class FinalPage extends StatelessWidget {
  SSLCTransactionInfoModel data;
  FinalPage(this.data);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Text(data.toJson().toString()));
  }
}
