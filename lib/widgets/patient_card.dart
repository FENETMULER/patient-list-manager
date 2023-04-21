import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/patient.dart';
import '../utils/ui_helpers.dart';

class PatientCard extends StatefulWidget {
  final Patient patient;

  const PatientCard({required this.patient});

  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  Color _backgroundColor = Colors.white;
  double _elevation = 7;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        displayPatientDetailsModal(context, widget.patient);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 200.0, bottom: 10.0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) {
            setState(() {
              _backgroundColor = const Color(0xFF81CFFF);
              _elevation = 15;
            });
          },
          onExit: (event) {
            setState(() {
              _backgroundColor = Colors.white;
              _elevation = 7;
            });
          },
          child: Card(
            color: _backgroundColor,
            elevation: _elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
              child: Row(children: [
                CircleAvatar(
                  child: Text(widget.patient.getInitial,
                      style: Theme.of(context).textTheme.labelLarge),
                ),
                const SizedBox(width: 30.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${widget.patient.firstName} ${widget.patient.lastName}',
                        style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 3.0),
                    Row(
                      children: [
                        Icon(
                            widget.patient.sex == 'Male'
                                ? FontAwesomeIcons.person
                                : FontAwesomeIcons.personDress,
                            size: 22.0),
                        const SizedBox(width: 5.0),
                        Text(widget.patient.sex,
                            style: Theme.of(context).textTheme.labelSmall),
                        const SizedBox(width: 20.0),
                        Text(
                          widget.patient.age.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
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
                          widget.patient.phoneNumber,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
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
      ),
    );
  }
}
