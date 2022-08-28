// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:sslcommerz_flutter/model/SSLCCustomerInfoInitializer.dart';
import 'package:sslcommerz_flutter/model/SSLCommerzInitialization.dart';
import 'package:sslcommerz_flutter/model/SSLCurrencyType.dart';
import 'package:sslcommerz_flutter/sslcommerz.dart';
import 'config.dart';

class EasySSLCommerz {
  double amount;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? customerCountry;
  String? customerPostCode;
  String? customerCity;
  String? customerAddress1;
  String? tranId;

  Sslcommerz? _sslcommerz;
  var ssl_store_id_live = 'dreamsgallerybdlive';
  var ssl_store_id_sandbox = 'dream5ecf34aa69953';
  var ssl_store_password_live = '5EA6BBABE216A23577';
  var ssl_store_password_sandbox = 'dream5ecf34aa69953@ssl';

  EasySSLCommerz({
    required this.amount,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.customerCountry,
    this.customerPostCode,
    this.customerAddress1,
    this.customerCity,
    this.tranId,
  }) {
    config();
  }
  void config() {
    _sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
            currency: SSLCurrencyType.BDT,
            product_category: "Cosmetic",
            sdkType: SSLCommerzConfig.TYPE,
            store_id: ssl_store_id_live,
            store_passwd: ssl_store_password_live,
            total_amount: amount,
            tran_id: tranId));

    _sslcommerz!.customerInfoInitializer = SSLCCustomerInfoInitializer(
        customerName: customerName,
        customerEmail: customerEmail,
        customerAddress1: customerAddress1,
        customerCity: customerCity,
        customerPostCode: customerPostCode,
        customerCountry: customerCountry,
        customerPhone: customerPhone);
  }

  Future<dynamic> payNow() async {
    return await _sslcommerz!.payNow();
  }

}
