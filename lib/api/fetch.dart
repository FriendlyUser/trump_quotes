import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

Future<Quote> fetchQuote() async {
  final response = await http.get('https://api.tronalddump.io/random/quote', headers: {
    'Content-Type': 'application/json; charset=utf-8',
    'Accept': 'application/json; charset=utf-8'
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Quote.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load quote');
  }
}


class Quote {
  final String appearedAt;
  final String createdAt;
  final String quoteId;
  final String updatedAt;
  final List<dynamic> tags;
  final String value;

  Quote({this.appearedAt, this.createdAt, this.quoteId, this.updatedAt, this.tags, this.value});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(appearedAt: json['appeared_at'], createdAt: json['created_at'], quoteId: json['quoteId'], updatedAt: json['updated_at'], tags: json['tags'], value: json['value']);
  }
}

class Link {
  
}
class Tag {
  final String createdAt;
  final String updatedAt;
  final String value;
  final dynamic links;

  Tag({this.createdAt, this.updatedAt, this.value, this.links});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(createdAt: json['created_at'], links: json['_links'], value: json['value']);
  }
}

class Embedded {

  final List<Tag> tag;
  Embedded({this.tag});

  factory Embedded.fromJson(Map<String, dynamic> json) {
    List<dynamic> tagObjs = json['tag'];
    List<Tag> newTags = [];
    tagObjs.forEach((tag) {
      Tag newTag = Tag.fromJson(tag);
      newTags.add(newTag);
    });
    return Embedded(tag: newTags);
  }
}


Future<Tags> fetchTags() async {
    final response = await http.get('https://api.tronalddump.io/tag', headers: {
    'Content-Type': 'application/json; charset=utf-8',
    'Accept': 'application/json; charset=utf-8'
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Tags.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load tags');
  }
}


class Tags {
  final int count;
  final int total;
  final Embedded embedded;

  Tags({this.count, this.total, this.embedded});
  factory Tags.fromJson(Map<String, dynamic> json) {
    Embedded embed = Embedded.fromJson(json['_embedded']);
    return Tags(count: json['count'], total: json['total'], embedded: embed);
  }
}

void launchURL(_url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';