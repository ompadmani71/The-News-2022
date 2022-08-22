import 'package:flutter/material.dart';

class AppImage{
  static String baseImagePath = "assets/images";

  static String business = "$baseImagePath/img_business.png";
  static String entertainment = "$baseImagePath/img_entertainment.png";
  static String health = "$baseImagePath/img_health.png";
  static String science = "$baseImagePath/img_science.png";
  static String sports = "$baseImagePath/img_sport.png";
  static String technology = "$baseImagePath/img_technology.png";
}

class AppColors {
  
  static Color bgColor = const Color(0xffF5F5F5);

  static Color font = const Color(0xff333333);

  static Color lightPurple = const Color(0xff937DA8);
  static Color greyContainer = const Color(0xffF0F0F0);
  static Color textFiledBorder = const Color(0xffC9C9C9);
  static Color errorText = const Color(0xffE00505);
  static Color unselectedLabelColor = const Color(0xff666666);
  static Color divider = const Color(0xffDCDCDC);
  static Color border = const Color(0xffD7D7D7);
  static Color purpleDivider = const Color(0xffDCD5F2);
  static Color shadow = const Color(0xffBDBDBD);
  static Color red = const Color(0xffD71149);
  static Color lightFont = const Color(0xffBBBBBB);
  static Color lightContainer = const Color(0xffEEEEEE);
}

class TextStyles {
  static TextStyle labelStyle = TextStyle(
    fontSize: 10,fontWeight: FontWeight.w400,color: AppColors.lightPurple
  );static TextStyle titleStyle = const TextStyle(
    fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black
  );
}

