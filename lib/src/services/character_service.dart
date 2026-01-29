import 'package:flutter_character_app/src/models/character_model.dart';
import 'package:flutter_character_app/src/models/episode_model.dart';
import 'package:flutter_character_app/src/utils/dio_client.dart';

class CharacterService {
  static Future<Map<String, dynamic>> getCharacter(int id) async {
    try {
      final response = await DioClient.instance.httpGet('/characters/$id');
      return {'character': Character.fromJson(response.data)};
    } catch (e) {
      return {'error': e.toString(), 'character': null};
    }
  }

  // TODO: Update this method to get the episodes of a character
  static Future<Map<String, dynamic>> getCharacterEpisodes(int id) async {
    try {
      var queryParameters = {'page': 1, 'size': 20};
      final response = await DioClient.instance.httpGet(
        '/episodes',
        queryParameters: queryParameters,
      );
      var episodeResponse = EpisodesResponse.fromJson(response.data);
      return {'episodes': episodeResponse.items};
    } catch (e) {
      return {'error': e.toString(), 'episodes': []};
    }
  }
}
