import 'package:flutter/material.dart';
import 'package:up_the_shelf/src/utils/models/book_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:up_the_shelf/src/utils/models/popular_books.dart';

/// Order the query by `newest` or `relevance`
enum OrderBy {
  newest,
  relevance,
}

enum PrintType {
  all,
  books,
  magazines,
}

/// Provider for fetching data from Google Books Api
/// Implementation of this GoogleBooksApiProvider is based on: https://github.com/bdlukaa/books_finder/blob/master/lib/src/books_finder_base.dart
class GoogleBooksApiProvider extends ChangeNotifier {
  List<BookModel> _searchResults = [];
  List<BookModel> get searchResults => _searchResults;

  String _searchQuery = "";
  String get searchQuery => _searchQuery;

  bool _loading = false;
  bool get loading => _loading;

  /// Query a list of books
  ///
  /// `query` parameter must not be null and must not be empty.
  /// Spaces characters are allowed
  ///
  /// Set `orderBy` to order the query by newest or relevance
  /// and `printType` to filter in books or magazines
  ///
  /// Set `maxResults` to set the max amount of results.
  /// Set `startIndex` for pagination
  ///
  /// Example of querying:
  /// ```
  /// void main(List<String> args) async {
  ///   final books = await queryBooks(
  ///     'twilight',
  ///     maxResults: 3,
  ///     printType: PrintType.books,
  ///     orderBy: OrderBy.relevance,
  ///   );
  ///   books.forEach((Book book) {
  ///     print(book);
  ///   });
  /// }
  /// ```
  ///
  Future<List<BookModel>> queryBooks(
    String query, {
    int maxResults = 10,
    OrderBy? orderBy,
    PrintType? printType = PrintType.all,
    int startIndex = 0,
    bool reschemeImageLinks = false,
  }) async {
    assert(query.isNotEmpty);

    var q = 'https://www.googleapis.com/books/v1/volumes?q=' +
        query.trim().replaceAll(' ', '+') +
        '&maxResults=$maxResults';

    if (orderBy != null) {
      q += '&orderBy=${orderBy.toString().replaceAll('OrderBy.', '')}';
    }
    if (printType != null) {
      q += '&printType=${printType.toString().replaceAll('PrintType.', '')}';
    }

    _loading = true;
    _searchQuery = query;
    notifyListeners();

    final result = await http.get(Uri.parse(q));
    if (result.statusCode == 200) {
      final books = <BookModel>[];
      final list = (jsonDecode(result.body))['items'] as List<dynamic>?;
      if (list == null) return [];
      for (var e in list) {
        final bookModel =
            BookModel.fromJson(e, reschemeImageLinks: reschemeImageLinks);

        if (bookModel.info.imageLinks.isNotEmpty &&
            bookModel.info.authors.isNotEmpty) {
          books.add(bookModel);
        }
      }
      _searchResults = books;
      _loading = false;
      notifyListeners();
      return books;
    } else {
      _searchResults = [];
      _loading = false;
      notifyListeners();
      throw (result.body);
    }
  }

  /// Get an specific book with its `id`.
  /// You can not add specific parameters to this.
  Future<BookModel> fetchSpecificBook(
    String id, {
    bool reschemeImageLinks = false,
  }) async {
    assert(id.isNotEmpty, 'You must provide a valid book id');
    final q = 'https://www.googleapis.com/books/v1/volumes/${id.trim()}';

    _loading = true;
    notifyListeners();

    final result = await http.get(Uri.parse(q));
    if (result.statusCode == 200) {
      _loading = false;
      notifyListeners();
      return BookModel.fromJson(
        jsonDecode(result.body) as Map<String, dynamic>,
        reschemeImageLinks: reschemeImageLinks,
      );
    } else {
      _loading = false;
      notifyListeners();
      throw (result.body);
    }
  }

  /// Get a static list of famous books.
  List<BookModel> fetchFamousBooks() {
    final books = <BookModel>[];
    for (var e in popularBooks) {
      books.add(BookModel.fromJson(e, reschemeImageLinks: false));
    }

    return books;
  }
}
