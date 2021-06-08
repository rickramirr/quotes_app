import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quotes_app/data_source/quotes_api.dart';
import 'package:quotes_app/models/quote.dart';

import 'quotes_api.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {

  final correctJSON = """
  {
    "success": {
        "total": 1
    },
    "contents": {
        "quotes": [
            {
                "quote": "Sometimes you climb out of bed in the morning and you think, I'm not going to make it, but you laugh inside - remembering all the times you've felt that way.",
                "length": "164",
                "author": "Charles Bukowski",
                "tags": [
                    "depression",
                    "inspire",
                    "life"
                ],
                "category": "inspire",
                "language": "en",
                "date": "2021-06-08",
                "permalink": "https://theysaidso.com/quote/charles-bukowski-sometimes-you-climb-out-of-bed-in-the-morning-and-you-think-im",
                "id": "k7rTMtmveYHUN2ImwxNhhAeF",
                "background": "https://theysaidso.com/img/qod/qod-inspire.jpg",
                "title": "Inspiring Quote of the day"
            }
        ]
    }
  }
  """;
  group("quotesAPI", () {
    test('return quote if http call completes succesfully', () async {
      final client = MockClient();
      final quotesAPI = QuotesAPI();
      quotesAPI.client = client;

      when(client.get(Uri.parse("https://quotes.rest/qod?language=en")))
        .thenAnswer((_) async => http.Response(correctJSON, 200));

      expect(await quotesAPI.requestRandomQuote(client), isA<Quote>());
    });

    test('throws an exception if the http call completes with an error', () async {
      final client = MockClient();
      final quotesAPI = QuotesAPI();
      quotesAPI.client = client;

      when(client.get(Uri.parse("https://quotes.rest/qod?language=en")))
        .thenAnswer((_) async => http.Response('Not found', 404, reasonPhrase: "Not found"));

      try {
        final quote = await quotesAPI.requestRandomQuote(client);
        fail("not getting error");
      } catch(e) {
        expect(e.toString(), "Not found");
      }
    });
  });
}