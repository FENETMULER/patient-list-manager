import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'CANCEL',
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
