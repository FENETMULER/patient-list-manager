import 'package:flutter/material.dart';
import '../widgets/modals/success.dart';
import '../widgets/modals/patient_details.dart';

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

void displayPatientDetailsModal(context, patient) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PatientDetails(patient: patient);
      });
}
