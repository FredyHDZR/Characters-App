class CharacterStat {
  final int baseStat;
  final StatInfo stat;

  CharacterStat({
    required this.baseStat,
    required this.stat,
  });

  factory CharacterStat.fromJson(Map<String, dynamic> json) {
    return CharacterStat(
      baseStat: json['baseStat'],
      stat: StatInfo.fromJson(json['stat']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'baseStat': baseStat,
      'stat': stat.toJson(),
    };
  }
}

class StatInfo {
  final String name;
  final String url;

  StatInfo({
    required this.name,
    required this.url,
  });

  factory StatInfo.fromJson(Map<String, dynamic> json) {
    return StatInfo(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

extension StatInfoExtension on StatInfo {
  String get displayName {
    switch (name) {
      case 'popularity':
        return 'Popularidad';
      case 'relevance':
        return 'Relevancia';
      case 'episode_count':
        return 'Episodios';
      default:
        return name.toUpperCase();
    }
  }
}

