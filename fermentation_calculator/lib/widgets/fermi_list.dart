import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fermentation_calculator/pages/view_fermi/view_fermi_page.dart';
import 'package:fermentation_calculator/widgets/fermi_item.dart';
import 'package:flutter/material.dart';

class FermiList extends StatelessWidget {
  final String uid;

  FermiList(this.uid);

  @override
  Widget build(BuildContext context) {
    if (uid == null) return Center(child: CircularProgressIndicator());
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("fermi")
          .where("user", isEqualTo: uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print("error: ${snapshot.error}");
          return Text("Error: ${snapshot.error}");
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            var documents = snapshot.data.documents;
            documents.sort((a, b) {
              return (a["dateStarted"] as int) - (b["dateStarted"] as int);
            });
            return ListView(
              children: documents.map((DocumentSnapshot document) {
                return new InkWell(
                  child: FermiItem(document),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              print("date: ${document.data}");
                              return ViewFermiPage(document['name'], document);
                            }));
                  },
                );
              }).toList(),
            );
        }
      },
    );
  }
}
