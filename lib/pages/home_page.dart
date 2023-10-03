part of 'pages.dart';

const colorizeColors = [
  Colors.grey,
  Colors.white,
  Colors.grey,
];
const colorizeStyle = TextStyle(
  fontSize: 10,
);

class HomePage extends StatefulWidget {
  final token;

  const HomePage(this.token, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController? controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final tanya1 = TextEditingController(text: 'Menangani tantrum pada anak');
  final tanya2 = TextEditingController(text: 'Resep mpasi untuk bayi');
  final tanya3 = TextEditingController(text: 'Cara mengatasi anak susah makan');
  final pertanyaan = TextEditingController();
  final pertanyaanBaru = TextEditingController();
  final PrefServices _prefServices = PrefServices();
  FocusNode focusNode = FocusNode();
  File? audioFile;
  bool isLoading = false;
  bool showOverlay = false;
  bool show = false;
  bool showContoh = false;
  bool voice = false;
  bool play = false;
  bool isRecorderReady = false;
  int i = 0;
  String? time;
  String? _urlAudio;

  @override
  void initState() {
    super.initState();

    controller = ScrollController();

    time = DateTime.now().millisecondsSinceEpoch.toString();
    context.read<AiCubit>().getAi(widget.token, time!);
    context.read<DataUserCubit>().getData(widget.token);
    context.read<HistoryCubit>().getHistory(widget.token);
    initRecorder();
    _prefServices.historyCache().then((value) {
      if (value != null) {
        setState(() {
          selectedRandomId = value;
        });

        context
            .read<AiCubit>()
            .getAi(widget.token, selectedRandomId ?? '');

        showContoh = true;
      } else {}
    });

    _prefServices.themeCache().then((value) {
      if (value != null && value != '') {
        String stringValue = value;
        bool boolValue = stringValue.toLowerCase() == "true";

        setState(() {
          darkLight = boolValue;
        });
      } else {}
    });

    showContoh = true;
  }

  @override
  void dispose() {
    super.dispose();
    recorder.closeRecorder();
  }

  void logout(String id) async {
    // Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/logout');
    Uri url_ = Uri.parse('http://34.101.144.153/api/logout');
    var res = await http.post(
      url_,
      headers: {
        "Accept": "application/json",
        "Authorization": 'Bearer ${widget.token}'
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    print("logouttttt ${res.body}");
    if (res.statusCode == 200) {
      bool data = body["data"];
      print("logout sukses ${res.body}");
      print("logout token sukses ${widget.token}");

      Get.offAll(
        LoginPage(),
      );
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  Future<List<Ai>> cari() async {
    // Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/chat/ai');
    Uri url_ = Uri.parse('http://34.101.144.153/api/chat/ai');
    var res = await http.post(
      url_,
      body: {
        'prompt': pertanyaan.text,
        'random_id': (selectedRandomId != null) ? selectedRandomId : time,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List<Ai> value =
          (body['data'] as Iterable).map((e) => Ai.fromJson(e)).toList();

      await context.read<AiCubit>().getAi(
          widget.token, (selectedRandomId != null) ? selectedRandomId! : time!);

      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  Future<List<Ai>> contoh1() async {
    // Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/chat/ai');
    Uri url_ = Uri.parse('http://34.101.144.153/api/chat/ai');
    var res = await http.post(
      url_,
      body: {
        'prompt': tanya1.text,
        'random_id': (selectedRandomId != null) ? selectedRandomId : time,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List<Ai> value =
          (body['data'] as Iterable).map((e) => Ai.fromJson(e)).toList();

      await context.read<AiCubit>().getAi(
          widget.token, (selectedRandomId != null) ? selectedRandomId! : time!);

      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  Future<List<Ai>> contoh2() async {
    // Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/chat/ai');
    Uri url_ = Uri.parse('http://34.101.144.153/api/chat/ai');
    var res = await http.post(
      url_,
      body: {
        'prompt': tanya2.text,
        'random_id': (selectedRandomId != null) ? selectedRandomId : time,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List<Ai> value =
          (body['data'] as Iterable).map((e) => Ai.fromJson(e)).toList();

      await context.read<AiCubit>().getAi(
          widget.token, (selectedRandomId != null) ? selectedRandomId! : time!);

      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  Future<List<Ai>> contoh3() async {
    // Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/chat/ai');
    Uri url_ = Uri.parse('http://34.101.144.153/api/chat/ai');
    var res = await http.post(
      url_,
      body: {
        'prompt': tanya3.text,
        'random_id': (selectedRandomId != null) ? selectedRandomId : time,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      List<Ai> value =
          (body['data'] as Iterable).map((e) => Ai.fromJson(e)).toList();

      await context.read<AiCubit>().getAi(
          widget.token, (selectedRandomId != null) ? selectedRandomId! : time!);

      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  Future<List<AudioModel>> botAudio() async {
    Uri url_ = Uri.parse('https://dashboard.parentoday.com/api/chat/ai/audio');
    var res = await http.post(
      url_,
      body: {
        'url_audio': _urlAudio,
        'random_id': (selectedRandomId != null) ? selectedRandomId : time,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.token}",
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    print('respose belum berhasil ${res.body}');
    if (res.statusCode == 200) {
      List<AudioModel> value = (body['data'] as Iterable)
          .map((e) => AudioModel.fromJson(e))
          .toList();
      print('respose audio berhasil ${res.statusCode}');

      await context.read<AiCubit>().getAi(
          widget.token, (selectedRandomId != null) ? selectedRandomId! : time!);

      return value;
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  Future<ApiReturnAudio<String>> uploadAudio(File audioFile,
      {String? token, http.MultipartRequest? request}) async {
    String url = 'https://dashboard.parentoday.com/api/chat/ai/audio/upload';

    var uri = Uri.parse(url);
    request = http.MultipartRequest('POST', uri)
      ..headers["Content-Type"] = "application/json"
      ..headers["Authorization"] = "Bearer ${widget.token}";

    var multiPartFile =
        await http.MultipartFile.fromPath('file', audioFile.path);
    request.files.add(multiPartFile);

    var response = await request.send();
    String responseBody1 = await response.stream.bytesToString();
    print('response body gagal $responseBody1');
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print('response body sukses $responseBody');

      var data = jsonDecode(responseBody);
      _urlAudio = data['data'];

      return ApiReturnAudio(value: _urlAudio, message: '');
    } else {
      return ApiReturnAudio(message: 'Upload Audio Gagal ', value: '');
    }
  }

  // String statusText = "";
  // bool isComplete = false;
  // late String recordFilePath;
  //
  // Future<bool> checkPermission() async {
  //   Map<Permission, PermissionStatus> status = await [
  //     Permission.storage,
  //     Permission.microphone,
  //   ].request();
  //
  //   print(status[Permission.microphone]);
  //
  //   return status[Permission.microphone]!.isGranted;
  // }
  //
  // void recordMp3() async {
  //   bool hasPermission = await checkPermission();
  //   if (hasPermission) {
  //     statusText = "正在录音中...";
  //     recordFilePath = await getFilePath();
  //     isComplete = false;
  //     RecordMp3.instance.start(recordFilePath, (type) {
  //       statusText = "录音失败--->$type";
  //       setState(() {});
  //     });
  //   } else {
  //     statusText = "没有录音权限";
  //   }
  //   setState(() {});
  // }
  //
  // void stopMp3() {
  //   bool s = RecordMp3.instance.stop();
  //   if (s) {
  //     statusText = "录音已完成";
  //     isComplete = true;
  //     setState(() {});
  //   }
  //   print('recorded stoped $s');
  // }
  //
  // Future<String> getFilePath() async {
  //   Directory storageDirectory = await getApplicationDocumentsDirectory();
  //   String sdPath = "${storageDirectory.path}/record";
  //   var directory = Directory(sdPath);
  //   if (!directory.existsSync()) {
  //     directory.createSync(recursive: true);
  //   }
  //   return "$sdPath/test_${i++}.mp3";
  // }

  Future soundRecord() async {
    await recorder.startRecorder(
      toFile: 'audio',
      // codec : Codec.mp3,
    );
  }

  Future soundStop() async {
    final isPath = await recorder.stopRecorder();
    audioFile = File(isPath!);
    print('Recorded audio Flutter Sound: $isPath');
    uploadAudio(audioFile!);
    // botAudio();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permissions not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  // String storage = '/data/user/0/com.parentoday.ai_apps/cache';
  // String namaAudio = '/data/user/0/com.parentoday.ai_apps/cache/';

  // Future<String> convertToMp3() async {
  //   final String inputPath = audioFile!.path;
  //   final String outputPath = "${storage}/output_shit.mp3";

  //   final rc = await FFmpegKit.execute(
  //     '-i $inputPath -c:v mp3 $outputPath', // Specify the codec for MP3 conversion.
  //   );

  //   final returnCode = await rc.getReturnCode();

  //   if (returnCode!.isValueSuccess()) {
  //     print('Konversi selesai. File MP3 tersimpan di $outputPath');
  //   } else {
  //     print('Konversi gagal');
  //   }

  //   return outputPath;
  // }

  // Future<void> convertToMp3() async {
  //   FFmpegKit.executeAsync('-i $storage -c:v mp3 $namaAudio', (session) async {
  //     final returnCode = await session.getReturnCode();
  //
  //     if (ReturnCode.isSuccess(returnCode)) {
  //
  //       // SUCCESS
  //       print('sukses $returnCode');
  //     } else if (ReturnCode.isCancel(returnCode)) {
  //
  //       // CANCEL
  //       print('cancel $returnCode');
  //     } else {
  //
  //       // ERROR
  //       print('error');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: CircularProgressIndicator(
          color: (darkLight != true) ? textDark : warnaUtama,
        ),
      ),
      child: Scaffold(
        backgroundColor: (darkLight != true) ? dasarDark : dasarLight,
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          shadowColor: (darkLight != true)
              ? textDark
              : navigasiDark,
          backgroundColor: (darkLight != true) ? navigasiDark : textDark,
          automaticallyImplyLeading: false,
          elevation: 1.5,
          iconTheme: IconThemeData(
              color: (darkLight != true) ? textDark : buttonLight1),
          toolbarHeight: 65,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A.I Parentoday',
                    style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.bold,
                      color: (darkLight != true) ? textDark : textLight1,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                      'Menjawab semua masalah parentingmu dengan cepat dan efisien',
                      maxLines: 2,
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.w300,
                        color: (darkLight != true) ? textDark : textLight2,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    (darkLight = !darkLight);
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('darkLight', darkLight.toString());
                },
                child: Container(
                  color: (darkLight != true) ? navigasiDark : textDark,
                  child: (darkLight != true)
                      ? Icon(
                          Icons.wb_sunny,
                          color: (darkLight != true) ? textDark : buttonLight1,
                          size: 20,
                        )
                      : Icon(
                          Icons.dark_mode,
                          color: (darkLight != true) ? textDark : buttonLight1,
                          size: 20,
                        ),
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<DataUserCubit, DataUserState>(
          builder: (context, state) {
            if (state is DataUserLoaded) {
              if (state.dataUser != null) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    //contoh
                    (voice != true)
                        ? (showContoh != true)
                            ? Positioned(
                                top: 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(15),
                                  color: (darkLight != true)
                                      ? dasarDark
                                      : contohLight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/parentoday.png',
                                          scale: 2),
                                      SizedBox(width: 10),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                65,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Selamat datang di AI Parenting! Saya siap membantu Anda sebagai orang tua dengan saran dan dukungan dalam mengasuh anak-anak Anda dari bayi hingga remaja. Tanya saja tentang nutrisi, jadwal tidur, pengembangan emosional, dan aktivitas bermain yang menyenangkan.',
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                fontSize: 12,
                                                color: (darkLight != true)
                                                    ? textDark
                                                    : textLight3,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              'Contoh:',
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: (darkLight != true)
                                                    ? textDark
                                                    : textLight3,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Wrap(
                                              spacing: 8,
                                              runSpacing: 8,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    focusNode.unfocus();

                                                    if (tanya1
                                                        .text.isNotEmpty) {
                                                      setState(() {
                                                        isLoading = true;
                                                        show = true;
                                                        context.loaderOverlay
                                                            .show();
                                                      });
                                                      await contoh1()
                                                          .whenComplete(() {
                                                        setState(() {
                                                          isLoading = false;
                                                          show = false;
                                                          showContoh = true;
                                                          context.loaderOverlay
                                                              .hide();
                                                        });
                                                      });
                                                    }
                                                    context
                                                        .read<HistoryCubit>()
                                                        .getHistory(
                                                            widget.token);
                                                  },
                                                  child: Chip(
                                                    backgroundColor:
                                                        (darkLight != true)
                                                            ? navigasiDark
                                                            : buttonLight2,
                                                    label: Text(
                                                      'Menangani tantrum pada anak',
                                                      style:
                                                          GoogleFonts.poppins()
                                                              .copyWith(
                                                        fontSize: 11,
                                                        color:
                                                            (darkLight != true)
                                                                ? textDark
                                                                : textLight3,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    focusNode.unfocus();
                                                    if (tanya2
                                                        .text.isNotEmpty) {
                                                      setState(() {
                                                        isLoading = true;
                                                        show = true;
                                                        context.loaderOverlay
                                                            .show();
                                                      });
                                                      await contoh2()
                                                          .whenComplete(() {
                                                        setState(() {
                                                          isLoading = false;
                                                          show = false;
                                                          showContoh = true;
                                                          context.loaderOverlay
                                                              .hide();
                                                        });
                                                      });
                                                    }
                                                    context
                                                        .read<HistoryCubit>()
                                                        .getHistory(
                                                            widget.token);
                                                  },
                                                  child: Chip(
                                                    backgroundColor:
                                                        (darkLight != true)
                                                            ? navigasiDark
                                                            : buttonLight2,
                                                    label: Text(
                                                      'Resep mpasi untuk bayi',
                                                      style:
                                                          GoogleFonts.poppins()
                                                              .copyWith(
                                                        fontSize: 11,
                                                        color:
                                                            (darkLight != true)
                                                                ? textDark
                                                                : textLight3,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    focusNode.unfocus();

                                                    if (tanya3
                                                        .text.isNotEmpty) {
                                                      setState(() {
                                                        isLoading = true;
                                                        show = true;
                                                        context.loaderOverlay
                                                            .show();
                                                      });
                                                      await contoh3()
                                                          .whenComplete(() {
                                                        setState(() {
                                                          isLoading = false;
                                                          show = false;
                                                          showContoh = true;
                                                          context.loaderOverlay
                                                              .hide();
                                                        });
                                                      });
                                                    }
                                                    context
                                                        .read<HistoryCubit>()
                                                        .getHistory(
                                                            widget.token);
                                                  },
                                                  child: Chip(
                                                    backgroundColor:
                                                        (darkLight != true)
                                                            ? navigasiDark
                                                            : buttonLight2,
                                                    label: Text(
                                                      'Cara mengatasi anak susah makan',
                                                      style:
                                                          GoogleFonts.poppins()
                                                              .copyWith(
                                                        fontSize: 11,
                                                        color:
                                                            (darkLight != true)
                                                                ? textDark
                                                                : textLight3,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container()
                        : Container(),
                    //chatPopup
                    (voice != true)
                        //teks
                        ? Positioned(
                            top: 0,
                            child: Container(
                              height: MediaQuery.of(context).size.height - 140,
                              padding: const EdgeInsets.only(bottom: 40),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                reverse: true,
                                child: BlocBuilder<AiCubit, AiState>(
                                  builder: (context, snapshot) {
                                    if (snapshot is AiLoaded) {
                                      if (snapshot.ai != null) {
                                        return Column(
                                          children: snapshot.ai!
                                              .mapIndexed(
                                                (int index, e) =>
                                                    (e.role == "user")
                                                        ? ChatUserCard(
                                                            e,
                                                            state.dataUser!,
                                                            widget.token,
                                                          )
                                                        : ChatRobotCard(
                                                            e, widget.token),
                                              )
                                              .toList(),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ),
                            ),
                          )
                        //voice
                        : Positioned(
                            top: 0,
                            child: Container(
                              height: MediaQuery.of(context).size.height - 140,
                              padding: const EdgeInsets.only(bottom: 40),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                reverse: true,
                                child: BlocBuilder<AiCubit, AiState>(
                                  builder: (context, snapshot) {
                                    if (snapshot is AiLoaded) {
                                      if (snapshot.ai != null) {
                                        return Column(children: [
                                          VoiceUserCard(
                                            state.dataUser!,
                                            widget.token,
                                          )
                                        ]);
                                        // return Column(
                                        //   children: snapshot.ai!
                                        //       .mapIndexed(
                                        //         (int index, e) =>
                                        //             (e.role == "user")
                                        //                 ? VoiceUserCard(
                                        //                     e,
                                        //                     state.dataUser!,
                                        //                     widget.token,
                                        //                   )
                                        //                 : ChatRobotCard(
                                        //                     e,
                                        //                     widget.token,
                                        //                   ),
                                        //       )
                                        //       .toList(),
                                        // );
                                      } else {
                                        return const SizedBox();
                                      }
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                    //BOTTOM NAVIGATION
                    (voice != true)
                        //keyboard
                        ? Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: (darkLight != true)
                                    ? navigasiDark
                                    : textDark,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.only(
                                  top: 11, bottom: 11, right: 16, left: 16),
                              child: Column(
                                children: [
                                  (show == true)
                                      ? Text(
                                          'Sebentar ya Moms, kami sedang mencarikan jawaban dari pertanyaan kamu...',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins().copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: (darkLight != true)
                                                ? textDark
                                                : textLight4,
                                            fontSize: 11,
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                78,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: TextField(
                                          onSubmitted: (value) async {
                                            focusNode.unfocus();

                                            if (pertanyaan.text.isNotEmpty) {
                                              setState(() {
                                                isLoading = true;
                                                show = true;
                                                context.loaderOverlay.show();
                                              });
                                              await cari().whenComplete(() {
                                                setState(() {
                                                  isLoading = false;
                                                  show = false;
                                                  context.loaderOverlay.hide();
                                                  pertanyaan.text = '';
                                                  showContoh = true;
                                                });
                                              });
                                            }
                                            context
                                                .read<HistoryCubit>()
                                                .getHistory(widget.token);
                                          },
                                          style: TextStyle(
                                              color: (darkLight != true)
                                                  ? textDark
                                                  : textLight5),
                                          focusNode: focusNode,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          cursorColor: (darkLight != true)
                                              ? textDark
                                              : warnaUtama,
                                          controller: pertanyaan,
                                          decoration: InputDecoration(
                                            fillColor: (darkLight != true)
                                                ? textFieldDark
                                                : textFieldLight,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: (darkLight != true)
                                                    ? textFieldDark
                                                    : textFieldLight,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: (darkLight != true)
                                                    ? dasarDark
                                                    : warnaUtama,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 10,
                                                    top: 5,
                                                    bottom: 5),
                                            hintStyle:
                                                GoogleFonts.poppins().copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: (darkLight != true)
                                                  ? textDark
                                                  : textLight6,
                                            ),
                                            hintText:
                                                'Tanya seputar parenting...',
                                            border: OutlineInputBorder(
                                              // borderSide: BorderSide(color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () async {
                                          focusNode.unfocus();

                                          if (pertanyaan.text.isNotEmpty) {
                                            setState(() {
                                              isLoading = true;
                                              show = true;
                                              context.loaderOverlay.show();
                                            });
                                            await cari().whenComplete(() {
                                              setState(() {
                                                isLoading = false;
                                                show = false;
                                                context.loaderOverlay.hide();
                                                pertanyaan.text = '';
                                                showContoh = true;
                                              });
                                            });
                                          }
                                          context
                                              .read<HistoryCubit>()
                                              .getHistory(widget.token);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: (darkLight != true)
                                                ? dasarDark
                                                : warnaUtama,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: isLoading
                                              ? SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: textDark,
                                                            strokeWidth: 2),
                                                  ),
                                                )
                                              : Icon(Icons.send,
                                                  color: textDark, size: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Do not completely rely on the answers provided by this AI without confirming them with other reliable sources.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins().copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: (darkLight != true)
                                          ? textDark
                                          : textLight4,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        //voice
                        : Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: (darkLight != true)
                                    ? navigasiDark
                                    : textDark,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.only(
                                  top: 11, bottom: 11, right: 16, left: 16),
                              child: Column(
                                children: [
                                  (show == true)
                                      ? Text(
                                          'Sebentar ya Moms, kami sedang mencarikan jawaban dari pertanyaan kamu...',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins().copyWith(
                                            fontWeight: FontWeight.w300,
                                            color: (darkLight != true)
                                                ? textDark
                                                : textLight4,
                                            fontSize: 11,
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                78,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: (darkLight != true)
                                              ? textFieldDark
                                              : textFieldLight,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            StreamBuilder<RecordingDisposition>(
                                                stream: recorder.onProgress,
                                                builder: (context, shashoot) {
                                                  final duration = shashoot
                                                          .hasData
                                                      ? shashoot.data!.duration
                                                      : Duration.zero;

                                                  String twoDigits(int n) => n
                                                      .toString()
                                                      .padLeft(2, '0');

                                                  final twoDigitMinutes =
                                                      twoDigits(duration
                                                          .inMinutes
                                                          .remainder(60));
                                                  final twoDigitSeconds =
                                                      twoDigits(duration
                                                          .inSeconds
                                                          .remainder(60));
                                                  return Text(
                                                    (play == true)
                                                        ? '$twoDigitMinutes:$twoDigitSeconds'
                                                        : "00:00",
                                                    style: GoogleFonts.poppins()
                                                        .copyWith(
                                                      fontSize: 12,
                                                      color: (darkLight != true)
                                                          ? textDark
                                                          : textLight3,
                                                    ),
                                                  );
                                                }),
                                            (play == true)
                                                ? AnimatedTextKit(
                                                    isRepeatingAnimation: true,
                                                    repeatForever: true,
                                                    animatedTexts: [
                                                      ColorizeAnimatedText(
                                                        'Tanyakan dengan suara',
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textStyle:
                                                            colorizeStyle,
                                                        colors: colorizeColors,
                                                        speed: const Duration(
                                                            milliseconds: 150),
                                                      )
                                                    ],
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            play = !play;
                                          });
                                          if (recorder.isRecording) {
                                            await soundStop();
                                            setState(() {});
                                            // stopMp3();
                                            // await uploadAudio(audioFile!);
                                          } else {
                                            await soundRecord();
                                            setState(() {});
                                            // recordMp3();
                                          }
                                          // context.read<HistoryCubit>().getHistory(widget.token);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: (darkLight != true)
                                                ? textFieldDark
                                                : warnaUtama,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: (play != true)
                                              ? Icon(
                                                  Icons.keyboard_voice,
                                                  color: textDark,
                                                  size: 20,
                                                )
                                              : Icon(
                                                  Icons.pause,
                                                  color: textDark,
                                                  size: 20,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Do not completely rely on the answers provided by this AI without confirming them with other reliable sources.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins().copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: (darkLight != true)
                                          ? textDark
                                          : textLight2,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          },
        ),
        endDrawer: Drawer(
          backgroundColor: (darkLight != true) ? navigasiDark : textDark,
          child: Stack(
            children: [
              Positioned(
                top: 30,
                left: 15,
                right: 15,
                child: BlocBuilder<DataUserCubit, DataUserState>(
                  builder: (context, snapshot) {
                    if (snapshot is DataUserLoaded) {
                      if (snapshot.dataUser != null) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundImage: NetworkImage(
                                        snapshot.dataUser!.profile_photo_url ??
                                            ''),
                                    backgroundColor: (darkLight != true)
                                        ? navigasiDark
                                        : textDark,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.dataUser!.nama ?? '',
                                        style: GoogleFonts.poppins().copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: (darkLight != true)
                                              ? textDark
                                              : textLight7,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        snapshot.dataUser!.email ?? '',
                                        style: GoogleFonts.poppins().copyWith(
                                          fontWeight: FontWeight.w300,
                                          color: (darkLight != true)
                                              ? textDark
                                              : textLight8,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    edit(
                                      snapshot.dataUser!,
                                      widget.token,
                                    ),
                                  );
                                },
                                child: Container(
                                  color: (darkLight != true)
                                      ? navigasiDark
                                      : textDark,
                                  child: Image.asset(
                                    'assets/edit.png',
                                    scale: 2.5,
                                    color: (darkLight != true)
                                        ? textDark
                                        : buttonLight1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              Positioned(
                right: 15,
                left: 15,
                top: 75,
                child: GestureDetector(
                  onTap: () async {
                    context.read<AiCubit>().getAi(widget.token, '');
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('selectedRandomId', '');
                    setState(() {
                      time = DateTime.now().millisecondsSinceEpoch.toString();
                      selectedRandomId = null;
                      showChat = false;
                      showContoh = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                        left: 10, right: 5, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: (darkLight != true) ? navigasiDark : textDark,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: (darkLight != true) ? textDark : shadow,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pertanyaan Baru',
                          style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: (darkLight != true) ? textDark : textLight3,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.add,
                          color: (darkLight != true) ? textDark : textLight3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 15,
                right: 15,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 155,
                  // height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: BlocBuilder<HistoryCubit, HistoryState>(
                      builder: (context, headshot) {
                        if (headshot is HistoryLoaded) {
                          if (headshot.history != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: headshot.history!
                                  .map(
                                    (e) => list_history(
                                      e,
                                      widget.token,
                                      isShowContoh: (value) {
                                        setState(() {
                                          showContoh = value;
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                            );
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    Divider(
                      thickness: 1.5,
                      color: (darkLight != true) ? textDark : divider,
                      height: 1,
                    ),
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                backgroundColor:
                                    (darkLight != true) ? dasarDark : textDark,
                                content: Text(
                                  'Yakin akan keluar?',
                                  style: GoogleFonts.poppins().copyWith(
                                    fontSize: 12,
                                    color: (darkLight != true)
                                        ? textDark
                                        : textLight5,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      'Tidak',
                                      style: GoogleFonts.poppins().copyWith(
                                        fontSize: 12,
                                        color: (darkLight != true)
                                            ? textDark
                                            : warnaUtama,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Ya',
                                      style: GoogleFonts.poppins().copyWith(
                                        fontSize: 12,
                                        color: (darkLight != true)
                                            ? textDark
                                            : warnaUtama,
                                      ),
                                    ),
                                    onPressed: () {
                                      _prefServices.removeCache('emailGoogle').whenComplete(() {
                                        logout(widget.token);
                                        FirebaseAuth.instance.signOut();
                                      }).catchError((onError){
                                        print('SignOut Error: $onError');
                                      });
                                      _prefServices.removeHistory('selectedRandomId').whenComplete(() {
                                        print('keluar');
                                      });
                                    },
                                  ),
                                ]);
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        color: (darkLight != true) ? navigasiDark : textDark,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 18,
                              color:
                                  (darkLight != true) ? textDark : textLight8,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Sign Out',
                              style: GoogleFonts.poppins().copyWith(
                                fontWeight: FontWeight.w300,
                                color:
                                    (darkLight != true) ? textDark : textLight8,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }
}
