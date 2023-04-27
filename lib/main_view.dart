import 'package:flutter/material.dart';

import './pages/home_page.dart';
import './pages/patient_list.dart';
import './widgets/sidebar.dart';
import './widgets/new_patient_button.dart';
import 'widgets/modals/update_or_register_patient.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var _pageToDisplay = 1; // 1 -> HomePage, 2 -> PatientList
  void _changePage(pageNumber) {
    setState(() {
      _pageToDisplay = pageNumber;
    });
  }

  void _displayRegistrationDialog(context) {
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
        _displayRegistrationDialog(context);
      }),
      body: Row(
        children: [
          Expanded(
              child: Sidebar(
                  changePage: _changePage, pageToDisplay: _pageToDisplay)),
          Expanded(
            flex: 3,
            child: _pageToDisplay == 1 ? HomePage() : PatientList(),
          ),
        ],
      ),
    );
  }
}
