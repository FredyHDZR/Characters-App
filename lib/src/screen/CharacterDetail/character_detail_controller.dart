import 'package:flutter_character_app/src/models/character_model.dart';
import 'package:flutter_character_app/src/models/episode_model.dart';
import 'package:flutter_character_app/src/services/character_service.dart';
import 'package:mobx/mobx.dart';

part 'character_detail_controller.g.dart';

class CharacterDetailController = CharacterDetailControllerBase with _$CharacterDetailController;

abstract class CharacterDetailControllerBase with Store {
  final Character character;

  @observable
  bool isLoading = false;

  @observable
  List<Episode> episodes = [];

  CharacterDetailControllerBase({required this.character});

  @action
  Future<void> getCharacterEpisodes() async {
    isLoading = true;
    final response = await CharacterService.getCharacterEpisodes(character.id);
    episodes = response['episodes'];
    isLoading = false;
  }
}