// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
//
// class AudioConverter {
//   final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
//
//   Future<void> convertToMP3(String inputPath, String outputPath) async {
//     List<String> command = [
//       '-i',
//       inputPath,
//       '-c:a',
//       'libmp3lame',
//       outputPath,
//     ];
//
//     int result = await _flutterFFmpeg.execute(command.toString());
//
//     if (result == 0) {
//       print('Konversi ke MP3 berhasil');
//     } else {
//       print('Konversi ke MP3 gagal');
//     }
//   }
// }
//
// AudioConverter audioConverter = AudioConverter();