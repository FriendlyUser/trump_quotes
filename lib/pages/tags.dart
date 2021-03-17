import 'dart:async';
import 'package:flutter/material.dart';
import '../api/fetch.dart';
import 'package:url_launcher/url_launcher.dart';

class TagPage extends StatefulWidget {
  // constructor
  TagPage({Key key}) : super(key: key);
  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  Future<Tags> futureTags;
  @override
  void initState() {
    super.initState();
    futureTags = fetchTags();
  }

  List<Widget> _buildTags(List<Tag> inputTags) {
    if (inputTags == null) {
      return [Text('No Tags Found')];
    }
    List<Widget> tags = [];

    for (var tag in inputTags) {
      var url = tag.links['self']['href'];
      Widget elem = InputChip(
        label: Text(tag.value),
        onPressed: () {
          launchURL(url);
        },
      );
      print(elem);
      tags.add(elem);
    }
    return tags;
  }

  Widget _makeTag(Tags data) {
    var embedded = data.embedded;
    var tags = embedded.tag;
    return Container(
      padding: new EdgeInsets.all(32.0),
      child: Wrap(children: _buildTags(tags))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get a Quote'),
      ),
      body: Center(
        child: FutureBuilder<Tags>(
          future: futureTags,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _makeTag(snapshot.data);
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
            futureTags = fetchTags();
          });
        },
        child: Icon(Icons.refresh),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
