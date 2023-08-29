import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/api_return_history.dart';
import '../models/history.dart';

class HistoryServices {
  static Future<ApiReturnHistory<List<HistoryModel>>?> getHistory(String token,
      {http.Client? client}) async {
    String baseUrl = 'https://dashboard.parentoday.com/api/chat/ai/history';
    if (client == null) {
      client = http.Client();
    }
    String url = baseUrl;
    var response = await client.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    // print('History ${response.body}');
    if (response.statusCode != 200) {
      return ApiReturnHistory(message: 'Please try Again');
    }
    var data = jsonDecode(response.body);
//jika backand berbentuk list
    List<HistoryModel> value = (data['data'] as Iterable)
        .map((e) => HistoryModel.fromJson(e))
        .toList();
//jika backand tidak berbentuk list
    //CommunityGroup value1 = CommunityGroup.fromJson(data['data']);
    return ApiReturnHistory(value: value);
  }
}