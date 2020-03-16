import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fermentation_calculator/models/fermi.dart';
import 'package:fermentation_calculator/pages/res/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddFermentationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddFermentationState();
}

class _AddFermentationState extends State<AddFermentationPage> {
  DateTime _selectedDate = DateTime.now();
  TextEditingController _controller = TextEditingController();
  String _uid;

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        _uid = user.uid;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.ADD_FERMI)),
      body: Container(
          child: Row(
        children: <Widget>[
          Expanded(
            child: Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: "Ingredient"),
                    ),
                    SizedBox(height: 32),
                    _dateSelectorWidget()
                  ],
                ),
              ),
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _sendToFirebase(),
        icon: Icon(Icons.save),
        label: Text("SAVE"),
      ),
    );
  }

  Widget _dateSelectorWidget() {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  Strings.DATE.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                Strings.CHANGE.toUpperCase(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: 8),
          Text(_showSelectedDate())
        ],
      ),
      onTap: () => _selectDate(context),
    );
  }

  String _showSelectedDate() {
    var formatter = DateFormat("EEE, d MMM yyyy");
    var formatted = formatter.format(_selectedDate);
    return formatted;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  _sendToFirebase() {
    var name = _controller.text;
    var selectedDate = _selectedDate.millisecondsSinceEpoch;
    var createdDate = DateTime.now().millisecondsSinceEpoch;

    var fermi = Fermi(
        _uid,
        name,
        selectedDate,
        createdDate,
        List.generate(3, (index) {
          return "something";
        }));

    Firestore.instance
        .collection("fermi")
        .document()
        .setData(fermi.toMap())
        .whenComplete(() => Navigator.pop(context));
  }
}
