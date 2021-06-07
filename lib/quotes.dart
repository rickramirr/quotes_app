import 'package:quotes_app/quote.dart';

abstract class QuotesDataSource {
  Future<Quote> getRandomQuote();
}

class Quotes {
  QuotesDataSource _dataSource;

  Quotes(this._dataSource);

  Future<Quote> getRandomQuote() async {
    try {
      return await _dataSource.getRandomQuote();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
