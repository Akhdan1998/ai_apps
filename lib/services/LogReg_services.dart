import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/logreg.dart';
import '../pages/pages.dart';
import 'package:get/get.dart';

void LogRegGoogle(
    String name, String userEmail, String uid, String imageUrl) async {
  Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/login_register');
  var res = await http.post(
    url_,
    body: {
      'nama': name,
      'email': userEmail,
      'uid': uid,
      'profile_photo_url': imageUrl,
    },
  );
  Map<String, dynamic> body = jsonDecode(res.body);
  if (res.statusCode == 200) {
    LoginUser data = LoginUser.fromJson(body['data']);

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('emailGoogle', data.access_token!).whenComplete(() {
      if (userEmail.isNotEmpty) {
        Get.off(HomePage(data.access_token!));
      }
    });
  } else {
    throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
  }
}
