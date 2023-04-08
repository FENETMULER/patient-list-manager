import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import './main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: 'Patient Management',
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  windowManager.setResizable(false);
  windowManager.setMaximizable(false);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFBCE3EC),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              color: Color(0xff0085FF),
              fontWeight: FontWeight.bold,
              fontSize: 39.0,
              letterSpacing: -0.3),
          labelLarge: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.0),
          bodySmall: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        primaryColor: const Color(0xff0085FF),
        disabledColor: Colors.transparent, // for an unselected SidebarTile
        hoverColor: const Color.fromARGB(255, 148, 221, 255),
      ),
      home: MainView(),
    );
  }
}
