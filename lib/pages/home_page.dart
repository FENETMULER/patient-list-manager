import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/patient_card.dart';
import '../models/patient.dart';
import '../services/patient_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _getCurrentDate() {
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
              _getCurrentDate(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 128, 128, 128),
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
            FutureBuilder(
              future:
                  dbGetRecentPatients(), // getting 5 recently registered patients.
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                      children: snapshot.data!
                          .sublist(snapshot.data!.length >= 5
                              ? 4
                              : snapshot.data!
                                  .length) // only show a maximum of 5 items if list length is >= 5 else, just show all available elements
                          .map((patientMap) => PatientCard(
                                Patient(
                                  firstName: patientMap['firstName'],
                                  lastName: patientMap['lastName'],
                                  age: patientMap['age'],
                                  sex: patientMap['sex'],
                                  phoneNumber: patientMap['phoneNumber'],
                                  registeredOn: patientMap['registeredOn'],
                                ),
                              ))
                          .toList());
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
