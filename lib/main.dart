import 'package:api_practice/complex_api.dart';
import 'package:api_practice/home_screen.dart';
import 'package:api_practice/sign_up.dart';
import 'package:api_practice/upload_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      useMaterial3: false,
        primarySwatch: Colors.blue
      ),
      home: const UploadImage(),
    );
  }
}
