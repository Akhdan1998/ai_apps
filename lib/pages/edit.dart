part of 'pages.dart';

class edit extends StatefulWidget {
  DataUser dataUser;
  final token;

  edit(this.dataUser, this.token);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  bool isLoading = false;

  final namaAndaEditingController = TextEditingController();

  void saveData(String namaAnda) async {
    Uri url = Uri.parse('https://dashboard.parentoday.com/api/user');
    var response = await http.post(
      url,
      body: {
        'nama': namaAndaEditingController.text,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    print(response.body.toString());
    Map<String, dynamic> body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      EditProfil data = EditProfil.fromJson(body['data']);
      context.read<DataUserCubit>().getData(widget.token);
      Get.off(HomePage(widget.token));
      Flushbar(
        backgroundColor: 'FF6969'.toColor(),
        borderRadius: BorderRadius.circular(10),
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        message: "Berhasil Menyimpan Data",
      ).show(context);
    } else {
      throw 'Error ${response.statusCode} => ${body['meta']['message']}';
    }
  }

  static Future<ApiReturnFoto<String>> uploadPhoto(File photoFile,
      {String? token, http.MultipartRequest? request}) async {
    String url = 'https://dashboard.parentoday.com/api/user/photo';
    var uri = Uri.parse(url);

    if (request == null) {
      request = http.MultipartRequest('POST', uri)
        ..headers["Content-Type"] = "application/json"
        ..headers["Authorization"] = "Bearer ${token}";
    }

    var multiPartFile =
        await http.MultipartFile.fromPath('file', photoFile.path);
    request.files.add(multiPartFile);
    var response = await request.send();
    String responseBody1 = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      print(responseBody.toString());
      String imagePath = data['data'];
      return ApiReturnFoto(value: imagePath, message: '');
    } else {
      return ApiReturnFoto(message: 'Upload Photo Gagal ', value: '');
    }
  }

  File? _image;

  Future getImage() async {
    final Image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (Image == null) return;
    final imageTemporary = File(Image.path);
    setState(() {
      this._image = imageTemporary;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<DataUserCubit>().getData(widget.token);
    namaAndaEditingController.text = widget.dataUser.nama!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: '888888'.toColor(),
          ),
        ),
        title: Text(
          'Edit Profil',
          style: GoogleFonts.poppins().copyWith(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: '747474'.toColor(),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              fit: StackFit.loose,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: _image != null
                        ? Container(
                            padding: EdgeInsets.all(10),
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover, image: FileImage(_image!)),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          )
                        : Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/mom.png'),
                              ),
                            ),
                          ),
                    // child: _image != null
                    //     ? Container(
                    //         width: 120,
                    //         height: 120,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(100),
                    //           image: DecorationImage(
                    //             fit: BoxFit.cover,
                    //             image: FileImage(_image!),
                    //           ),
                    //         ),
                    //       )
                    //     : (widget.dataUser.profile_photo_url ==
                    //             "https://dashboard.parentoday.com/storage/")
                    //         ? Container(
                    //             width: 120,
                    //             height: 120,
                    //             decoration: BoxDecoration(
                    //               color: Colors.red,
                    //               borderRadius: BorderRadius.circular(100),
                    //               image: const DecorationImage(
                    //                 fit: BoxFit.cover,
                    //                 image: AssetImage('assets/mom.png'),
                    //               ),
                    //             ),
                    //           )
                    //         : CircleAvatar(
                    //             radius: 70,
                    //             backgroundImage: NetworkImage(
                    //                 widget.dataUser.profile_photo_url ?? ''),
                    //             backgroundColor: Colors.white,
                    //           ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: 'FF6969'.toColor(),
                    ),
                    child:
                        const Icon(Icons.edit, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Anda',
                        style: GoogleFonts.poppins().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: '5A5A5A'.toColor(),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        cursorColor: 'FF6969'.toColor(),
                        controller: namaAndaEditingController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(width: 1, color: 'FF6969'.toColor()),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          hintStyle: GoogleFonts.poppins().copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: '989797'.toColor(),
                          ),
                          hintText: 'Nama panggilan',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       isLoading = true;
                  //     });
                  //     saveData(namaAndaEditingController.text);
                  //     uploadPhoto(_image!);
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //       color: 'FF6969'.toColor(),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: (isLoading = true)
                  //         ? Text(
                  //             'Simpan Data Pengguna',
                  //             style: GoogleFonts.poppins().copyWith(
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.bold,
                  //               color: 'FFFFFF'.toColor(),
                  //             ),
                  //           )
                  //         : Center(
                  //             child: SizedBox(
                  //               width: 20,
                  //               height: 20,
                  //               child: CircularProgressIndicator(
                  //                 strokeWidth: 2.5,
                  //                 color: 'FF6969'.toColor(),
                  //               ),
                  //             ),
                  //           ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isLoading = true;
            });
            saveData(namaAndaEditingController.text);
            uploadPhoto(_image!);
          },
          child: Container(
            alignment: Alignment.center,
            height: 35,
            decoration: BoxDecoration(
              color: 'FF6969'.toColor(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: (isLoading = true)
                ? Text(
                    'Simpan Data Pengguna',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: 'FFFFFF'.toColor(),
                    ),
                  )
                : Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: 'FF6969'.toColor(),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}