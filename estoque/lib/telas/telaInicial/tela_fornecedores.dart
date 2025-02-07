import 'package:flutter/material.dart';

class TelaFornecedores extends StatelessWidget {
  const TelaFornecedores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fornecedores")),
      body: const Center(child: Text("Tela de Fornecedores")),
    );
  }
}