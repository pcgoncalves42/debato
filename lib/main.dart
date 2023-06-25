import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'bindings/debate_binding.dart';
import 'bindings/home_binding.dart';
import 'bindings/postar_binding.dart';
import 'pages/debate/debate_page.dart';
import 'pages/home/home_page.dart';
import 'pages/post/post_page.dart';
import 'services/firebase_service.dart';
import 'uteis/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: backgroundColor,
    statusBarIconBrightness: Brightness.light
  ));

  // inicia o Firebase
  await Firebase.initializeApp();

  await runZonedGuarded(() async {

    // iniciar serviços
    await Get.putAsync(() => FirebaseService().init());

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(const MyApp());

  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Debato',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRight,
      locale: const Locale('pt', 'BR'),
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          binding: HomeBinding(),
          page: () => const HomePage()
        ),
        GetPage(
          name: '/postar',
          binding: PostarBinding(),
          page: () => const PostarPage()
        ),
        GetPage(
          name: '/debate',
          binding: DebateBinding(),
          page: () => const DebatePage()
        ),
      ]
    );
  }
}
