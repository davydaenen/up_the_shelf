import 'package:flutter/material.dart';
import 'package:up_the_shelf/src/widgets/book_list_card.dart';
import 'package:up_the_shelf/src/widgets/search_bar.dart';

class BooksListExploreView extends StatelessWidget {
  const BooksListExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _listPadding = EdgeInsets.all(25.0);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            primary: true,
            pinned: false,
            // Allows the user to reveal the app bar if they begin scrolling
            // back up the list of items.
            floating: true,
            // Display a placeholder widget to visualize the shrinking size.
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  const Padding(
                    padding: _listPadding,
                    child: Text(
                      "Explore thousands of \nbooks on the go",
                      style: TextStyle(
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
          const SliverToBoxAdapter(
            child: Padding(
              padding: _listPadding,
              child: Text(
                "Famous Books",
                style: TextStyle(
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
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(5, (i) => const BookListCard()),
                ),
              ),
              // Builds 1000 ListTiles
              childCount: 5,
            ),
          )
        ],
      ),
    );
  }
}
