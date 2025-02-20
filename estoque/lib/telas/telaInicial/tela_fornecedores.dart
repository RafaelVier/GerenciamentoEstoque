import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelaFornecedores extends StatefulWidget {
  const TelaFornecedores({super.key});

  @override
  State<TelaFornecedores> createState() => _TelaFornecedoresState();
}

class _TelaFornecedoresState extends State<TelaFornecedores> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> fornecedores = [];

  @override
  void initState() {
    super.initState();
    _carregarFornecedores();
  }

  Future<void> _carregarFornecedores() async {
    final response = await supabase.from('tb_fornecedor').select();
    setState(() {
      fornecedores = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> _adicionarFornecedor(String nome, String cnpj, String telefone, String email) async {
    await supabase.from('tb_fornecedor').insert({
      'nome': nome, 
      'cnpj': cnpj,
      'telefone': telefone,
      'email': email 
      });
    _carregarFornecedores();
  }

  Future<void> _editarFornecedor(int id, String nome, String cnpj, String telefone, String email) async {
    await supabase.from('tb_fornecedor').update({
      'nome': nome, 
      'cnpj': cnpj,
      'telefone': telefone,
      'email': email 
      }).match({'fornecedor_id': id});
    _carregarFornecedores();
  }

  Future<void> excluirFornecedor(int id) async {
    await supabase.from('tb_fornecedor').delete().eq('fornecedor_id', id);
    _carregarFornecedores();
  }

  void _mostrarDialogoFornecedor({int? id, String? nome, String? cnpj, String? telefone, String? email}) {
    final TextEditingController nomeController = TextEditingController(text: nome);
    final TextEditingController cnpjController = TextEditingController(text: cnpj);
    final TextEditingController telefoneController = TextEditingController(text: telefone);
    final TextEditingController emailController = TextEditingController(text: email);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id == null ? 'Adicionar fornecedor' : 'Editar fornecedor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: cnpjController,
                decoration: const InputDecoration(labelText: 'CNPJ'),
              ),
              TextField(
                controller: telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 8),
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
                  _adicionarFornecedor(nomeController.text, cnpjController.text, telefoneController.text, emailController.text); 
                } else {
                  _editarFornecedor(id, nomeController.text, cnpjController.text, telefoneController.text, emailController.text);
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
      appBar: AppBar(
        title: const Text('Fornecedores'),
        backgroundColor: const Color(0xFF0A6D92),
      ),
      body: fornecedores.isEmpty
          ? const Center(child: Text('Não há nenhuma fornecedor cadastrado.'))
          : ListView.builder(
              itemCount: fornecedores.length,
              itemBuilder: (context, index) {
                final fornecedor = fornecedores[index];
                return ListTile(
                  title: Text(fornecedor['nome']),
                   subtitle: Text(
                    'CNPJ: ${fornecedor['cnpj']}\n'
                    'Telefone: ${fornecedor['telefone']}\n'
                    'E-mail: ${fornecedor['email']}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _mostrarDialogoFornecedor(
                          id: fornecedor['fornecedor_id'],
                          nome: fornecedor['nome'],
                          cnpj: fornecedor['cnpj'],
                          telefone: fornecedor['telefone'],
                          email: fornecedor['email'],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          excluirFornecedor(fornecedor['fornecedor_id']); // O ID já está como int
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialogoFornecedor(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
