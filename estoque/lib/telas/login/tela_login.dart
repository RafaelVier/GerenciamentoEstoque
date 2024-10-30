import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

  bool queroEntrar = true;

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
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Visibility (
              visible: !queroEntrar,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirmar senha',
                      border: OutlineInputBorder(),
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
              onPressed: () {}, 
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
