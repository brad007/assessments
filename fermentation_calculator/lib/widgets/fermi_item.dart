import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FermiItem extends StatelessWidget{
  final DocumentSnapshot document;

  FermiItem(this.document);
  @override
  Widget build(BuildContext context) {

    return Card(
        child: Container(
            margin:
            EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: _determiningState(
                          document['dateStarted']),
                    ),
                    Expanded(
                        child: ListTile(
                          title: new Text(
                            (document['name'] as String)
                                .toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: new Text(_showSelectedDate(
                              document['dateStarted'])),
                        ))
                  ],
                ),
                _determiningStatus(document['dateStarted']),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    "Days fermenting: ${_daysFermenting(document['dateStarted'])}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )));
  }


  int _daysFermenting(int date) {
    var now = DateTime.now().millisecondsSinceEpoch;
    var delta = now - date;
    return delta ~/ 86400000;
  }

  Widget _determiningState(int date) {
    var delta = _daysFermenting(date);
    if (delta >= 0 && delta <= 1) {
      //24hrs
      return Icon(Icons.sentiment_dissatisfied, color: Colors.red);
    } else if (delta > 1 && delta <= 4) {
      //48hrs
      return Icon(Icons.sentiment_neutral, color: Colors.orange);
    } else {
      return Icon(Icons.sentiment_satisfied, color: Colors.green);
    }
  }

  Widget _determiningStatus(int date) {
    var delta = _daysFermenting(date);
    String message;
    if (delta >= 0 && delta <= 1) {
      //24hrs
      message = "Microbes are killing off bad bacteria";
    } else if (delta > 1 && delta <= 4) {
      //48hrs
      message = "Loctobacillus are convertings sugars to acid";
    } else {
      message = "Developing more acids\n(Ready to eat between 4 - 28 days)";
    }
    return Text(message);
  }

  String _showSelectedDate(int date) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(date);
    var formatter = DateFormat("EEE, d MMM yyyy");
    var formatted = formatter.format(dateTime);
    return formatted;
  }
}