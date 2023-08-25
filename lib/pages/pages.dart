import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ai_apps/models/auth.dart';
import 'package:ai_apps/models/logreg.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simple_waveform_progressbar/simple_waveform_progressbar.dart';
import 'package:universal_io/io.dart';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:supercharged/supercharged.dart';
import '../cubits/ai_cubit.dart';
import '../cubits/ai_state.dart';
import '../cubits/datauser_cubit.dart';
import '../cubits/datauser_state.dart';
import '../cubits/history_cubit.dart';
import '../cubits/history_state.dart';
import '../models/api_return_foto.dart';
import '../models/data_user.dart';
import '../models/edit_profil.dart';
import '../models/history.dart';
import '../models/models.dart';
import '../services/LogReg_services.dart';
import '../widgets/widgets.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

part 'edit.dart';

part 'list_history.dart';

part 'home_page.dart';

part 'login_page.dart';

String? selectedRandomId;
bool showChat = true;
bool showContoh = false;

