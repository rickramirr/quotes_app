import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quotes_app/quote.dart';
import 'package:quotes_app/quotes.dart';

class QuotesAPI extends QuotesDataSource {
  @override
  Future<Quote> getRandomQuote() async {
    final response =
        await http.get(Uri.parse("https://quotes.rest/qod?language=en"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> quoteData = data['contents']['quotes'][0];
      return Quote.fromJson(quoteData);
    } else {
      return Future.error(response.reasonPhrase.toString());
    }
  }
}
