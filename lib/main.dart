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
  Provider.debugCheckInvalidValueType = null;

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
    return Provider(
      create: (_) => ThemeProvider(),
      builder: (context, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: Provider.of<ThemeProvider>(context,listen: true).isLight == true
          ? ThemeMode.light
          : ThemeMode.dark,
          theme: ThemeData(
            primaryColor: Colors.teal,
            primarySwatch: materialPurpleColor,
            fontFamily: "OpenSans",
          ),
          darkTheme: ThemeData(
            primaryColor: Colors.blueGrey,
            primarySwatch: materialPurpleColor,
            fontFamily: "OpenSans",
          ),
          home: const HomeScreen(),
        );
      },
    );
  }

  MaterialColor materialPurpleColor = MaterialColor(
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
}
