import 'package:flutter/material.dart';
import 'package:up_the_shelf/src/widgets/search_bar.dart';

class PlacesListView extends StatelessWidget {
  const PlacesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Where are you \ngoing?",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SearchBar(),
          ),
        ],
      ),
    );
  }
}
