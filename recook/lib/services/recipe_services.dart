import 'package:dio/dio.dart';

class RecipeRecommendationService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> getRecommendations({required String prompt}) async {
    try {
      _dio.options = BaseOptions(
        baseUrl: 'https://api.openai.com/v1/',
        headers: {
          'Authorization': 'Bearer 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', // Gantilah dengan API key yang sesuai
        },
      );

      final response = await _dio.post(
        'completions',
        data: {
          "model": "text-davinci-003",
          "prompt": "Kamu adalah seorang ahli dalam bidang kuliner dan resep masakan, kamu akan ditanyai hal seputar kuliner, resep makanan, dan tips mengolah bahan makanan. $prompt . Coba kamu sebutkan nama masakannya kemudian jelaskan bahan-bahan, langkah-langkah, waktu yang diperlukan, hingga tingkat kesulitan dari masakan tersebut. Namun, jika kamu ditanyai tentang tips mengolah makanan, kamu dapat mengabaikan aturan sebelumnya dan menjelaskan tips yang ditanyakan", // Menambahkan ide bahwa AI adalah ahli kuliner
          "temperature": 0.4,
          "max_tokens": 900,
          "top_p": 1,
          "frequency_penalty": 0,
          "presence_penalty": 0,
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.data}');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Failed to make API request: ${response.statusCode}');
      }
    } catch (error) {
      // An error occurred
      print('Error: $error');
    }
    return null;
  }
}