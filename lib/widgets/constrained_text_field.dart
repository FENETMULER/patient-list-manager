import 'package:flutter/material.dart';

class ConstrainedTextField extends StatelessWidget {
  final String label;
  final bool isMultiline;
  const ConstrainedTextField({required this.label, required this.isMultiline});

  @override
  Widget build(BuildContext context) {
    final labelStyle =
        Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey);

    final floatingLabelStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(color: Theme.of(context).primaryColor);
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      width: 200.0,
      child: TextField(
        maxLines: isMultiline ? 5 : null,
        style: Theme.of(context).textTheme.labelMedium,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(width: 5.0, color: Colors.red),
          ),
          labelText: label,
          labelStyle: labelStyle,
          floatingLabelStyle: floatingLabelStyle,
        ),
      ),
    );
  }
}