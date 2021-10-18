import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_the_shelf/src/ui/search/search_books_screen.dart';
import 'package:up_the_shelf/src/utils/providers/google_books_api_provider.dart';
import 'package:up_the_shelf/src/widgets/book_list_card.dart';
import 'package:up_the_shelf/src/widgets/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BooksListExploreView extends StatelessWidget {
  const BooksListExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _listPadding = EdgeInsets.all(15.0);
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: _listPadding,
                    child: SearchBar(
                      onClickAction: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ChangeNotifierProvider(
                              create: (context) => GoogleBooksApiProvider(),
                              child: const SearchBooksScreen());
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
            expandedHeight: 200,
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
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: BookListCard(book: famousBooks[index]),
              ),
              childCount: famousBooks.length,
            ),
          )
        ],
      ),
    );
  }
}
