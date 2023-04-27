import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/patient_card.dart';
import '../models/patient.dart';

import '../providers/patients_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _getCurrentDate() {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(today);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final recentPatientsList = ref.watch(recentPatientsProvider);
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

            recentPatientsList.when(
              data: (data) {
                return Column(
                    children: data
                        .map(
                          (patientMap) => PatientCard(
                            patient: Patient(
                                id: patientMap['_id'],
                                firstName: patientMap['firstName'],
                                lastName: patientMap['lastName'],
                                age: patientMap['age'],
                                sex: patientMap['sex'],
                                phoneNumber: patientMap['phoneNumber'],
                                registeredOn: patientMap['registeredOn'],
                                houseNumber: patientMap['houseNumber'],
                                district: patientMap['district'],
                                subCity: patientMap['subCity'],
                                diagnosis: patientMap['diagnosis']),
                          )
                              .animate()
                              .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                              .moveY(
                                  duration: 400.ms,
                                  begin: 70,
                                  end: 0,
                                  curve: Curves.easeOut),
                        )
                        .toList());
              },
              error: (error, stackTrace) => Text(
                'Error: $error',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              loading: () => const CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
