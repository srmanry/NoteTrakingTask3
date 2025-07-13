import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notetaking/theme/light_theme.dart';

import 'feature/home/view/home_screen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note Taking ',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(

          centerTitle: true,
          backgroundColor: lightTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: HomeScreenView(),
    );
  }
}
