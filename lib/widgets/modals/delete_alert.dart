import 'package:flutter/material.dart';
import '../cancel_button.dart';
import '../main_action_button.dart';

class DeleteAlert extends StatelessWidget {
  const DeleteAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Text('Are You Sure?'),
      content: const Text(
          'Are you sure you want to delete this patient record? This action is irreversible!'),
      titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      contentTextStyle:
          Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20.0),
      actionsPadding: const EdgeInsets.only(top: 25, bottom: 20.0, right: 20.0),
      titlePadding: const EdgeInsets.only(top: 30.0, left: 30.0),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      actions: [
        const CancelButton(),
        MainActionButton(
          onPressed: () {},
          title: 'DELETE',
          backgroundColor: Theme.of(context).colorScheme.error,
        )
      ],
    );
  }
}
