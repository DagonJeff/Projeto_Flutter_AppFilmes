import 'package:flutter/material.dart';
import 'package:myapp/views/auflisten_filme.dart';

main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 193, 52, 42),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 193, 52, 42),
          foregroundColor: Color.fromARGB(255, 235, 187, 56),
        ),

        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 173, 50, 41),
            iconTheme: IconThemeData(
              color: Color.fromARGB(255, 235, 187, 56),
            ),
            titleTextStyle: TextStyle(
              color: Color.fromARGB(255, 235, 187, 56),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ),
      home: const AuflistenFilme(),
    );
  }
}
