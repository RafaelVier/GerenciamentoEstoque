import 'package:flutter/material.dart';

class TelaMovimentacao extends StatefulWidget {
  const TelaMovimentacao({super.key});

  @override
  State<TelaMovimentacao> createState() => _TelaMovimentacaoState();
}

class _TelaMovimentacaoState extends State<TelaMovimentacao> {
  final List<Map<String, dynamic>> _movimentacoes = [];

  void _registrarMovimentacao() {
    final TextEditingController produtoController = TextEditingController();
    final TextEditingController quantidadeController = TextEditingController();
    String tipoMovimentacao = "Entrada";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Registrar Movimentação"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: produtoController,
                decoration: const InputDecoration(labelText: "Produto"),
              ),
              TextField(
                controller: quantidadeController,
                decoration: const InputDecoration(labelText: "Quantidade"),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                value: tipoMovimentacao,
                items: const [
                  DropdownMenuItem(value: "Entrada", child: Text("Entrada")),
                  DropdownMenuItem(value: "Saída", child: Text("Saída")),
                ],
                onChanged: (value) {
                  setState(() {
                    tipoMovimentacao = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _movimentacoes.add({
                    "produto": produtoController.text,
                    "quantidade": int.tryParse(quantidadeController.text) ?? 0,
                    "tipo": tipoMovimentacao,
                  });
                });
                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  void _removerMovimentacao(int index) {
    setState(() {
      _movimentacoes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movimentação de Estoque"),
        backgroundColor: const Color(0xFF0A6D92),
      ),
      body: _movimentacoes.isEmpty
          ? const Center(child: Text("Nenhuma movimentação registrada."))
          : ListView.builder(
              itemCount: _movimentacoes.length,
              itemBuilder: (context, index) {
                final mov = _movimentacoes[index];
                return ListTile(
                  title: Text(mov["produto"]),
                  subtitle: Text("Quantidade: ${mov["quantidade"]}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(mov["tipo"], style: TextStyle(
                        color: mov["tipo"] == "Entrada" ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      )),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removerMovimentacao(index),
                      ),
                    ],
                  ),
                );
              },
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: _registrarMovimentacao,
          child: const Icon(Icons.add),
      ),
    );
  }
}
