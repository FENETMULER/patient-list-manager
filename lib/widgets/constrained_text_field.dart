import 'package:flutter/material.dart';

class ConstrainedTextField extends StatelessWidget {
  final String label;
  final bool isMultiline;
  final String? Function(String?) validator;
  const ConstrainedTextField(
      {required this.label,
      required this.isMultiline,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      width: 200.0,
      child: TextFormField(
        validator: validator,
        maxLines: isMultiline ? 5 : null,
        style: Theme.of(context).textTheme.labelMedium,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(width: 5.0, color: Colors.red),
          ),
          labelText: label,
          labelStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.grey),
          floatingLabelStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
