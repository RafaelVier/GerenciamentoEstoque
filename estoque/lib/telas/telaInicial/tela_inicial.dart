import 'package:estoque/telas/telaInicial/tela_categoria.dart';
import 'package:flutter/material.dart';
import 'package:estoque/telas/login/tela_login.dart';
import 'package:estoque/telas/telaInicial/tela_relatorios.dart';
import 'package:estoque/telas/telaInicial/tela_fornecedores.dart';
import 'package:estoque/telas/telaInicial/tela_produtos.dart';
import 'package:estoque/telas/telaInicial/tela_movimentacao.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Painel de Controle"),
        backgroundColor: const Color(0xFF0A6D92),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _mostrarMenu(context);
          },
        ),
      ),
      body: const Center(
        child: Text(
          "Bem-vindo ao Gerenciamento de Estoque",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _mostrarMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Fundo escuro ao clicar no menu
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            // Menu lateral posicionado à esquerda
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                color: Colors.transparent,
                child: Container(
                width: MediaQuery.of(context).size.width * 0.5, // 50% da largura da tela
                height: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      color: const Color(0xFF0A6D92),
                      child: const Text(
                        "Menu",
                        style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    _menuItem(Icons.inventory, "Gerenciar Estoque", context, const TelaProdutos()),
                    _menuItem(Icons.currency_exchange, "Movimentação", context, const TelaMovimentacao()),
                    _menuItem(Icons.supervisor_account, "Fornecedores", context, const TelaFornecedores()),
                    _menuItem(Icons.bar_chart, "Relatórios", context, const TelaRelatorios()),
                    _menuItem(Icons.exit_to_app, "Categorias", context, const TelaCategorias()),
                    _menuItem(Icons.exit_to_app, "Sair", context, null, isExit: true),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

  Widget _menuItem(IconData icon, String title, BuildContext context, Widget? page, {bool isExit = false}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        //Navigator.pop(context); // Fecha o menu
        if (isExit) {
          _confirmarSaida(context); // Chama o pop-up de confirmação ao sair
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
        }
      },
    );
  }
  // Função para exibir um pop-up de confirmação ao sair
  void _confirmarSaida(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar saída"),
          content: const Text("Tem certeza que deseja sair?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Fecha o pop-up sem sair
              child: const Text("Não"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o pop-up
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaLogin())); // Vai para a tela de login
              },
              child: const Text("Sim"),
            ),
          ],
        );
      },
    );
  }
}





