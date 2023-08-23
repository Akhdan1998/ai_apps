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

//

class VoiceUserCard extends StatefulWidget {
  late final DataUser userData;
  late final String token;

  VoiceUserCard(this.userData, this.token);

  @override
  State<VoiceUserCard> createState() => _VoiceUserCardState();
}

class _VoiceUserCardState extends State<VoiceUserCard> {
  bool isPlaying = false;
  late AudioPlayer audioPlayer;
  String audioFilePath = '/data/user/0/com.parentoday.ai_apps/cache/audio';
  RecorderController controller = RecorderController();

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future playAudio() async {
    await audioPlayer.play(DeviceFileSource(audioFilePath));
  }

  Future pauseAudio() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
          SizedBox(
            width: MediaQuery.of(context).size.width - 104,
            height: 25,
            child: AudioWaveforms(
              backgroundColor: Colors.white,
              size: Size(MediaQuery.of(context).size.width, 200.0),
              recorderController: controller,
              enableGesture: true,
              waveStyle: WaveStyle(
                spacing: 8,
                backgroundColor: Colors.green,
                waveColor: 'FF6969'.toColor(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              setState(() {
                if (isPlaying) {
                  isPlaying = false;
                  pauseAudio();
                } else {
                  isPlaying = true;
                  playAudio().then((value) {
                    setState(() {
                      isPlaying = false;
                    });
                  });
                }
              });
            },
            child: (isPlaying == true)
                ? Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: 'A5A5A5'.toColor(),
                    ),
                    child: const Icon(
                      Icons.pause,
                      color: Colors.white,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: 'A5A5A5'.toColor(),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
