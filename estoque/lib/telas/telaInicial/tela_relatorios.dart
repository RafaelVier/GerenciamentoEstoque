import 'package:flutter/material.dart';

class TelaRelatorios extends StatelessWidget {
  const TelaRelatorios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Relatórios")),
      body: const Center(child: Text("Tela de Relatórios")),
    );
  }
}