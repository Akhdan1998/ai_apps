part of 'models.dart';

class AudioModel extends Equatable {
  int? id;
  String? userId;
  String? randomId;
  int? index;
  String? role;
  String? content;
  String? audioUrl;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  AudioModel({
    this.id,
    this.userId,
    this.randomId,
    this.index,
    this.role,
    this.content,
    this.audioUrl,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'],
      userId: json['user_id'],
      randomId: json['random_id'],
      index: json['index'],
      role: json['role'],
      content: json['content'],
      audioUrl: json['url_audio'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  @override
  List<Object?> get props => [
        userId,
        randomId,
        role,
        content,
        audioUrl,
      ];
}
