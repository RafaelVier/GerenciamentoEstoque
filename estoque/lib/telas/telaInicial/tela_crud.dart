import 'package:flutter/material.dart';

class TelaCrudEstoque extends StatefulWidget {
  const TelaCrudEstoque({super.key});

  @override
  State<TelaCrudEstoque> createState() => _TelaCrudEstoqueState();
}

class _TelaCrudEstoqueState extends State<TelaCrudEstoque> {
  final List<Map<String, dynamic>> _estoque = [
    {'nome': 'Produto 1', 'quantidade': 10},
    {'nome': 'Produto 2', 'quantidade': 5},
    {'nome': 'Produto 3', 'quantidade': 8},
  ];

  void _adicionarItem() {
    // Aqui você pode adicionar lógica para exibir um formulário de cadastro
    setState(() {
      _estoque.add({'nome': 'Novo Produto', 'quantidade': 1});
    });
  }

  void _editarItem(int index) {
    // Aqui você pode abrir um formulário de edição
    setState(() {
      _estoque[index]['quantidade'] += 1; // Exemplo: adiciona +1 unidade
    });
  }

  void _removerItem(int index) {
    setState(() {
      _estoque.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Estoque"),
        backgroundColor: const Color(0xFF0A6D92),
      ),
      body: ListView.builder(
        itemCount: _estoque.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(_estoque[index]['nome']),
              subtitle: Text("Quantidade: ${_estoque[index]['quantidade']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editarItem(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removerItem(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
