import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _searchControl = TextEditingController();

  SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: TextField(
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.blueGrey[300],
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: "E.g: New York, United States",
          prefixIcon: Icon(
            Icons.location_on,
            color: Colors.blueGrey[300],
          ),
          hintStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.blueGrey[300],
          ),
        ),
        maxLines: 1,
        controller: _searchControl,
      ),
    );
  }
}
