import 'package:estoque/telas/onboarding/tela_onboarding.dart';
import 'package:flutter/material.dart';
//import 'controller/pessoa/login.dart'; // Certifique-se de que o caminho está correto


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelaOnboarding(),
    );
  }
}