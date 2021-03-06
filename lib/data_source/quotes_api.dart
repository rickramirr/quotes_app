import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quotes_app/models/quote.dart';
import 'package:quotes_app/logic/quotes.dart';

class QuotesAPI extends QuotesDataSource {

  var client = http.Client();

  @override
  Future<Quote> getRandomQuote() async {
    return requestRandomQuote(client);
  }

  Future<Quote> requestRandomQuote(http.Client client) async {
    final response =
        await client.get(Uri.parse("https://quotes.rest/qod?language=en"));
    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> quoteData = data['contents']['quotes'][0];
      return Quote.fromJson(quoteData);
    } else {
      return Future.error(response.reasonPhrase.toString());
    }
  }
}
