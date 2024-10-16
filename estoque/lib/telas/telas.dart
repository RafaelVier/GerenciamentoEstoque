import 'package:flutter/material.dart';

class Telas extends StatelessWidget {
  const Telas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // scaffoldBackgroundColor: Colors.yellow,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Estoque',
      home: const TelaInicial(),
    );
  }
}


class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text (
              "Mercadinho do Zé", 
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
            ),
          ]
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A6D92),
        elevation: 0,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical (
            bottom: Radius.circular(24),
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Seja bem-vindo ao Mercadinho do Zé!",
                style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 22)
              ),
        
            ElevatedButton(
                onPressed: () {},
                child: const Text("Clique aqui para acessar o estoque")),
          ],
        ),
      ),
    );
  }
}