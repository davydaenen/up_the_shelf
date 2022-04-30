import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:up_the_shelf/src/config/app_theme.dart';
import 'package:up_the_shelf/src/utils/providers/google_books_api_provider.dart';
import 'package:up_the_shelf/src/widgets/book_list_card.dart';
import 'package:up_the_shelf/src/widgets/search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBooksScreen extends StatelessWidget {
  const SearchBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final googleBooksApiProvider = context.watch<GoogleBooksApiProvider>();

    return Scaffold(
        appBar: AppBar(
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
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchBar(
                autoFocus: true,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: googleBooksApiProvider.loading
                    ? const Center(child: CircularProgressIndicator())
                    : (googleBooksApiProvider.searchResults.isNotEmpty)
                        ? ListView.builder(
                            itemCount:
                                googleBooksApiProvider.searchResults.length,
                            itemBuilder: (_, i) {
                              return BookListCard(
                                  book:
                                      googleBooksApiProvider.searchResults[i]);
                            })
                        : Center(
                            child: Text(AppLocalizations.of(context)!
                                .screenSearchBooksTextNoBooksFound),
                          ),
              )
            ],
          ),
        ));
  }
}
