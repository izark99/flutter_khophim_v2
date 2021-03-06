import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khophim/helpers/binding.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/pages/home_page.dart';
import 'package:khophim/pages/movie_page.dart';

import 'helpers/theme_customized.dart';
import 'pages/auth_page.dart';
import 'pages/root_page.dart';
import 'pages/splash_page.dart';
import 'services/admob_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: AdMobService().getAdMobAppId());
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: STR_APP_NAME,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: "/Splash",
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.downToUp,
      smartManagement: SmartManagement.onlyBuilder,
      getPages: [
        GetPage(
          name: "/Splash",
          page: () => SplashPage(),
        ),
        GetPage(
          name: "/Root",
          page: () => RootPage(),
        ),
        GetPage(
          name: "/Auth",
          page: () => AuthPage(),
        ),
        GetPage(
          name: "/Home",
          page: () => HomePage(),
        ),
        GetPage(
          name: "/Movie",
          page: () => MoviePage(),
        ),
      ],
    );
  }
}
