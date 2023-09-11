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
      color: (darkLight != true) ? chatUserDark : textDark,
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
                color: (darkLight != true) ? textDark : textLight3,
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
      color: (darkLight != true) ? dasarDark : chatUserLight,
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
                color: (darkLight != true) ? textDark : textLight3,
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
  // final Ai aiModel;
  final DataUser userData;
  final String token;

  VoiceUserCard(this.userData, this.token); // VoiceUserCard(this.aiModel, this.userData, this.token);

  @override
  State<VoiceUserCard> createState() => _VoiceUserCardState();
}

class _VoiceUserCardState extends State<VoiceUserCard> {
  bool isPlaying = false;
  String audioFilePath = '/data/user/0/com.parentoday.ai_apps/cache/audio';
  PlayerController controllerWave = PlayerController();

  @override
  void dispose() {
    super.dispose();
    controllerWave.dispose();
  }

  Future playAudio() async {
    await controllerWave.preparePlayer(
      path: audioFilePath,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 10,
    );
    final waveformData = await controllerWave.extractWaveformData(
      path: audioFilePath,
      noOfSamples: 100,
    );
    controllerWave.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    controllerWave.onCompletion.listen((_) {
      setState(() {
        isPlaying = false;
      });
    });
    await controllerWave.startPlayer(finishMode: FinishMode.stop);
    controllerWave.updateFrequency = UpdateFrequency.low;
    controllerWave.onCurrentDurationChanged.listen((newDuration) {});
    controllerWave.onCurrentExtractedWaveformData.listen((data) {});
    controllerWave.onExtractionProgress.listen((progress) {});
  }

  Future pauseAudio() async {
    await controllerWave.stopPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      color: (darkLight != true) ? chatUserDark : textDark,
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
            child: AudioFileWaveforms(
              animationCurve: Curves.easeIn,
              size: Size(MediaQuery.of(context).size.width, 500.0),
              playerController: controllerWave,
              playerWaveStyle: PlayerWaveStyle(
                fixedWaveColor: (darkLight != true) ? textDark : frekuensiLight,
                liveWaveColor: (darkLight != true) ? textDark : frekuensiLight,
                seekLineColor: 'FF6969'.toColor(),
                waveCap: StrokeCap.round,
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
                  playAudio();
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: buttonDark,
              ),
              child: (isPlaying == true)
                  ? Icon(
                      Icons.pause,
                      color: textDark,
                    )
                  : Icon(
                      Icons.play_arrow,
                      color: textDark,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
