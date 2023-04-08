import 'dart:ffi';

import 'package:flutter/material.dart';

import './widgets/sidebar.dart';
import './widgets/new_patient_button.dart';
import './pages/home_page.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NewPatientButton(),
      body: Row(
        children: [
          Expanded(child: Sidebar()),
          Expanded(
            flex: 3,
            child: HomePage(),
          ),
        ],
      ),
    );
  }
}
