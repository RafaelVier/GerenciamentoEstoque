import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelaCategorias extends StatefulWidget {
  const TelaCategorias({super.key});

  @override
  State<TelaCategorias> createState() => _TelaCategoriasState();
}

class _TelaCategoriasState extends State<TelaCategorias> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> categorias = [];

  @override
  void initState() {
    super.initState();
    _carregarCategorias();
  }

  Future<void> _carregarCategorias() async {
    final response = await supabase.from('tb_categoria').select();
    setState(() {
      categorias = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> _adicionarCategoria(String nome, String descricao) async {
    await supabase.from('tb_categoria').insert({'nome': nome, 'descricao': descricao});
    _carregarCategorias();
  }

  Future<void> _editarCategoria(int id, String nome, String descricao) async {
    await supabase.from('tb_categoria').update({'nome': nome, 'descricao': descricao}).match({'categoria_id': id});
    _carregarCategorias();
  }

  Future<void> excluirCategoria(int id) async {
    await supabase.from('tb_categoria').delete().eq('categoria_id', id);
    _carregarCategorias();
  }

  void _mostrarDialogoCategoria({int? id, String? nome, String? descricao}) {
    final TextEditingController nomeController = TextEditingController(text: nome);
    final TextEditingController descricaoController = TextEditingController(text: descricao);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id == null ? 'Adicionar Categoria' : 'Editar Categoria'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (id == null) {
                  _adicionarCategoria(nomeController.text, descricaoController.text);
                } else {
                  _editarCategoria(id, nomeController.text, descricaoController.text);
                }
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: categorias.isEmpty
          ? const Center(child: Text('Não há nenhuma categoria cadastrada.'))
          : ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                return ListTile(
                  title: Text(categoria['nome']),
                  subtitle: Text(categoria['descricao'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _mostrarDialogoCategoria(
                          id: categoria['categoria_id'],
                          nome: categoria['nome'],
                          descricao: categoria['descricao'],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          excluirCategoria(categoria['categoria_id']); // O ID já está como int
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoCategoria(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
