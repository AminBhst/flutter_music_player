import 'package:flutter/material.dart';

class SingleLineDragHandle extends StatelessWidget {
  final double width;

  const SingleLineDragHandle({this.width = 30, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
      ),
    );
  }
}
