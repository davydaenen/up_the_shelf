import 'package:flutter/material.dart';
import 'package:up_the_shelf/src/config/app_theme.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _searchControl = TextEditingController();

  SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          style: TextStyle(
            fontSize: 15.0,
            color: AppTheme.blueGrey,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(25.0),
            hintText: "Search for books...",
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
        ),
      ),
    );
  }
}
