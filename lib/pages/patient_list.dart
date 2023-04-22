import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient_list_management_system/providers/search_query_provider.dart';

import '../widgets/patient_card.dart';
import '../widgets/no_record_found.dart';
import '../services/patient_services.dart';
import '../models/patient.dart';
import '../providers/search_results_provider.dart';

class PatientList extends ConsumerStatefulWidget {
  const PatientList({super.key});

  @override
  ConsumerState<PatientList> createState() => _PatientListState();
}

class _PatientListState extends ConsumerState<PatientList> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var searchResults = ref.watch(searchResultsProvider);

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
                  onChanged: (value) {
                    ref
                        .read(searchResultsProvider.notifier)
                        .newSearchResults(value);
                    ref
                        .read(searchQueryProvider.notifier)
                        .changeSearchQuery(value);
                  },
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
            FutureBuilder(
              future: searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error!');
                  } else {
                    final data = snapshot.data;
                    final searchQuery = ref.read(searchQueryProvider);
                    final numberOfPatients = data!.length;
                    return Text(
                      searchQuery.isEmpty
                          ? 'All Patients ($numberOfPatients)'
                          : 'Results ($numberOfPatients)',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),

            const SizedBox(height: 15.0),
            // Recently Registered
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: FutureBuilder(
                    future:
                        searchResults, // getting 5 recently registered patients.
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text("Couldn't Load Records",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0));
                        } else {
                          return Column(
                              children: snapshot.data!
                                  .map((patientMap) => PatientCard(
                                        patient: Patient(
                                            id: patientMap['_id'],
                                            firstName: patientMap['firstName'],
                                            lastName: patientMap['lastName'],
                                            age: patientMap['age'],
                                            sex: patientMap['sex'],
                                            phoneNumber:
                                                patientMap['phoneNumber'],
                                            registeredOn:
                                                patientMap['registeredOn'],
                                            houseNumber:
                                                patientMap['houseNumber'],
                                            district: patientMap['district'],
                                            subCity: patientMap['subCity'],
                                            diagnosis: patientMap['diagnosis']),
                                      ))
                                  .toList());
                        }
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
