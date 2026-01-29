import 'package:flutter_character_app/src/models/character_model.dart';
import 'package:flutter_character_app/src/utils/dio_client.dart';

class HomeService {
  static Future<Map<String, dynamic>> getCharacters({
    int page = 1,
    int size = 100,
  }) async {
    try {
      var queryParameters = {'orderBy': 'id', 'page': page, 'size': size};
      final response = await DioClient.instance.httpGet(
        '/characters',
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        var characterResponse = CharactersResponse.fromJson(response.data);
        return {
          'items': characterResponse.items,
          'nextPage': characterResponse.pages == page ? 0 : page + 1,
        };
      } else {
        return {
          'items': [],
          'nextPage': 0,
        };
      }
    } catch (e) {
      return {
        'items': [],
        'nextPage': 0,
        'error': e.toString(),
      };
    }
  }
}
