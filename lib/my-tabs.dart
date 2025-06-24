import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTabs extends StatelessWidget {
  final Color color;
  final String text;
  const MyTabs({Key? key, required this.color, required this.text})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        this.text,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
