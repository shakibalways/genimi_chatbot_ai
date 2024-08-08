import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemini_ai_app/screen/genimi_ai.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: GeminiChatBot(),
    );
  }
}
