import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  static const _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffffcb05),
      Color(0xFF1e3a5f),
    ],
  );

  final Widget child;

  const BaseLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: _gradient,
        ),
        child: child,
      ),
    );
  }
}
