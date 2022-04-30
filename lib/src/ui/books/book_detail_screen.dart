import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_the_shelf/src/config/app_theme.dart';
import 'package:up_the_shelf/src/utils/models/book_model.dart';
import 'package:up_the_shelf/src/utils/services/firestore_database.dart';

class BookDetailScreen extends StatelessWidget {
  final BookModel book;

  const BookDetailScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);
    final imageUrl = book.info.imageLinks['thumbnail']!.toString();

    final imageHeight = MediaQuery.of(context).size.height * 0.3;
    final imageWidth = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.info.title),
        centerTitle: true,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: MaterialButton(
            elevation: 0.0,
            visualDensity: VisualDensity.compact,
            shape: const CircleBorder(),
            color: Colors.blueGrey.withOpacity(0.1),
            padding: const EdgeInsets.all(0),
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.chevron_left, color: AppTheme.blueGrey!),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: StreamBuilder<BookModel>(
                stream: firestoreDatabase.bookStream(bookId: book.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MaterialButton(
                      elevation: 0.0,
                      visualDensity: VisualDensity.compact,
                      shape: const CircleBorder(),
                      color: Colors.blueGrey.withOpacity(0.1),
                      padding: const EdgeInsets.all(0),
                      onPressed: () => firestoreDatabase.deleteBook(book),
                      child: Icon(Icons.bookmark, color: AppTheme.appColor),
                    );
                  } else {
                    return MaterialButton(
                      elevation: 0.0,
                      visualDensity: VisualDensity.compact,
                      shape: const CircleBorder(),
                      color: Colors.blueGrey.withOpacity(0.1),
                      padding: const EdgeInsets.all(0),
                      onPressed: () => firestoreDatabase.setBook(book),
                      child: Icon(Icons.bookmark_add_outlined,
                          color: AppTheme.appColor),
                    );
                  }
                }),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: book.id,
                    child: Container(
                      height: imageHeight,
                      width: imageWidth,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(imageUrl), fit: BoxFit.fill),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(book.info.title,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rate,
                              color: AppTheme.appColor, size: 25),
                          const SizedBox(width: 5.0),
                          Text(book.info.averageRating.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.blueGrey!))
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('by ${book.info.authors[0]}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.blueGrey!)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(book.info.description,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          color: AppTheme.blueGrey!)),
                ),
                if (book.info.categories != null &&
                    book.info.categories!.isNotEmpty)
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: book.info.categories!
                            .map((category) => Chip(
                                  label: Text(category,
                                      style: const TextStyle(fontSize: 10)),
                                ))
                            .toList(),
                      ))
              ],
            )),
      ),
    );
  }
}
