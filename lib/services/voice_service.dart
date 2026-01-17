import 'backend_service.dart';

class VoiceService {
  static Future<Map<String, dynamic>> askAssistant(
      String text, String langCode) async {
    return await BackendService.processVoice(
      text: text,
      languageCode: langCode,
    );
  }
}
