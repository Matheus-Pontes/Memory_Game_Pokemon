import 'package:flutter/material.dart';

Widget cardBack() {
  return Container(
    key: const ValueKey('back'),
    child: Center(child: Image.asset('assets/images/poke_ball.png')),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}