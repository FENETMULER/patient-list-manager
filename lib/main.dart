import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import './main_view.dart';
import './services/patient_services.dart';

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

  connectDb(); // connect to database
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
          headlineSmall: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(97, 97, 97, 1)),
          bodyLarge: TextStyle(
            fontSize: 18.0,
          ),
          labelLarge: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
          labelMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          labelSmall: TextStyle(fontSize: 14.0, letterSpacing: .7),
          bodySmall: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        primaryColor: const Color(0xff0085FF),
        disabledColor: Colors.transparent, // for an unselected SidebarTile
        hoverColor: const Color.fromARGB(255, 102, 207, 255),
      ),
      home: MainView(),
    );
  }
}
