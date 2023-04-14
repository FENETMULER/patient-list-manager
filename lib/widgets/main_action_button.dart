import 'package:flutter/material.dart';

class MainActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const MainActionButton({required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
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
