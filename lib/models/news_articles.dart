class NewsArticles {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final Source? source;

  NewsArticles({required this.title, required this.description, required this.url, required this.urlToImage, required this.publishedAt, required this.content, required this.source});

  factory NewsArticles.fromJson(Map<String, dynamic> json) {
    return NewsArticles(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
      source: json['source'] != null ? Source.fromJson(json['source']) : null 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'source': source?.toJson(),
    };
  }
}

class Source {
  final String? id;
  final String? name;

  Source({this.id, this.name});

// berfungsi utk merapikan format data yg didapatkan dari server
// yg awalnya bertipe data .Json, menjadi data yg dimengerti oleh bahasa pemrograman yg digunakan  (javascript object notion)

// yg akan dikembalikan oleh api / server ketika kita melakukan / membuat sebuah request dr api,
// diantaranya : 1. http status 2. data yang berformat Json
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}