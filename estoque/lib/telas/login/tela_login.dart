import 'package:estoque/telas/telaInicial/tela_inicial.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  bool queroEntrar = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: const Color(0xFF0A6D92),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
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
                  }
                )
              ),
            ),
            const SizedBox(height: 8),
            Visibility (
              visible: !queroEntrar,
              child: Column(
                children: [
                  TextFormField(
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirmar senha',
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
                      )
                    )
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    )
                  ),  
                ],
              )
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaInicial()),
                );
              }, 
              child: Text((queroEntrar) ? "Entrar" : "Cadastrar-se"),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: (){
                setState(() {
                  queroEntrar = !queroEntrar;
                });
              },
              child: Text((queroEntrar) ?"Ainda não tem uma conta? Cadastre-se!" : "Já tem uma conta? Entre!")
              )
          ],
        ),
      ),
    );
  }
}
