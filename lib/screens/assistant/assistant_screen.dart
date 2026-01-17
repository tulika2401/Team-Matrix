import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../services/voice_service.dart';
import '../../widgets/chat_bubble.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  late stt.SpeechToText _speech;

  List<Map<String, dynamic>> messages = [];
  bool isListening = false;
  bool isLoading = false;

  String languageCode = "hi"; // default Hindi

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  // 🎙 Start voice input
  Future<void> startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => isListening = true);
      _speech.listen(
        onResult: (result) {
          _controller.text = result.recognizedWords;
        },
      );
    }
  }

  // ⏹ Stop listening & send to backend
  Future<void> stopListening() async {
    await _speech.stop();
    setState(() => isListening = false);
    askAssistant();
  }

  // 🤖 Ask backend + play voice reply
  Future<void> askAssistant() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({"text": text, "isUser": true});
      _controller.clear();
      isLoading = true;
    });

    try {
      final response =
          await VoiceService.askAssistant(text, languageCode);

      final audioUrl =
          "http://127.0.0.1:8000${response['audio_url']}";

      await _audioPlayer.play(UrlSource(audioUrl));

      setState(() {
        messages.add({
          "text": response['regional_response'],
          "isUser": false,
        });
      });
    } catch (e) {
      setState(() {
        messages.add({
          "text": "Sorry, I could not understand. Please try again.",
          "isUser": false,
        });
      });
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Assistant")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ChatBubble(
                  text: msg["text"],
                  isUser: msg["isUser"],
                );
              },
            ),
          ),

          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: languageCode,
                  items: const [
                    DropdownMenuItem(value: "hi", child: Text("Hindi")),
                    DropdownMenuItem(value: "ta", child: Text("Tamil")),
                    DropdownMenuItem(value: "te", child: Text("Telugu")),
                    DropdownMenuItem(value: "gu", child: Text("Gujarati")),
                    DropdownMenuItem(value: "pa", child: Text("Punjabi")),
                  ],
                  onChanged: (val) =>
                      setState(() => languageCode = val!),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText:
                              "Speak or type: hello, loan, insurance...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        isListening ? Icons.mic_off : Icons.mic,
                        color: isListening ? Colors.red : null,
                      ),
                      onPressed:
                          isListening ? stopListening : startListening,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
