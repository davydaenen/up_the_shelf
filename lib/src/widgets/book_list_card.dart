import 'package:flutter/material.dart';
import 'package:up_the_shelf/src/config/app_theme.dart';
import 'package:up_the_shelf/src/utils/models/book_model.dart';

class BookListCard extends StatelessWidget {
  final BookModel? book;

  const BookListCard({Key? key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Material(
                child: InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //   return Container();
                    // }));
                  },
                  splashColor: AppTheme.blueGrey,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
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
