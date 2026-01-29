import 'package:flutter_character_app/src/models/character_stat_model.dart';

class CharacterStatMock {
  static List<CharacterStat> getMockStats(int characterId) {
    final stats = <CharacterStat>[];
    
    switch (characterId % 5) {
      case 0:
        stats.addAll([
          CharacterStat(
            baseStat: 220,
            stat: StatInfo(name: 'popularity', url: ''),
          ),
          CharacterStat(
            baseStat: 180,
            stat: StatInfo(name: 'relevance', url: ''),
          ),
          CharacterStat(
            baseStat: 150,
            stat: StatInfo(name: 'episode_count', url: ''),
          ),
        ]);
        break;
      case 1:
        stats.addAll([
          CharacterStat(
            baseStat: 195,
            stat: StatInfo(name: 'popularity', url: ''),
          ),
          CharacterStat(
            baseStat: 165,
            stat: StatInfo(name: 'relevance', url: ''),
          ),
          CharacterStat(
            baseStat: 120,
            stat: StatInfo(name: 'episode_count', url: ''),
          ),
        ]);
        break;
      case 2:
        stats.addAll([
          CharacterStat(
            baseStat: 175,
            stat: StatInfo(name: 'popularity', url: ''),
          ),
          CharacterStat(
            baseStat: 145,
            stat: StatInfo(name: 'relevance', url: ''),
          ),
          CharacterStat(
            baseStat: 95,
            stat: StatInfo(name: 'episode_count', url: ''),
          ),
        ]);
        break;
      case 3:
        stats.addAll([
          CharacterStat(
            baseStat: 155,
            stat: StatInfo(name: 'popularity', url: ''),
          ),
          CharacterStat(
            baseStat: 125,
            stat: StatInfo(name: 'relevance', url: ''),
          ),
          CharacterStat(
            baseStat: 70,
            stat: StatInfo(name: 'episode_count', url: ''),
          ),
        ]);
        break;
      default:
        stats.addAll([
          CharacterStat(
            baseStat: 135,
            stat: StatInfo(name: 'popularity', url: ''),
          ),
          CharacterStat(
            baseStat: 105,
            stat: StatInfo(name: 'relevance', url: ''),
          ),
          CharacterStat(
            baseStat: 45,
            stat: StatInfo(name: 'episode_count', url: ''),
          ),
        ]);
    }
    
    return stats;
  }
}

