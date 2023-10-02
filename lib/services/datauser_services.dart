import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_return_data.dart';
import '../models/data_user.dart';

class DataUserServices {
  static Future<ApiReturnData<DataUser>?> getData(String token,
      {http.Client? client}) async {
    // String baseUrl = 'https://dashboard.parentoday.com/api/user';
    String baseUrl = 'http://34.101.144.153/api/user';
    if (client == null) {
      client = http.Client();
    }
    String url = baseUrl;
    var response = await client.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${token}",
    });
    // print('hahah' + response.body.toString());

    if (response.statusCode != 200) {
      return ApiReturnData(message: 'Please try Again');
    }
    var data = jsonDecode(response.body);
    DataUser value = DataUser.fromJson(data['data']);
    return ApiReturnData(value: value);
  }
}
