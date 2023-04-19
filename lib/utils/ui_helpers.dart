import 'package:flutter/material.dart';
import '../widgets/modals/success.dart';

Future<void> displaySuccessModal(operation, context) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Success(operation: operation);
      });

  await Future.delayed(const Duration(seconds: 3), () {
    Navigator.pop(context);
  });
}
