import 'package:up_the_shelf/src/utils/models/book_model.dart';
import 'package:up_the_shelf/src/utils/services/firestore_service.dart';

class FirestorePath {
  static String book(String uid, String bookId) => 'users/$uid/books/$bookId';
  static String books(String uid) => 'users/$uid/books';
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _firestoreService = FirestoreService.instance;

  //Method to create/update bookModel (add to favorites)
  Future<void> setBook(BookModel book) async => await _firestoreService.set(
        path: FirestorePath.book(uid, book.id),
        data: book.toMap(),
      );

  //Method to delete bookModel (remove favorites)
  Future<void> deleteBook(BookModel book) async {
    await _firestoreService.deleteData(path: FirestorePath.book(uid, book.id));
  }

  //Method to retrieve bookModel object based on the given bookId
  Stream<BookModel> bookStream({required String bookId}) {
    return _firestoreService.documentStream(
      path: FirestorePath.book(uid, bookId),
      builder: (data, documentId) => BookModel.fromDocument(data),
    );
  }

  //Method to retrieve all books from the same user based on uid
  Stream<List<BookModel>> booksStream() {
    return _firestoreService.collectionStream(
      path: FirestorePath.books(uid),
      builder: (data, documentId) => BookModel.fromDocument(data),
    );
  }
}
