import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotes_app/quote.dart';
import 'package:quotes_app/quotes.dart';
import 'package:quotes_app/quotes_api.dart';

class QuotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quotes = Quotes(QuotesAPI());

    return Scaffold(
        body: FutureBuilder(
      future: quotes.getRandomQuote(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(child: Text("Fetch something"));
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(child: Text("Something happened"));
            }
            final quote = snapshot.data as Quote;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(quote.quote)],
              ),
            );
        }
      },
    ));
  }
}
