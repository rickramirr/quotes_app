class Quote {
  final String quote;
  final String author;

  Quote(this.quote, this.author);

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(json["quote"], json["author"]);
  }
}
