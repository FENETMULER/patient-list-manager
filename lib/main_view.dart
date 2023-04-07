import 'package:flutter/material.dart';

import './widgets/sidebar.dart';
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
