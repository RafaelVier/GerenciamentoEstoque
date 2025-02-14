import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:estoque/telas/telaInicial/tela_inicial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final SupabaseClient supabase = Supabase.instance.client;
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();

  bool queroEntrar = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _cadastrar() async {
    if (senhaController.text != confirmarSenhaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem!')),
      );
      return;
    }

    try {
    final AuthResponse response = await supabase.auth.signUp(
      email: emailController.text.trim(), // Remove espaços extras
      password: senhaController.text.trim(),
    );
      final user = response.user;

      if (user != null) {
        final responseInsert = await supabase.from('tb_funcionario').insert({
          'nome': nomeController.text,
          'email': emailController.text,
          'login': loginController.text,
          'senha': senhaController.text,
        }).select();

        print("🚀 Resposta da inserção no Supabase: $responseInsert");
        if (responseInsert == null || responseInsert.isEmpty) {
        throw Exception("Falha ao inserir dados na tabela tb_funcionario.");
      }
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TelaInicial()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.toString()}')),
      );
    }
  }

  Future<void> _entrar() async {
    try {
      final AuthResponse response = await supabase.auth.signInWithPassword(
      email: emailController.text.trim(),
      password: senhaController.text.trim(),
    );

    final user = response.user;
    if (user != null) {
      // Buscar ID do funcionário na tabela 'funcionario' pelo email
      final List<Map<String, dynamic>> funcionario = await supabase
          .from('tb_funcionario')
          .select('id_funcionario') // Pegamos apenas o ID
          .eq('email', user.email!)
          .limit(1);

      if (funcionario.isNotEmpty) {
        final int idFuncionario = funcionario.first['id_funcionario'];

        // Salvar o ID do funcionário no SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('id_funcionario', idFuncionario);
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TelaInicial()),
      );
      } else {
        throw Exception('Funcionário não encontrado na base de dados.');
      }
    }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(queroEntrar ? "Login" : "Cadastro"),
        backgroundColor: const Color(0xFF0A6D92),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!queroEntrar) ...[
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: loginController,
                decoration: const InputDecoration(
                  labelText: 'Login',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: senhaController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            if (!queroEntrar) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmarSenhaController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: queroEntrar ? _entrar : _cadastrar,
              child: Text(queroEntrar ? "Entrar" : "Cadastrar"),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  queroEntrar = !queroEntrar;
                });
              },
              child: Text(queroEntrar
                  ? "Ainda não tem uma conta? Cadastre-se!"
                  : "Já tem uma conta? Entre!"),
            ),
          ],
        ),
      ),
    );
  }
}
