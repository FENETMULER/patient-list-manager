import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 200.0, bottom: 10.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          elevation: 4,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
            child: Row(children: [
              CircleAvatar(
                child: Text('A', style: Theme.of(context).textTheme.labelLarge),
              ),
              const SizedBox(width: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Abebe Kebede',
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.person, size: 20.0),
                      const SizedBox(width: 5.0),
                      Text('Male',
                          style: Theme.of(context).textTheme.labelSmall),
                      const SizedBox(width: 20.0),
                      Text(
                        '56',
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
              Row(
                children: [
                  const Icon(FontAwesomeIcons.phone, size: 20.0),
                  const SizedBox(width: 10.0),
                  Text('0938192033',
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
