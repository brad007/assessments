import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fermentation_calculator/pages/camera/camera_screen.dart';
import 'package:fermentation_calculator/widgets/fermi_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewFermiPage extends StatefulWidget {
  String title;
  DocumentSnapshot document;

  ViewFermiPage(this.title, this.document, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewFermiState();
}

class _ViewFermiState extends State<ViewFermiPage> {
  bool _dialVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title.toUpperCase()),
        ),
        body: Column(
          children: <Widget>[FermiItem(widget.document)],
        ),
        floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: _dialVisible,
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.camera_alt),
                backgroundColor: Theme.of(context).accentColor,
                label: 'CAPTURE',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => _capture(context)),
            SpeedDialChild(
              child: Icon(Icons.edit),
              backgroundColor: Theme.of(context).accentColor,
              label: 'EDIT',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => _edit(context),
            ),
            SpeedDialChild(
              child: Icon(Icons.delete),
              backgroundColor: Theme.of(context).accentColor,
              label: 'DELETE',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: _delete,
            ),
          ],
        ));
  }

  _delete() {
    Firestore.instance
        .collection("fermi")
        .document(widget.document.documentID)
        .delete()
        .then((value) => Navigator.pop(context));
  }

  _edit(BuildContext context) {
    _showToast();
  }

  _capture(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CameraScreen(widget.document)));
  }

  _showToast() {
    Fluttertoast.showToast(
        msg: "Not implemented",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
