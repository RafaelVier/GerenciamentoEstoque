import 'package:flutter/material.dart';

class TelaCrudEstoque extends StatelessWidget {
  const TelaCrudEstoque({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gerenciar Estoque")),
      body: const Center(child: Text("Tela de CRUD do Estoque")),
    );
  }
}
