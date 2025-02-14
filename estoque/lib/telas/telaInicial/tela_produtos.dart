import 'package:estoque/Manager/Model/pessoa/Funcionario.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelaProdutos extends StatefulWidget {
  const TelaProdutos({super.key});

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> produtos = [];
  List<Map<String, dynamic>> categorias = [];
  List<Map<String, dynamic>> fornecedores = [];
  
  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final produtosResponse = await supabase.from('tb_produto').select();
    final categoriasResponse = await supabase.from('tb_categoria').select();
    final fornecedoresResponse = await supabase.from('tb_fornecedor').select();

    setState(() {
      produtos = List<Map<String, dynamic>>.from(produtosResponse);
      categorias = List<Map<String, dynamic>>.from(categoriasResponse);
      fornecedores = List<Map<String, dynamic>>.from(fornecedoresResponse);
    });
  }

  void abrirPopupProduto({Map<String, dynamic>? produto}) {
    final TextEditingController nomeController = TextEditingController(text: produto?['nome'] ?? '');
    final TextEditingController codigoBarrasController = TextEditingController(text: produto?['codigo_barras'] ?? '');
    final TextEditingController precoCustoController = TextEditingController(text: produto?['preco_custo']?.toString() ?? '');
    final TextEditingController precoVendaController = TextEditingController(text: produto?['preco_venda']?.toString() ?? '');
    final TextEditingController quantidadeController = TextEditingController(text: produto?['quantidade']?.toString() ?? '');
    
    int? categoriaSelecionada = produto?['categoria_id'];
    int? fornecedorSelecionado = produto?['fornecedor_id'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(produto == null ? 'Adicionar Produto' : 'Editar Produto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
                TextField(controller: codigoBarrasController, decoration: const InputDecoration(labelText: 'Código de Barras')),
                TextField(controller: precoCustoController, decoration: const InputDecoration(labelText: 'Preço de Custo'), keyboardType: TextInputType.number),
                TextField(controller: precoVendaController, decoration: const InputDecoration(labelText: 'Preço de Venda'), keyboardType: TextInputType.number),
                TextField(controller: quantidadeController, decoration: const InputDecoration(labelText: 'Quantidade'), keyboardType: TextInputType.number),
                
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  value: categoriaSelecionada,
                  hint: const Text('Selecione a Categoria'),
                  items: categorias.map((categoria) {
                    return DropdownMenuItem<int>(
                      value: categoria['categoria_id'],
                      child: Text(categoria['nome']),
                    );
                  }).toList(),
                  onChanged: (value) => categoriaSelecionada = value,
                ),
                
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  value: fornecedorSelecionado,
                  hint: const Text('Selecione o Fornecedor'),
                  items: fornecedores.map((fornecedor) {
                    return DropdownMenuItem<int>(
                      value: fornecedor['fornecedor_id'],
                      child: Text(fornecedor['nome']),
                    );
                  }).toList(),
                  onChanged: (value) => fornecedorSelecionado = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () async {
                try {
                  final user = supabase.auth.currentUser;
                  String emailFuncionario = user!.email.toString();
                  final response = await supabase.from('tb_funcionario').select().eq('email', emailFuncionario).single();
                  int funcionarioId = response['funcionario_id'].parseInt();
                if (produto == null) {
                  final response = await supabase.from('tb_produto').insert({
                    'nome': nomeController.text,
                    'codigoBarras': codigoBarrasController.text,
                    'precoCusto': double.parse(precoCustoController.text),
                    'precoVenda': double.parse(precoVendaController.text),
                    'quantidadeEstoque': int.parse(quantidadeController.text),
                    'ativo': true,
                    'categoria_id': categoriaSelecionada,
                    'fornecedor_id': fornecedorSelecionado,
                  }).select().single();

                  int novoProdutoId = response['produto_id'];
                  final user = supabase.auth.currentUser;
                  String emailFuncionario = user!.email.toString();
                  final resp = await supabase.from('tb_funcionario').select().eq('email', emailFuncionario).single();
                  int funcionarioId = resp['funcionario_id'].parseInt();

                  // Registrar movimentação de entrada
                  await supabase.from('tb_movimentacao_estoque').insert({
                    'tipo_movimentacao': 'Entrada',
                    'moves_quantidade': int.parse(quantidadeController.text),
                    'moves_tipo_quantidade': 'Unidade',
                    'moves_data': DateTime.now().toIso8601String(),
                    'moves_observacao': 'Novo produto adicionado',
                    'moves_produto': novoProdutoId,
                    'moves_funcionario': funcionarioId // Substituir pelo ID do funcionário logado
                  });
                
                } else {
                  await supabase.from('tb_produto').update({
                    'nome': nomeController.text,
                    'codigoBarras': codigoBarrasController.text,
                    'precoCusto': double.parse(precoCustoController.text),
                    'precoVenda': double.parse(precoVendaController.text),
                    'quantidadeEstoque': int.parse(quantidadeController.text),
                    'categoria_id': categoriaSelecionada,
                    'fornecedor_id': fornecedorSelecionado,
                  }).eq('produto_id', produto['produto_id']);
                }
                carregarDados();
                Navigator.pop(context);
                } catch (e) {
                print("Erro ao adicionar produto e movimentação: $e");
              }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _excluirProduto(int produtoId, int quantidadeAtual) async {
    int quantidadeRemover = 0; // Valor padrão

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Remover Unidades"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Escolha quantas unidades deseja remover (máx: $quantidadeAtual)"),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  quantidadeRemover = int.tryParse(value) ?? 1;
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
              onPressed: () async {
                Navigator.pop(context);
                // Se a quantidade a remover for maior ou igual à quantidade atual, marcar como inativo
                if (quantidadeRemover >= quantidadeAtual) {
                  await supabase.from('tb_produto').update({
                    'quantidadeEstoque': 0,
                    'ativo': false, // Marca o produto como inativo
                  }).match({'produto_id': produtoId});
                } else {
                  await supabase.from('tb_produto').update({
                    'quantidadeEstoque': quantidadeAtual - quantidadeRemover
                  }).match({'produto_id': produtoId});
                }

                int funcionarioId;
                // Registrar movimentação de saída
                
                final user = supabase.auth.currentUser;
                String emailFuncionario = user!.email.toString();
                final response = await supabase.from('tb_funcionario').select().eq('email', emailFuncionario).single();
                funcionarioId = response['funcionario_id'].parseInt();
                 
                await supabase.from('tb_movimentacao_estoque').insert({
                  'tipo_movimentacao': 'Saída',
                  'moves_quantidade': quantidadeRemover,
                  'moves_tipo_quantidade': 'Unidade',
                  'moves_data': DateTime.now().toIso8601String(),
                  'moves_observacao': 'Venda simulada',
                  'moves_produto': produtoId,
                  'moves_funcionario': funcionarioId // Substituir pelo ID do funcionário logado
                });
                carregarDados();
              },
              child: const Text("Remover"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar Produtos')),
      body: produtos.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado'))
          : ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return Card(
                  child: ListTile(
                    title: Text(produto['nome']),
                    subtitle: Text('Código: ${produto['codigoBarras']} \nPreço: R\$${produto['precoVenda']} \nQuantidade: ${produto['quantidadeEstoque']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => abrirPopupProduto(produto: produto),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _excluirProduto(produto['produto_id'], produto['quantidadeEstoque']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => abrirPopupProduto(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
