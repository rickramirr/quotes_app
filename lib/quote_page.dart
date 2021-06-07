import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotes_app/quote.dart';
import 'package:quotes_app/quotes.dart';
import 'package:quotes_app/quotes_api.dart';
import 'package:google_fonts/google_fonts.dart';

class QuotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quotes = Quotes(QuotesAPI());

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Quote"),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.exit_to_app)
          )
        ],
      ),
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
                return Center(child: Text(snapshot.error.toString()));
              }
              final quote = snapshot.data as Quote;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quote.quote, 
                        style: GoogleFonts.ptSerif(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '-${quote.author}',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      )
                    ],
                  ),
                ),
              );
          }
        },
      )
    );
  }
}
