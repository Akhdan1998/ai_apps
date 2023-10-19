part of 'services.dart';

class AiServices {
  static Future<ApiReturnValue<List<Ai>>?> getAi(String token, random_id,
      {http.Client? client}) async {
    String baseUrl =
        'https://dashboard.parentoday.com/api/chat/ai?random_id=${random_id}';
    if (client == null) {
      client = http.Client();
    }
    String url = baseUrl;
    var response = await client.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    // print('hahah' + response.body.toString());

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try Again');
    }
    var data = jsonDecode(response.body);
//jika backand berbentuk list
    List<Ai> value =
        (data['data'] as Iterable).map((e) => Ai.fromJson(e)).toList();
//jika backand tidak berbentuk list
    //CommunityGroup value1 = CommunityGroup.fromJson(data['data']);
    return ApiReturnValue(value: value);
  }
}
