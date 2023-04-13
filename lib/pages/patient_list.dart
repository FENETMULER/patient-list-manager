import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/patient_card.dart';
import '../widgets/no_record_found.dart';

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  final TextEditingController searchController = TextEditingController();
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
            Text('Search Patient',
                style: Theme.of(context).textTheme.headlineLarge),

            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 10.0, 300.0, 0.0),
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 23,
                      offset: Offset(4, 4),
                      color: Color.fromARGB(70, 0, 0, 0))
                ]),
                child: TextField(
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.grey[600]),
                  controller: searchController,
                  decoration: InputDecoration(
                    hoverColor: Theme.of(context).disabledColor,
                    contentPadding: const EdgeInsets.all(20.0),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.0),
                      child: Icon(FontAwesomeIcons.magnifyingGlass),
                    ),
                    hintText: 'Name or Phone Number ...',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30.0),
            // Recents
            Text(
              'Results',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            const SizedBox(height: 15.0),
            // Recently Registered
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
