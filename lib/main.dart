import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khophim/helpers/binding.dart';
import 'package:khophim/helpers/constant.dart';
import 'package:khophim/pages/home_page.dart';
import 'package:khophim/pages/movie_page.dart';

import 'helpers/theme_customized.dart';
import 'pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      getPages: [
        GetPage(
          name: "/Splash",
          page: () => SplashPage(),
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
