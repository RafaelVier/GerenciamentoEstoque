import 'package:flutter/material.dart';

class TelaFornecedores extends StatefulWidget {
  const TelaFornecedores({super.key});

  @override
  State<TelaFornecedores> createState() => _TelaFornecedoresState();
}

class _TelaFornecedoresState extends State<TelaFornecedores> {
  final List<Map<String, String>> _fornecedores = [
    {'nome': 'Fornecedor A', 'telefone': '(11) 99999-9999', 'email': 'a@email.com'},
    {'nome': 'Fornecedor B', 'telefone': '(21) 88888-8888', 'email': 'b@email.com'},
  ];

  void _mostrarDetalhesFornecedor(Map<String, String> fornecedor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(fornecedor['nome']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Telefone: ${fornecedor['telefone']}'),
              Text('Email: ${fornecedor['email']}'),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Fechar")),
          ],
        );
      },
    );
  }

  void _adicionarFornecedor() {
    setState(() {
      _fornecedores.add({
        'nome': 'Novo Fornecedor',
        'telefone': '(00) 00000-0000',
        'email': 'novo@email.com',
      });
    });
  }

  void _removerFornecedor(int index) {
    setState(() {
      _fornecedores.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fornecedores"),
        backgroundColor: const Color(0xFF0A6D92),
      ),
      body: ListView.builder(
        itemCount: _fornecedores.length,
        itemBuilder: (context, index) {
          final fornecedor = _fornecedores[index];
          return ListTile(
            title: Text(fornecedor['nome']!),
            subtitle: Text(fornecedor['telefone']!),
            onTap: () => _mostrarDetalhesFornecedor(fornecedor),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removerFornecedor(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarFornecedor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
