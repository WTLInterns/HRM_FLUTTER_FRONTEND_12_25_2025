import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrm_project/res/app_colour.dart';
import 'package:hrm_project/screens/splash/splash.dart';

void main() {
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColours.onSecondary, 
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  splashScreen(),
    );
  }
}

