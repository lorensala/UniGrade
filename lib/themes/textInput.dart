import 'package:flutter/material.dart';

class TextInputStyle extends StatelessWidget {
  final String name;
  const TextInputStyle({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100])),
      ),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: name,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
