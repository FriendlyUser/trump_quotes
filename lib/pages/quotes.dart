import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Quote> fetchQuote() async {
  final response = await http.get('https://api.tronalddump.io/random/quote');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Quote.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Quote {
  final String appearedAt;
  final String createdAt;
  final String quoteId;
  final String updatedAt;
  final List<String> tags;
  final String value;

  Quote(
      {this.appearedAt,
      this.createdAt,
      this.quoteId,
      this.updatedAt,
      this.tags,
      this.value});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
        appearedAt: json['appeared_at'],
        createdAt: json['created_at'],
        quoteId: json['quoteId'],
        updatedAt: json['updated_at'],
        tags: json['tags'],
        value: json['value']);
  }
}

class QuotePage extends StatefulWidget {
  // constructor
  QuotePage({Key key}) : super(key: key);
  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  Future<Quote> futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = fetchQuote();
  }

  Widget _makeQuote(Quote data) {
    String quote = data.value;
    String createdAt = data.createdAt;
    return Card(
        child: new Container(
            padding: new EdgeInsets.all(32.0),
            child: ListTile(
              leading: Icon(
                Icons.mode_comment,
                size: 56.0,
              ),
              title: Text(quote),
              subtitle: Text(createdAt),
              trailing: Icon(Icons.more_vert),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get a Quote'),
      ),
      body: Center(
        child: FutureBuilder<Quote>(
          future: futureQuote,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _makeQuote(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          setState(() {
            futureQuote = fetchQuote();
          });
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
