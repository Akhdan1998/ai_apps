part of 'pages.dart';

class list_history extends StatefulWidget {
  final HistoryModel? history;
  final token;
  final ValueChanged<bool>? isShowContoh;

  const list_history(this.history, this.token, {super.key, this.isShowContoh});

  @override
  State<list_history> createState() => _list_historyState();
}

class _list_historyState extends State<list_history> {
  void deleted() async {
    Uri url_ = Uri.parse(
        'https://dashboard.parentoday.com/api/chat/ai/history/delete');
    var res = await http.post(
      url_,
      body: {
        'id': widget.history!.id.toString(),
      },
      headers: {
        "Accept": "application/json",
        "Authorization": 'Bearer ${widget.token}',
      },
    );
    Map<String, dynamic> body = jsonDecode(res.body);

    print('WKWKWK ${res.body}');

    if (res.statusCode == 200) {
      bool data = body["data"];

      context.read<HistoryCubit>().getHistory(widget.token);

      Navigator.of(context).pop();

      Fluttertoast.showToast(
          msg: "Berhasil menghapus pertanyaan!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: 'FF6969'.toColor(),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      throw "Error ${res.statusCode} => ${body["meta"]["message"]}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedRandomId = widget.history!.random_id;
                  widget.isShowContoh!(true);
                });
                context
                    .read<AiCubit>()
                    .getAi(widget.token, widget.history!.random_id ?? '');
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width - 125,
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.chat_outlined, size: 20),
                    const SizedBox(width: 7),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 162,
                      child: Text(
                        widget.history!.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins().copyWith(
                          fontWeight: FontWeight.bold,
                          color: '555555'.toColor(),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        content: Text(
                          'Yakin mau menghapus history?',
                          style:
                          GoogleFonts.poppins().copyWith(fontSize: 12),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Tidak', style: GoogleFonts.poppins().copyWith(fontSize: 12, color: 'FF8182'.toColor(),),),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle:
                              Theme.of(context).textTheme.labelLarge,
                            ),
                            child: Text('Ya', style: GoogleFonts.poppins().copyWith(fontSize: 12, color: 'FF8182'.toColor(),),),
                            onPressed: () {
                              deleted();
                            },
                          ),
                        ]);
                  },
                );
              },
              child: Container(
                color: Colors.white,
                child: Icon(
                  Icons.delete,
                  color: '555555'.toColor(),
                  size: 15,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: '555555'.toColor(),
            ),
          ],
        ),
        Divider(
          thickness: 1.5,
          color: 'ECECEC'.toColor(),
          height: 5,
        ),
      ],
    );
  }
}
