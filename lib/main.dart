import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:the_news/screen/home_screen.dart';
import 'package:the_news/utlits/app_constant.dart';

import 'controller/home_controller.dart';

void main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: AppColors.lightPurple,
              primarySwatch: materialPurpleColor,
              fontFamily: "OpenSans",
            ),
            home: child,
          );
        },
        child: const HomeScreen()
    );
  }

  MaterialColor materialPurpleColor = MaterialColor(
    AppColors.lightPurple.value,
    <int, Color>{
      50: AppColors.lightPurple,
      100: AppColors.lightPurple,
      200: AppColors.lightPurple,
      300: AppColors.lightPurple,
      400: AppColors.lightPurple,
      500: AppColors.lightPurple,
      600: AppColors.lightPurple,
      700: AppColors.lightPurple,
      800: AppColors.lightPurple,
      900: AppColors.lightPurple,
    },
  );
}
