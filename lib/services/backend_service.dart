import 'dart:convert';
import 'package:http/http.dart' as http;

class BackendService {
  // ⚠️ Change IP if running on phone/emulator
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<Map<String, dynamic>> processVoice({
    required String text,
    required String languageCode,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/process-voice"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "text_input": text,
        "language_code": languageCode,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Voice backend error");
    }
  }
}
