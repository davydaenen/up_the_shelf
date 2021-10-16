import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:up_the_shelf/src/config/app_theme.dart';
import 'package:up_the_shelf/src/utils/providers/google_books_api_provider.dart';
import 'package:up_the_shelf/src/widgets/book_list_card.dart';
import 'package:up_the_shelf/src/widgets/search_bar.dart';

class SearchBooksScreen extends StatelessWidget {
  const SearchBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final googleBooksApiProvider = context.watch<GoogleBooksApiProvider>();
    print(googleBooksApiProvider.searchResults.length);
    if (googleBooksApiProvider.searchResults.isNotEmpty) {
      print(googleBooksApiProvider.searchResults[0]);
    }

    return Scaffold(
        appBar: AppBar(
          leadingWidth: 80,
          leading: MaterialButton(
            elevation: 0.0,
            visualDensity: VisualDensity.compact,
            shape: const CircleBorder(),
            color: Colors.blueGrey.withOpacity(0.1),
            padding: const EdgeInsets.all(0),
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.chevron_left, color: AppTheme.blueGrey!),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
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
                        : const Center(
                            child: Text('No books found'),
                          ),
              )
            ],
          ),
        ));
  }
}
