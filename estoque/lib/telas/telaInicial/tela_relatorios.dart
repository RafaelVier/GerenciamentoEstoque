import 'package:flutter/material.dart';

class TelaRelatorios extends StatefulWidget {
  const TelaRelatorios({super.key});

  @override
  State<TelaRelatorios> createState() => _TelaRelatoriosState();
}

class _TelaRelatoriosState extends State<TelaRelatorios> {
  final List<Map<String, dynamic>> _produtosBaixa = [
    {"nome": "Teclado", "quantidade": 3},
    {"nome": "Mouse", "quantidade": 2},
    {"nome": "Monitor", "quantidade": 4},
  ];

  final List<Map<String, dynamic>> _movimentacoes = [
    {"produto": "Teclado", "quantidade": 10, "tipo": "Entrada", "data": "2025-02-01"},
    {"produto": "Mouse", "quantidade": 5, "tipo": "Saída", "data": "2025-02-03"},
    {"produto": "Monitor", "quantidade": 2, "tipo": "Saída", "data": "2025-02-05"},
  ];

  String _periodoSelecionado = "Últimos 7 dias";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Relatórios de Estoque"),
        backgroundColor: const Color(0xFF0A6D92),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📉 Produtos com baixa quantidade:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _produtosBaixa.isEmpty
                ? const Text("Nenhum produto com baixa quantidade.")
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _produtosBaixa.length,
                    itemBuilder: (context, index) {
                      final produto = _produtosBaixa[index];
                      return ListTile(
                        title: Text(produto["nome"]),
                        trailing: Text(
                          "Qtd: ${produto["quantidade"]}",
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 20),
            const Text(
              "📊 Movimentações por período:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _periodoSelecionado,
              items: const [
                DropdownMenuItem(value: "Últimos 7 dias", child: Text("Últimos 7 dias")),
                DropdownMenuItem(value: "Últimos 30 dias", child: Text("Últimos 30 dias")),
                DropdownMenuItem(value: "Últimos 6 meses", child: Text("Últimos 6 meses")),
              ],
              onChanged: (value) {
                setState(() {
                  _periodoSelecionado = value!;
                });
              },
            ),
            Expanded(
              child: _movimentacoes.isEmpty
                  ? const Center(child: Text("Nenhuma movimentação registrada."))
                  : ListView.builder(
                      itemCount: _movimentacoes.length,
                      itemBuilder: (context, index) {
                        final mov = _movimentacoes[index];
                        return ListTile(
                          title: Text(mov["produto"]),
                          subtitle: Text("Data: ${mov["data"]} | Quantidade: ${mov["quantidade"]}"),
                          trailing: Text(
                            mov["tipo"],
                            style: TextStyle(
                              color: mov["tipo"] == "Entrada" ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
