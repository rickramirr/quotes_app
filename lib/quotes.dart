import 'package:quotes_app/quote.dart';

abstract class QuotesDataSource {
  Future<Quote> getRandomQuote();
}

class Quotes {
  QuotesDataSource _dataSource;

  Quotes(this._dataSource);

  Future<Quote> getRandomQuote() async {
    return await _dataSource.getRandomQuote();
  }
}
