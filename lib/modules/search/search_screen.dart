import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(
        'search screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
