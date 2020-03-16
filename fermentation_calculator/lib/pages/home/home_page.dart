import 'package:fermentation_calculator/pages/add_fermentation/add_fermentation_page.dart';
import 'package:fermentation_calculator/pages/res/strings.dart';
import 'package:fermentation_calculator/pages/utils/Utils.dart';
import 'package:fermentation_calculator/widgets/fermi_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
      appBar: AppBar(
        title: Text(Strings.APP_NAME),
        actions: <Widget>[],
      ),
      body: FermiList(_uid),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Utils.navigate(context, AddFermentationPage());
        },
        icon: Icon(Icons.add),
        label: Text("ADD"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
