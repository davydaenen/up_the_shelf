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

  static BookModel fromJson(
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
}

class BookInfo {
  /// The book title
  final String title;

  /// A list with the name of all the authors of the book
  final List<String> authors;

  /// The publisher name
  final String publisher;

  /// The date the book was published
  final DateTime? publishedDate;

  /// The date the book was published in raw string format
  final String rawPublishedDate;

  /// The description of the book
  final String description;

  /// The amount of pages the book has
  final int pageCount;

  /// The categories the book is in
  final List<String> categories;

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
    required this.categories,
    required this.contentVersion,
    required this.description,
    required this.imageLinks,
    required this.language,
    required this.maturityRating,
    required this.pageCount,
    required this.publishedDate,
    required this.rawPublishedDate,
    required this.ratingsCount,
  });

  static BookInfo fromJson(
    Map<String, dynamic> json, {
    bool reschemeImageLinks = false,
  }) {
    final publishedDateArray =
        ((json['publishedDate'] as String?) ?? '0000-00-00').split('-');

    // initialize datetime variable
    DateTime? publishedDate;
    if (publishedDateArray.isNotEmpty) {
      // initialize date
      int year = int.parse(publishedDateArray[0]);
      int month = 1;
      int day = 1;

      // now test the date string
      if (publishedDateArray.length == 1) {
        // assume we have only the year
        year = int.parse(publishedDateArray[0]);
      }
      if (publishedDateArray.length == 2) {
        // assume we have the year and maybe the month (this could be just a speculative case)
        year = int.parse(publishedDateArray[0]);
        month = int.parse(publishedDateArray[1]);
      }
      if (publishedDateArray.length == 3) {
        // assume we have year-month-day
        year = int.parse(publishedDateArray[0]);
        month = int.parse(publishedDateArray[1]);
        day = int.parse(publishedDateArray[2]);
      }
      publishedDate = DateTime(year, month, day);
    }

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
        publishedDate: publishedDate,
        rawPublishedDate: (json['publishedDate'] as String?) ?? '',
        imageLinks: imageLinks);
  }

  @override
  String toString() {
    return '''title: $title
    authors: $authors
    publisher: $publisher
    publishedDate: $publishedDate
    rawPublishedDate: $rawPublishedDate
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
