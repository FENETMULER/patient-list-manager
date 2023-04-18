import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  const PatientCard({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 200.0, bottom: 10.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
            child: Row(children: [
              CircleAvatar(
                child: Text(patient.getInitial,
                    style: Theme.of(context).textTheme.labelLarge),
              ),
              const SizedBox(width: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${patient.firstName} ${patient.lastName}',
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      Icon(
                          patient.sex == 'Male'
                              ? FontAwesomeIcons.person
                              : FontAwesomeIcons.personDress,
                          size: 22.0),
                      const SizedBox(width: 5.0),
                      Text(patient.sex,
                          style: Theme.of(context).textTheme.labelSmall),
                      const SizedBox(width: 20.0),
                      Text(
                        patient.age.toString(),
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5.0),
                      Text('Years old',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  )
                ],
              ),
              const SizedBox(width: 200.0),
              Expanded(
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.phone, size: 18.0),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        patient.phoneNumber,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
