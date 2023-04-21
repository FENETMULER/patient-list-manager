import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Operation {
  // 'Action' is already defined in flutter
  registered,
  updated,
  deleted,
}

class Success extends StatelessWidget {
  final Operation operation;
  const Success({required this.operation, super.key});

  @override
  Widget build(BuildContext context) {
    String title;
    if (operation == Operation.registered) {
      title = 'Patient Successfully Registered!';
    } else if (operation == Operation.updated) {
      title = 'Record Updated!';
    } else {
      title = 'Record Deleted!';
    }
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          height: 200,
          width: operation == Operation.registered ? 450 : 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 25.0),
              const Icon(FontAwesomeIcons.solidCircleCheck,
                  color: Color(0xFF0FD682), size: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
