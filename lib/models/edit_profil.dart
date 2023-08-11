class EditProfil {
  String? nama;

  EditProfil({this.nama});

  EditProfil.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    return data;
  }
}