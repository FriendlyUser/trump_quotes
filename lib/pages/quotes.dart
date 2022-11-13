import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

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
    var quote = data.value;
    String createdAt = data.createdAt;
    String appearedAt = data.appearedAt;
    if (!kIsWeb) {
      return Card(
          child: new Container(
              padding: new EdgeInsets.all(32.0),
              child: ListTile(
                  leading: Icon(
                    Icons.mode_comment,
                    size: 56.0,
                  ),
                  title: Text(quote),
                  subtitle: Text(appearedAt),
                  trailing: Icon(Icons.more_vert),
                  onTap: () => {
                     Clipboard.setData(ClipboardData(text: data.value)).then((_){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Quote copied to clipboard")));
                      })
                  })));
    }
    return Card(
        child: new Container(
            padding: new EdgeInsets.all(32.0),
            child: ListTile(
                leading: Icon(
                  Icons.mode_comment,
                  size: 56.0,
                ),
                title: Text(quote),
                subtitle: Text(appearedAt),
                trailing: Icon(Icons.more_vert),
                onTap: () => {
                   Clipboard.setData(ClipboardData(text: data.value)).then((_){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Quote copied to clipboard")));
                    })
                })));
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
        child: Icon(Icons.refresh),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
