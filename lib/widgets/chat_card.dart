part of 'widgets.dart';

class ChatUserCard extends StatefulWidget {
  final Ai aiModel;

  final DataUser userData;
  final String token;

  ChatUserCard(this.aiModel, this.userData, this.token);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  widget.userData.profile_photo_url ?? '',
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            // constraints: const BoxConstraints(maxWidth: 800),
            width: MediaQuery.of(context).size.width - 66,
            child: Text(
              widget.aiModel.content ?? '',
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w300,
                color: '484848'.toColor(),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatRobotCard extends StatelessWidget {
  final Ai aiModel;
  final String token;

  const ChatRobotCard(this.aiModel, this.token, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      color: 'FFF4F4'.toColor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/parentoday.png', scale: 2),
          const SizedBox(width: 10),
          Container(
            // constraints: const BoxConstraints(maxWidth: 800),
            width: MediaQuery.of(context).size.width - 65,
            child: Text(
              aiModel.content ?? '',
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w300,
                color: '484848'.toColor(),
                height: 1.7,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}