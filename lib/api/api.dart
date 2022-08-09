import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  //final String _url = 'https://app.joincarevan.com';
  final String _url = 'https://dreamsgallerybd.com';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    print("full url is : $fullUrl");
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: await _setHeaders());
  }

  withoutTokenPostData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    //  print(await _setHeaders());
    print("full url is : $fullUrl");
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: await _setwithoutTokenHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.get(Uri.parse(fullUrl), headers: await _setHeaders());
  }

  withoutTokengetData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    return await http.get(Uri.parse(fullUrl),
        headers: await _setwithoutTokenHeaders());
  }

  _setHeaders() async => {
        "Authorization": 'Bearer ' + await _getToken(),
        'Content-type': 'application/json',
        'Accept': 'application/json',
  };

  _setwithoutTokenHeaders() async => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    print(localStorage.getString('token'));
    return localStorage.getString('token');
    //return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjQyLCJpYXQiOjE1OTIxNDkzMjR9.XndC7VCh-1ylmFkubcb-suknH54AbGYht9bcrzzUl_o';
  }
}
