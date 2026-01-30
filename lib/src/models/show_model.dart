class ShowModel {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final List<Rating> ratings;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String type;
  final String totalSeasons;
  final String response;

  ShowModel({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.type,
    required this.totalSeasons,
    required this.response,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
      title: json['Title'],
      year: json['Year'],
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      director: json['Director'],
      writer: json['Writer'],
      actors: json['Actors'],
      plot: json['Plot'],
      language: json['Language'],
      country: json['Country'],
      awards: json['Awards'],
      poster: json['Poster'],
      ratings: json['Ratings']
          ?.map<Rating>((rating) => Rating.fromJson(rating))
          .toList(),
      metascore: json['Metascore'],
      imdbRating: json['imdbRating'],
      imdbVotes: json['imdbVotes'],
      imdbID: json['imdbID'],
      type: json['Type'],
      totalSeasons: json['totalSeasons'],
      response: json['Response'],
    );
  }
}

class Rating {
  final String source;
  final String value;

  Rating({required this.source, required this.value});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(source: json['Source'], value: json['Value']);
  }
}

var response = {
  "Title": "Futurama",
  "Year": "1999–",
  "Rated": "TV-14",
  "Released": "28 Mar 1999",
  "Runtime": "22 min",
  "Genre": "Animation, Adventure, Comedy",
  "Director": "N/A",
  "Writer": "David X. Cohen, Matt Groening",
  "Actors": "Billy West, John DiMaggio, Katey Sagal",
  "Plot":
      "Philip J. Fry, a pizza delivery boy, is accidentally frozen in 1999 and thawed out on New Year's Eve 2999.",
  "Language": "English",
  "Country": "United States",
  "Awards": "Won 6 Primetime Emmys. 30 wins & 58 nominations total",
  "Poster":
      "https://m.media-amazon.com/images/M/MV5BNjYxNDgxM2MtYzNmNi00ODYwLWI0ZmEtZDM3M2QwZGQ3MWI3XkEyXkFqcGc@._V1_SX300.jpg",
  "Ratings": [
    {"Source": "Internet Movie Database", "Value": "8.5/10"},
  ],
  "Metascore": "N/A",
  "imdbRating": "8.5",
  "imdbVotes": "274,210",
  "imdbID": "tt0149460",
  "Type": "series",
  "totalSeasons": "13",
  "Response": "True",
};
