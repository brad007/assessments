import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final int id;

  DetailsPage(this.title, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title)),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: "https://en.wikipedia.org/?curid=$id",
          )
        ],
      ),
    );
  }
}
