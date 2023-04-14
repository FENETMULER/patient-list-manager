import 'package:flutter/material.dart';

import './widgets/sidebar.dart';
import './widgets/new_patient_button.dart';
import './pages/home_page.dart';
import './pages/patient_list.dart';
import './widgets/update_or_register_patient.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var pageToDisplay = 1; // 1 -> HomePage, 2 -> PatientList
  void changePage(pageNumber) {
    setState(() {
      pageToDisplay = pageNumber;
    });
  }

  void displayRegistrationDialog(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return UpdateOrRegisterPatient();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NewPatientButton(onPressed: () {
        displayRegistrationDialog(context);
      }),
      body: Row(
        children: [
          Expanded(
              child: Sidebar(
                  changePage: changePage, pageToDisplay: pageToDisplay)),
          Expanded(
            flex: 3,
            child: pageToDisplay == 1 ? HomePage() : PatientList(),
          ),
        ],
      ),
    );
  }
}