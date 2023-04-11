import 'package:flutter/material.dart';

class NoRecordFound extends StatelessWidget {
  const NoRecordFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(40.0, 25.0, 300, 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Text(
        'No Record Found ...',
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Colors.grey[600]),
      ),
    );
  }
}
