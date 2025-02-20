import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelaMovimentacao extends StatefulWidget {
  const TelaMovimentacao({super.key});

  @override
  State<TelaMovimentacao> createState() => _TelaMovimentacaoState();
}

class _TelaMovimentacaoState extends State<TelaMovimentacao> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> movimentacoes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _buscarMovimentacoes();
  }

  Future<void> _buscarMovimentacoes() async {
    final response = await supabase.from('tb_movimentacao_estoque').select('''
      moves_id, tipo_movimentacao, moves_quantidade, moves_tipo_quantidade, moves_data, moves_observacao,
      tb_produto(nome), tb_funcionario(nome)
    ''').order('moves_data', ascending: false);

    setState(() {
      movimentacoes = List<Map<String, dynamic>>.from(response);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movimentações de Estoque"),
        backgroundColor: const Color(0xFF0A6D92),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : movimentacoes.isEmpty
              ? const Center(child: Text("Nenhuma movimentação registrada."))
              : ListView.builder(
                  itemCount: movimentacoes.length,
                  itemBuilder: (context, index) {
                    final movimentacao = movimentacoes[index];
                    return ListTile(
                      title: Text(
                        "${movimentacao['tb_produto']['nome']} - ${movimentacao['tipo_movimentacao']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: movimentacao['tipo_movimentacao'] == 'Entrada'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Funcionário: ${movimentacao['tb_funcionario']['nome']}"),
                          Text("Quantidade: ${movimentacao['moves_quantidade']}"),
                          Text("Tipo Quantidade: ${movimentacao['moves_tipo_quantidade']}"),
                          Text("Data: ${movimentacao['moves_data']}"),
                          if (movimentacao['moves_observacao'] != null)
                            Text("Obs: ${movimentacao['moves_observacao']}"),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aqui você pode abrir uma tela para adicionar movimentações manualmente
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
