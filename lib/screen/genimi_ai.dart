import 'package:flutter/material.dart';
import 'package:gemini_ai_app/model/model.dart';

import 'package:intl/intl.dart'; // Added import for DateFormat, assuming you are using this package.

class GeminiChatBot extends StatefulWidget {
  const GeminiChatBot({super.key});

  @override
  State<GeminiChatBot> createState() => _GeminiChatBotState();
}

class _GeminiChatBotState extends State<GeminiChatBot> {
  final TextEditingController _promptController = TextEditingController();
  static const apiKey = "AIzaSyDRoVCdj_65CDXCaeVXBIz7aM-Lara2NM8";
  // final GenerativeModel _model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);
  final GenerativeModel model =
      GenerativeModel(model: "gemini-pro", apiKey: apiKey);
  final List<ModelMessage> _messages = [];

  Future<void> sendMessage() async {
    final messageText = _promptController.text.trim();
    if (messageText.isEmpty) return;

    setState(() {
      _promptController.clear();
      _messages.add(
        ModelMessage(
          isPrompt: true,
          message: messageText,
          time: DateTime.now(),
        ),
      );
    });

    try {
      final content = [Content.text(messageText)];
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(
          ModelMessage(
            isPrompt: false,
            message: response.text ?? "No response",
            time: DateTime.now(),
          ),
        );
      });
    } catch (e) {
      setState(() {
        _messages.add(
          ModelMessage(
            isPrompt: false,
            message: "Error: Unable to get a response",
            time: DateTime.now(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.blue[100],
        title: const Text("AI ChatBot"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  isPrompt: message.isPrompt,
                  message: message.message,
                  date: DateFormat('hh:mm a').format(message.time),
                );
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _promptController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Enter a prompt here",
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: sendMessage,
            child: const CircleAvatar(
              radius: 29,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isPrompt;
  final String message;
  final String date;

  const ChatBubble({
    super.key,
    required this.isPrompt,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isPrompt ? 80 : 15,
        right: isPrompt ? 15 : 80,
      ),
      decoration: BoxDecoration(
        color: isPrompt ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isPrompt ? const Radius.circular(20) : Radius.zero,
          bottomRight: isPrompt ? Radius.zero : const Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
              color: isPrompt ? Colors.white : Colors.black,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              date,
              style: TextStyle(
                fontSize: 14,
                color: isPrompt ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
