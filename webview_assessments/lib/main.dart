import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:validators/validators.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'WebView Assessment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _url;
  String _error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _url = 'https://flutter.dev';
    _error = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) {
              var isUrl = isURL(value.toLowerCase());
              if (isUrl) {
                setState(() {
                  _url = value.toLowerCase();
                  _error = null;
                });
              } else {
                setState(() {
                  _error = "Invalid URL";
                });
              }
            },
            decoration:
                InputDecoration(hintText: "Enter URL", errorText: _error),
          ),
          Expanded(child: _webViewWidget())
        ],
      ),
    );
  }

  Widget _webViewWidget() {
    return _error == null
        ? WebviewScaffold(url: _url)
        : Center(child: CircularProgressIndicator());
  }
}
