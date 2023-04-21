import 'dart:ui';

import 'package:flutter/material.dart';
import '../cancel_button.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main_action_button.dart';
import '../../services/patient_services.dart';
import './success.dart';
import '../../utils/ui_helpers.dart';
import '../../providers/patients_providers.dart';

class DeleteAlert extends ConsumerStatefulWidget {
  final mongodb.ObjectId objectId;
  const DeleteAlert({required this.objectId, super.key});

  @override
  ConsumerState<DeleteAlert> createState() => _DeleteAlertState();
}

class _DeleteAlertState extends ConsumerState<DeleteAlert> {
  void deletePatient(context) async {
    await dbDeletePatient(widget.objectId);
    // TODO: handle delete errors
    ref.refresh(recentPatientsProvider);

    await displaySuccessModal(Operation.deleted, context);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: const Text('Are You Sure?'),
        content: const Text(
            'Are you sure you want to delete this patient record? This action is irreversible!'),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,
        contentTextStyle:
            Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20.0),
        actionsPadding:
            const EdgeInsets.only(top: 25, bottom: 20.0, right: 20.0),
        titlePadding: const EdgeInsets.only(top: 30.0, left: 30.0),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        actions: [
          const CancelButton(),
          MainActionButton(
            onPressed: () {
              deletePatient(context);
            },
            title: 'DELETE',
            backgroundColor: Theme.of(context).colorScheme.error,
          )
        ],
      ),
    );
  }
}
