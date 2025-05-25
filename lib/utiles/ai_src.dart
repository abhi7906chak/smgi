// utiles/ai_src.dart
import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiSrc extends StatefulWidget {
  const AiSrc({super.key});

  @override
  State<AiSrc> createState() => _AiSrcState();
}

class _AiSrcState extends State<AiSrc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Chat")),
      body: LlmChatView(
        provider: GeminiProvider(
          model: GenerativeModel(
            model: 'gemini-1.5-flash',
            apiKey: 'AIzaSyBCMkDFk_VNNpKAXdzOPQcA5mRGuQ2jH2I',
          ),
        ),
      ),
    );
  }
}
