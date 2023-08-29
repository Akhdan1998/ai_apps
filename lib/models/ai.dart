part of 'models.dart';

class Ai extends Equatable {
  int? id;
  String? user_id;
  String? random_id;
  int? index;
  String? role;
  String? content;
  String? audioUrl;
  dynamic created_at;
  dynamic updated_at;
  dynamic deleted_at;

  Ai(
      {this.id,
      this.user_id,
      this.random_id,
      this.index,
      this.role,
      this.content,
      this.audioUrl,
      this.created_at,
      this.updated_at,
      this.deleted_at});

  Ai.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    random_id = json['random_id'];
    index = json['index'];
    role = json['role'];
    content = json['content'];
    audioUrl = json['audioUrl'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    deleted_at = json['deleted_at'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [user_id, random_id, role, content, audioUrl];
}