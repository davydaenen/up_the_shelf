/// Implementation of BookModel is based on: https://github.com/bdlukaa/books_finder/blob/master/lib/src/scripts/books.dart
class BookModel {
  final String id;
  final String? etag;
  final Uri? selfLink;
  final BookInfo info;

  const BookModel({
    required this.id,
    this.etag,
    required this.info,
    this.selfLink,
  });

  @override
  String toString() => '$id:${info.title}';

  factory BookModel.fromJson(
    Map<String, dynamic> json, {
    bool reschemeImageLinks = false,
  }) {
    return BookModel(
      id: json['id'],
      etag: json['etag'],
      info: BookInfo.fromJson(
        json['volumeInfo'],
        reschemeImageLinks: reschemeImageLinks,
      ),
      selfLink: Uri.parse(json['selfLink']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'etag': etag, 'selfLink': selfLink, 'info': info.toMap()};
  }
}

class BookInfo {
  /// The book title
  final String title;

  /// A list with the name of all the authors of the book
  final List<String> authors;

  /// The publisher name
  final String publisher;

  /// The description of the book
  final String description;

  /// The amount of pages the book has
  final int pageCount;

  /// The categories the book is in
  final List<String>? categories;

  /// The average rating
  final double averageRating;

  /// How many people rated the book
  final int ratingsCount;

  /// Wether the book is mature or not
  final String maturityRating;

  /// The content version
  final String contentVersion;

  /// Some image links
  final Map<String, Uri> imageLinks;

  /// The original language of the book
  final String language;

  const BookInfo({
    required this.title,
    required this.authors,
    required this.publisher,
    required this.averageRating,
    this.categories,
    required this.contentVersion,
    required this.description,
    required this.imageLinks,
    required this.language,
    required this.maturityRating,
    required this.pageCount,
    required this.ratingsCount,
  });

  factory BookInfo.fromJson(
    Map<String, dynamic> json, {
    bool reschemeImageLinks = false,
  }) {
    final imageLinks = <String, Uri>{};
    (json['imageLinks'] as Map<String, dynamic>?)?.forEach((key, value) {
      Uri uri = Uri.parse(value.toString());
      if (reschemeImageLinks) {
        if (uri.isScheme('HTTP')) {
          uri = Uri.parse(value.toString().replaceAll('http://', 'https://'));
        }
      }
      imageLinks.addAll({key: uri});
    });

    return BookInfo(
        title: json['title'] ?? '',
        authors: ((json['authors'] as List<dynamic>?) ?? []).toStringList(),
        publisher: json['publisher'] ?? '',
        averageRating: ((json['averageRating'] ?? 0) as num).toDouble(),
        categories:
            ((json['categories'] as List<dynamic>?) ?? []).toStringList(),
        contentVersion: json['contentVersion'] ?? '',
        description: json['description'] ?? '',
        language: json['language'] ?? '',
        maturityRating: json['maturityRating'] ?? '',
        pageCount: json['pageCount'] ?? 0,
        ratingsCount: json['ratingsCount'] ?? 0,
        imageLinks: imageLinks);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'authors': authors,
      'publisher': publisher,
      'averageRating': averageRating,
      'categories': categories,
      'contentVersion': contentVersion,
      'description': description,
      'language': language,
      'maturityRating': maturityRating,
      'pageCount': pageCount,
      'ratingsCount': ratingsCount,
      'imageLinks': imageLinks
    };
  }

  @override
  String toString() {
    return '''title: $title
    authors: $authors
    publisher: $publisher
    averageRating: $averageRating
    categories: $categories
    contentVersion $contentVersion
    description: $description
    language: $language
    maturityRating: $maturityRating
    pageCount: $pageCount
    ratingsCount: $ratingsCount
    imageLinks: $imageLinks''';
  }
}

extension Str on List<dynamic> {
  List<String> toStringList() {
    final l = <String>[];
    for (var i in this) {
      l.add(i.toString());
    }
    return l;
  }
}
