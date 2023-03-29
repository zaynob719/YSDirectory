import 'package:coveredncurly/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBarWidget(
          //isReadOnly: true,
          hasBackButton: false,
        ),
        body: Center(
          child: Text("search screen1"),
        ));
  }
}
