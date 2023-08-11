class LoginUser {
  String? access_token;
  String? token_type;
  DataLogReg? user;

  LoginUser({this.access_token, this.token_type, this.user});

  LoginUser.fromJson(Map<String, dynamic> json) {
    access_token = json['access_token'];
    token_type = json['token_type'];
    user = json['user'] != null ? DataLogReg.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = access_token;
    data['token_type'] = token_type;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class DataLogReg {
  String? user_id;
  String? nama;
  String? profile_photo_url;
  String? email;
  String? nomor;

  DataLogReg(
      {this.user_id,
        this.nama,
        this.profile_photo_url,
        this.email,
        this.nomor});

  DataLogReg.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    nama = json['nama'];
    profile_photo_url = json['profile_photo_url'];
    email = json['email'];
    nomor = json['nomor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user_id;
    data['nama'] = nama;
    data['profile_photo_url'] = profile_photo_url;
    data['email'] = email;
    data['nomor'] = nomor;
    return data;
  }
}