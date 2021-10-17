import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:up_the_shelf/src/config/app_theme.dart';
import 'package:up_the_shelf/src/utils/helpers/debouncer.dart';
import 'package:up_the_shelf/src/utils/providers/google_books_api_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBar extends StatelessWidget {
  final _debouncer = Debouncer(milliseconds: 500);
  final VoidCallback? onClickAction;
  final bool autoFocus;

  SearchBar({Key? key, this.autoFocus = false, this.onClickAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final googleBooksApiProvider = context.watch<GoogleBooksApiProvider>();
    final TextEditingController _searchControl =
        TextEditingController(text: googleBooksApiProvider.searchQuery);
    _searchControl.selection = TextSelection.fromPosition(
        TextPosition(offset: _searchControl.text.length));

    return GestureDetector(
      onTap: () {
        if (onClickAction != null) {
          onClickAction!();
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(35.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Theme(
          data: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
          child: TextField(
            autofocus: autoFocus,
            enabled: onClickAction == null,
            style: TextStyle(
              fontSize: 15.0,
              color: AppTheme.blueGrey,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(25.0),
              hintText: AppLocalizations.of(context)!.screenSearchBooksInput,
              prefixIcon: Icon(
                Icons.search,
                color: AppTheme.blueGrey,
                size: 30,
              ),
              hintStyle: TextStyle(
                fontSize: 15.0,
                color: AppTheme.blueGrey,
              ),
            ),
            maxLines: 1,
            controller: _searchControl,
            onChanged: (string) {
              _debouncer.run(() => googleBooksApiProvider.queryBooks(
                  _searchControl.value.text,
                  printType: PrintType.books));
            },
          ),
        ),
      ),
    );
  }
}
