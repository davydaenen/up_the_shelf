import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_the_shelf/src/utils/providers/google_books_api_provider.dart';
import 'package:up_the_shelf/src/widgets/book_list_card.dart';
import 'package:up_the_shelf/src/widgets/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BooksListExploreView extends StatelessWidget {
  const BooksListExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _listPadding = EdgeInsets.all(25.0);
    final googleBooksApiProvider = context.watch<GoogleBooksApiProvider>();
    final famousBooks = googleBooksApiProvider.fetchFamousBooks();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            primary: true,
            pinned: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Padding(
                    padding: _listPadding,
                    child: Text(
                      AppLocalizations.of(context)!.screenBookListExploreTitle,
                      style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: _listPadding,
                    child: SearchBar(),
                  ),
                ],
              ),
            ),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 250,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: _listPadding,
              child: Text(
                AppLocalizations.of(context)!.screenBookListExploreSubTitle,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) => Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: BookListCard(book: famousBooks[index]),
              ),

              childCount: famousBooks.length,
              // Builds 1000 ListTiles
            ),
          )
        ],
      ),
    );
  }
}
