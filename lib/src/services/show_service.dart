import 'package:flutter_character_app/src/models/show_model.dart';
import 'package:flutter_character_app/src/utils/constants.dart';
import 'package:flutter_character_app/src/utils/dio_client.dart';

class ShowService {
  static Future<Map<String, dynamic>> getShow(String seriesName) async {
    try {
      final response = await DioClient.getInstance(apiUrl).httpGet(
        '',
        queryParameters: {'t': seriesName, 'apikey': apiKey},
      );
      return {'show': ShowModel.fromJson(response.data)};
    } catch (e) {
      return {'error': e.toString(), 'show': null};
    }
  }
}