import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelaRelatorios extends StatefulWidget {
  const TelaRelatorios({super.key}); 

  @override
  State<TelaRelatorios> createState() => _TelaRelatoriosState();
}

class _TelaRelatoriosState extends State<TelaRelatorios> {
  final supabase = Supabase.instance.client;

  List<Map<String, dynamic>> produtosBaixos = [];
  List<Map<String, dynamic>> movimentacoes = [];

  DateTime dataInicio = DateTime.now().subtract(const Duration(days: 7));
  DateTime dataFim = DateTime.now();

  @override
  void initState() {
    super.initState();
    carregarRelatorios();
  }

  Future<void> carregarRelatorios() async {
    await buscarProdutosBaixos();
    await buscarMovimentacoes();
  }

  Future<void> buscarProdutosBaixos() async {
    final response = await supabase
        .from('tb_produto')
        .select()
        .eq('ativo', true)
        .lte('quantidadeEstoque', 5) // Produtos com 5 ou menos no estoque
        .order('quantidadeEstoque', ascending: true);

    setState(() {
      produtosBaixos = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> buscarMovimentacoes() async {
    final response = await supabase
        .from('tb_movimentacao_estoque')
        .select('*, tb_produto(nome), tb_funcionario(nome)')
        .gte('moves_data', dataInicio.toIso8601String())
        .lte('moves_data', dataFim.toIso8601String())
        .order('moves_data', ascending: false);

    setState(() {
      movimentacoes = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> selecionarDataInicio(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dataInicio,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != dataInicio) {
      setState(() {
        dataInicio = picked;
      });
      buscarMovimentacoes();
    }
  }

  Future<void> selecionarDataFim(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dataFim,
      firstDate: dataInicio,
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != dataFim) {
      setState(() {
        dataFim = picked;
      });
      buscarMovimentacoes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Relatórios de Estoque'),
        backgroundColor: const Color(0xFF0A6D92),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Produtos com Baixo Estoque', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            produtosBaixos.isEmpty
                ? const Text('Nenhum produto com baixa quantidade.', style: TextStyle(color: Colors.grey))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: produtosBaixos.length,
                    itemBuilder: (context, index) {
                      final produto = produtosBaixos[index];
                      return ListTile(
                        title: Text(produto['nome']),
                        subtitle: Text('Quantidade: ${produto['quantidadeEstoque']}'),
                        trailing: const Icon(Icons.warning, color: Colors.orange),
                      );
                    },
                  ),
            const SizedBox(height: 16),
            const Divider(),
            const Text('Movimentações', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => selecionarDataInicio(context),
                  child: Text('Início: ${dataInicio.toLocal()}'.split(' ')[0]),
                ),
                TextButton(
                  onPressed: () => selecionarDataFim(context),
                  child: Text('Fim: ${dataFim.toLocal()}'.split(' ')[0]),
                ),
              ],
            ),
            movimentacoes.isEmpty
                ? const Text('Nenhuma movimentação encontrada.', style: TextStyle(color: Colors.grey))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: movimentacoes.length,
                    itemBuilder: (context, index) {
                      final movimentacao = movimentacoes[index];
                      return ListTile(
                        title: Text('${movimentacao['tipo_movimentacao']} - ${movimentacao['tb_produto']['nome']}'),
                        subtitle: Text(
                          'Quantidade: ${movimentacao['moves_quantidade']}\n'
                          'Funcionário: ${movimentacao['tb_funcionario']['nome']}\n'
                          'Data: ${DateTime.parse(movimentacao['moves_data']).toLocal()}',
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
