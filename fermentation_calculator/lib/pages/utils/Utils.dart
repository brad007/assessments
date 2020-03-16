import 'package:flutter/material.dart';

class Utils {
  static navigate(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
