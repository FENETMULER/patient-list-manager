import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/patient_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String getCurrentDate() {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(today);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Container(
        padding: const EdgeInsets.only(left: 65.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge),

            // Date
            Text(
              getCurrentDate(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 128, 128, 128),
                  ),
            ),
            const SizedBox(height: 30.0),
            // Recents
            Text(
              'Recently Registered',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            const SizedBox(height: 15.0),
            // Recently Registered
            Column(
              children: [
                PatientCard(),
                PatientCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
