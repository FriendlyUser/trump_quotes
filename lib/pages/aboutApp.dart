
import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: AboutListTile(
        icon: Icon(Icons.info),
        child: Text('Trump Quotes'),
        applicationIcon: Icon(Icons.local_play),
        applicationName: 'Trump Quotes',
        applicationVersion: '1.1.1',
        applicationLegalese: '© 2020 Grandfleet',
        aboutBoxChildren: [
          ///Content goes here...
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
