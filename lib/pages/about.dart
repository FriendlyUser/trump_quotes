import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Text('This app was built in preparation for the 2020 election'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          showAboutDialog(
            context: context,
            applicationIcon: Icon(
              Icons.local_play,
              size: 65,
              color: Theme.of(context).accentColor,
            ),
            applicationName: 'Trump Quotes',
            applicationVersion: '1.1.1',
            applicationLegalese: '© 2020 Grandfleet'
          );
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
