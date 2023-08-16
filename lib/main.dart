import 'package:ai_apps/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:supercharged/supercharged.dart';
import 'cubits/ai_cubit.dart';
import 'cubits/datauser_cubit.dart';
import 'cubits/history_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AiCubit()),
        BlocProvider(create: (_) => DataUserCubit()),
        BlocProvider(create: (_) => HistoryCubit()),
      ],
      child: GetMaterialApp(
        color: 'FF6969'.toColor(),
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}