import 'package:flutter/material.dart';

class TelaMovimentacao extends StatelessWidget {
  const TelaMovimentacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movimentação")),
      body: const Center(child: Text("Tela de movimentação")),
    );
  }
}
