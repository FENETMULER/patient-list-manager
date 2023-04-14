import 'package:flutter/material.dart';

class MainActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color backgroundColor;

  const MainActionButton(
      {required this.onPressed,
      required this.title,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          elevation: MaterialStateProperty.resolveWith(((states) {
            if (states.contains(MaterialState.hovered)) {
              return 10.0;
            }
            return 3.0;
          })),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Text(title),
        ));
  }
}
