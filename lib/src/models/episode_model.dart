class EpisodesResponse {
  final List<Episode> items;
  final int total;
  final int page;
  final int size;
  final int pages;

  EpisodesResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.size,
    required this.pages,
  });

  factory EpisodesResponse.fromJson(Map<String, dynamic> json) {
      return EpisodesResponse(
        items: List<Episode>.from(json['items'].map((x) => Episode.fromJson(x))),
        total: json['total'],
        page: json['page'],
        size: json['size'],
        pages: json['pages'],
      );
    } 
}

class Episode {
  final int id;
  final String name;
  final String airDate;
  final int duration;
  final String createdAt;
  final int season;
  final String broadcastCode;
  final int number;
  final String productionCode;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.duration,
    required this.createdAt,
    required this.season,
    required this.broadcastCode,
    required this.number,
    required this.productionCode,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      airDate: json['airDate'],
      duration: json['duration'],
      createdAt: json['createdAt'],
      season: json['season']['id'],
      broadcastCode: json['broadcastCode'],
      number: json['number'],
      productionCode: json['productionCode'],
    );
  }
}
