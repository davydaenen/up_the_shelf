import 'package:flutter/material.dart';
import 'package:up_the_shelf/src/config/app_theme.dart';
import 'package:up_the_shelf/src/ui/books/book_detail_screen.dart';
import 'package:up_the_shelf/src/utils/models/book_model.dart';

class BookListCard extends StatelessWidget {
  final BookModel book;

  const BookListCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = book.info.imageLinks['thumbnail']!.toString();
    String? category =
        (book.info.categories != null && book.info.categories!.isNotEmpty)
            ? book.info.categories![0]
            : null;

    final widthSize = MediaQuery.of(context).size.width * 0.3;
    final widthHeight = MediaQuery.of(context).size.height * 0.25;

    return SizedBox(
        height: widthHeight,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return BookDetailScreen(book: book);
                    }));
                  },
                  splashColor: AppTheme.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Hero(
                          tag: book.id,
                          child: Container(
                            width: widthSize,
                            height: widthHeight,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0))),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('by ${book.info.authors[0]}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal,
                                        color: AppTheme.blueGrey!)),
                                const SizedBox(height: 10),
                                Text(book.info.title,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    )),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star_rate,
                                        color: AppTheme.appColor, size: 18),
                                    Text(book.info.averageRating.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                            color: AppTheme.blueGrey!))
                                  ],
                                ),
                                const SizedBox(height: 10),
                                if (category != null)
                                  SizedBox(
                                    child: Chip(
                                      visualDensity: VisualDensity.compact,
                                      padding: const EdgeInsets.all(0),
                                      label: Text(category,
                                          style: const TextStyle(fontSize: 10)),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.all(10),
            ),
          ],
        ));
  }
}
