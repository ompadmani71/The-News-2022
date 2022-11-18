import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_news/controller/home_controller.dart';
import 'package:the_news/controller/news_controller.dart';
import 'package:the_news/provider/theam_provider.dart';
import 'package:the_news/screen/home_screen.dart';
import 'package:the_news/utlits/app_constant.dart';
import 'package:get/get.dart';

void main() async {
  // Provider.debugCheckInvalidValueType = null;


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
  HomeController homeController = Get.put(HomeController());
  NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=> ThemeProvider())
        ],
    builder: (context,_){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: Provider.of<ThemeProvider>(context).isLight
                ? ThemeMode.light
                : ThemeMode.dark,
            theme: ThemeData(
              primaryColor: Colors.teal,
              primarySwatch: materialLightTheme,
              fontFamily: "OpenSans",
            ),
            darkTheme: ThemeData(
              primaryColor: Colors.blueGrey,
              primarySwatch: materialDarkTheme ,
              fontFamily: "OpenSans",
            ),
            home: const HomeScreen(),
          );
    },
    );
  }

  MaterialColor materialLightTheme = MaterialColor(
    AppColors.lightPurple.value,
    const <int, Color>{
      50: Colors.teal,
      100: Colors.teal,
      200: Colors.teal,
      300: Colors.teal,
      400: Colors.teal,
      500: Colors.teal,
      600: Colors.teal,
      700: Colors.teal,
      800: Colors.teal,
      900: Colors.teal,
    },
  );

  MaterialColor materialDarkTheme = const MaterialColor(
    0xffef5350,
    <int, Color>{
      50: Colors.red,
      100: Colors.red,
      200: Colors.red,
      300: Colors.red,
      400: Colors.red,
      500: Colors.red,
      600: Colors.red,
      700: Colors.red,
      800: Colors.red,
      900: Colors.red,
    },
  );
}
