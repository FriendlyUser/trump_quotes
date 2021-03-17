import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../api/fetch.dart';
import 'package:social_share/social_share.dart';


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
                        SocialShare.shareOptions(quote)
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
                onTap: () => {})));
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
