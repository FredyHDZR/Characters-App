class CharactersResponse {
  final List<Character> items;
  final int total;
  final int page;
  final int size;
  final int pages;

  CharactersResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.size,
    required this.pages,
  });

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    return CharactersResponse(
      items: List<Character>.from(json['items'].map((x) => Character.fromJson(x))),
      total: json['total'],
      page: json['page'],
      size: json['size'],
      pages: json['pages'],
    );
  }
}

class Character {
  final int id;
  final String name;
  final String gender;
  final String species;
  final String createdAt;
  final String? image;

  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.gender,
    required this.species,
    required this.createdAt,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      gender: json['gender'],
      species: json['species'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'gender': gender,
      'species': species,
      'createdAt': createdAt,
    };
  }
}