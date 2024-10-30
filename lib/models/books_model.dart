import 'dart:convert';

BooksModel booksModelFromJson(String str) => BooksModel.fromJson(json.decode(str));
String booksModelToJson(BooksModel data) => json.encode(data.toJson());

class BooksModel {
  int count;
  String next;
  dynamic previous;
  List<Result> results;

  BooksModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) => BooksModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String title;
  List<Author> authors;
  List<Translator> translators;
  List<String> subjects;
  List<String> bookshelves;
  List<String> languages;
  bool copyright;
  String mediaType;
  Formats formats;
  int downloadCount;

  Result({
    required this.id,
    required this.title,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    authors: List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
    translators: List<Translator>.from(json["translators"].map((x) => Translator.fromJson(x))),
    subjects: List<String>.from(json["subjects"].map((x) => x)),
    bookshelves: List<String>.from(json["bookshelves"].map((x) => x)),
    languages: List<String>.from(json["languages"].map((x) => x)),
    copyright: json["copyright"],
    mediaType: json["media_type"],
    formats: Formats.fromJson(json["formats"]),
    downloadCount: json["download_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
    "translators": List<dynamic>.from(translators.map((x) => x.toJson())),
    "subjects": List<dynamic>.from(subjects.map((x) => x)),
    "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "copyright": copyright,
    "media_type": mediaType,
    "formats": formats.toJson(),
    "download_count": downloadCount,
  };
}

class Author {
  String name;
  int birthYear;
  int deathYear;

  Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"],
    birthYear: json["birth_year"],
    deathYear: json["death_year"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "birth_year": birthYear,
    "death_year": deathYear,
  };
}

class Formats {
  String textHtml;
  String applicationEpubZip;
  String applicationXMobipocketEbook;
  String applicationRdfXml;
  String imageJpeg;
  String textPlainCharsetUsAscii;
  String applicationOctetStream;
  String? textHtmlCharsetUtf8;
  String? textPlainCharsetUtf8;
  String? textPlainCharsetIso88591;
  String? textHtmlCharsetIso88591;
  String? textHtmlCharsetUsAscii;

  Formats({
    required this.textHtml,
    required this.applicationEpubZip,
    required this.applicationXMobipocketEbook,
    required this.applicationRdfXml,
    required this.imageJpeg,
    required this.textPlainCharsetUsAscii,
    required this.applicationOctetStream,
    this.textHtmlCharsetUtf8,
    this.textPlainCharsetUtf8,
    this.textPlainCharsetIso88591,
    this.textHtmlCharsetIso88591,
    this.textHtmlCharsetUsAscii,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
    textHtml: json["text/html"],
    applicationEpubZip: json["application/epub+zip"],
    applicationXMobipocketEbook: json["application/x-mobipocket-ebook"],
    applicationRdfXml: json["application/rdf+xml"],
    imageJpeg: json["image/jpeg"],
    textPlainCharsetUsAscii: json["text/plain; charset=us-ascii"],
    applicationOctetStream: json["application/octet-stream"],
    textHtmlCharsetUtf8: json["text/html; charset=utf-8"],
    textPlainCharsetUtf8: json["text/plain; charset=utf-8"],
    textPlainCharsetIso88591: json["text/plain; charset=iso-8859-1"],
    textHtmlCharsetIso88591: json["text/html; charset=iso-8859-1"],
    textHtmlCharsetUsAscii: json["text/html; charset=us-ascii"],
  );

  Map<String, dynamic> toJson() => {
    "text/html": textHtml,
    "application/epub+zip": applicationEpubZip,
    "application/x-mobipocket-ebook": applicationXMobipocketEbook,
    "application/rdf+xml": applicationRdfXml,
    "image/jpeg": imageJpeg,
    "text/plain; charset=us-ascii": textPlainCharsetUsAscii,
    "application/octet-stream": applicationOctetStream,
    "text/html; charset=utf-8": textHtmlCharsetUtf8,
    "text/plain; charset=utf-8": textPlainCharsetUtf8,
    "text/plain; charset=iso-8859-1": textPlainCharsetIso88591,
    "text/html; charset=iso-8859-1": textHtmlCharsetIso88591,
    "text/html; charset=us-ascii": textHtmlCharsetUsAscii,
  };
}

class Translator {
  String name;
  int? birthYear;
  int? deathYear;

  Translator({
    required this.name,
    this.birthYear,
    this.deathYear,
  });

  factory Translator.fromJson(Map<String, dynamic> json) => Translator(
    name: json["name"],
    birthYear: json["birth_year"],
    deathYear: json["death_year"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "birth_year": birthYear,
    "death_year": deathYear,
  };
}
  