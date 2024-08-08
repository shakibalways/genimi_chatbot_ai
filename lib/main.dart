
import 'package:flutter/material.dart';
import 'package:gemini_ai_app/screen/genimi_ai.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:false,
      home: GeminiChatBot(),
    );
  }
}
