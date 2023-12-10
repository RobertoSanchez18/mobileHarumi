import 'package:flutter/material.dart';
import 'package:t06_apaflex_am/presentation/screem/basic_intro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BasicIntro(),
    );
  }
}
