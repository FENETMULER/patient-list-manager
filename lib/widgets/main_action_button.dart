import 'package:flutter/material.dart';

class MainActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const MainActionButton({required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ));
  }
}
