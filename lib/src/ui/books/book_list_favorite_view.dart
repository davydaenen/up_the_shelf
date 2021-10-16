import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:up_the_shelf/src/config/app_theme.dart';
import 'package:up_the_shelf/src/utils/models/book_model.dart';
import 'package:up_the_shelf/src/utils/services/firestore_database.dart';
import 'package:up_the_shelf/src/widgets/book_list_card.dart';

class BooksListFavoriteView extends StatelessWidget {
  const BooksListFavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _listPadding = EdgeInsets.all(10.0);
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            primary: true,
            pinned: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: _listPadding,
                child: Row(
                  children: [
                    Icon(Icons.bookmark, size: 40, color: AppTheme.appColor),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.screenBookListFavoriteTitle,
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 100,
          ),
          StreamBuilder(
            stream: firestoreDatabase.booksStream(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                List<BookModel> myBooks = snapshot.data as List<BookModel>;

                myBooks.isNotEmpty
                    ? SliverList(
                        // Use a delegate to build items as they're scrolled on screen.
                        delegate: SliverChildBuilderDelegate(
                          // The builder function returns a ListTile with a title that
                          // displays the index of the current item.
                          (context, index) => Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25.0),
                            child: BookListCard(book: myBooks[index]),
                          ),

                          childCount: myBooks.length,
                          // Builds 1000 ListTiles
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Center(
                            child: Text(AppLocalizations.of(context)!
                                .screenBookListFavoriteTextNoFavorites)),
                      );
              }

              return SliverFillRemaining(
                child: Center(
                  child: Text(AppLocalizations.of(context)!
                      .screenBookListFavoriteTextNoFavorites),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
