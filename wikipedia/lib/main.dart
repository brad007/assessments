import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wikipedia/DetailsPage.dart';
import 'package:wikipedia/models/wikipedia_results.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<Search> _searchResults;
  bool _isLoading = false;
  String _query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: "Search"),
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            onEditingComplete: () {
              _getResults();
            },
          ),
          Expanded(child: _body())
        ],
      ),
    );
  }

  Widget _body() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    Widget toReturn;
    if (_searchResults == null) {
      toReturn = _noResults();
    } else {
      toReturn = ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(left: 16),
            child: const Divider(),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          var result = _searchResults[index];
          return ListTile(
            title: Text(result.title),
            subtitle: Text(result.snippet.replaceAll(RegExp("<[^>]*>"), "")),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailsPage(result.title, result.pageid)),
              );
            },
          );
        },
        itemCount: _searchResults.length,
      );
    }
    return toReturn;
  }

  Widget _noResults() {
    return Center(child: Text("No Results"));
  }

  Future<void> _getResults() async {
    _setLoading(true);
    var url =
        "http://en.wikipedia.org/w/api.php?action=query&format=json&list=search&srsearch=${_query.replaceAll(" ", "%20")}";

    var response = await http.get(url);
    WikipediaResults results;
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      results = WikipediaResults.fromJson(jsonResponse);
    }

    setState(() {
      _searchResults = results.query.search;
    });

    _setLoading(false);
  }

  _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
}
