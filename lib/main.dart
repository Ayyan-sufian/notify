import 'package:flutter/material.dart';
import 'package:notify_project/splash-screen.dart';

import 'audio-file.dart';
import 'detail-audio.dart';
import 'my-home-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(color: Colors.transparent),
      ),
      home: splashScreen(),
    );
  }
}
