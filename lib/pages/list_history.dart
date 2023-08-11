part of 'pages.dart';

class list_history extends StatefulWidget {
  late final HistoryModel? history;
  late final token;

  list_history(this.history, this.token);

  @override
  State<list_history> createState() => _list_historyState();
}

class _list_historyState extends State<list_history> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedRandomId = widget.history!.random_id;
            });
            context
                .read<AiCubit>()
                .getAi(widget.token, widget.history!.random_id ?? '');

            Navigator.of(context).pop();
          },
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.chat_outlined, size: 20),
                    const SizedBox(width: 7),
                    Text(
                      widget.history!.title ?? '',
                      style: GoogleFonts.poppins().copyWith(
                        fontWeight: FontWeight.bold,
                        color: '555555'.toColor(),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.chevron_right)
              ],
            ),
          ),
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
