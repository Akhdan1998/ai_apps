class HistoryModel {
  int? id;
  String? user_id;
  String? random_id;
  String? title;

  HistoryModel({this.id, this.user_id, this.random_id, this.title});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    random_id = json['random_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = user_id;
    data['random_id'] = random_id;
    data['title'] = title;
    return data;
  }
}
