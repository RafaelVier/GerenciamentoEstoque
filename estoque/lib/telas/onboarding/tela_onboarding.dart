import 'package:estoque/comum/minhas_cores.dart';
import 'package:estoque/telas/login/tela_login.dart';
import 'package:flutter/material.dart';
import 'steps.dart';

class TelaOnboarding extends StatefulWidget {
  const TelaOnboarding({super.key});

  @override
  State<TelaOnboarding> createState() => _TelaOnboarding();
}

class _TelaOnboarding extends State <TelaOnboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final List<OnBoardingStep> _steps = const [
    OnBoardingStep(
      imageAssetURL: 'assets/images/onboarding/logo2.png',
      text: 'Seja bem-vindo ao aplicativo de controle de estoque.',
    ),
    OnBoardingStep(
        imageAssetURL: 'assets/images/onboarding/logo2.png',
        text: 'Este aplicativo ajuda você a gerenciar o estoque de sua loja da melhor maneira possível.',
    ),
    OnBoardingStep(
        imageAssetURL: 'assets/images/onboarding/logo2.png',
        text: 'Aperte em "Acessar" para começar.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                  MinhasCores.azulTopoGradiente,
                  MinhasCores.azulBaixoGradiente
                  ],  
                ),
              ),
            ),
            PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              children: _steps,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_steps.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 20 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.white : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Visibility(
              visible: _currentPage != _steps.length - 1,
              child: Positioned(
                bottom: 8,
                right: 8,
                child: FloatingActionButton(
                  heroTag: 'next',
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
            Visibility(
              visible: _currentPage != 0,
              child: Positioned(
                bottom: 8,
                left: 8,
                child: FloatingActionButton(
                  heroTag: 'next',
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ),
            Visibility(
              visible: _currentPage == _steps.length - 1,
              child: Positioned(
                bottom: 8,
                right: 8,
                child: FloatingActionButton(
                  heroTag: 'next',
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaLogin()),
                    );
                  },
                child: const Text("Acessar."),
                ),
              ),
            ),
          ], 
        ),
    );
  }
}

/*
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


 appBar: AppBar(
        title: const Column(
          children: [
            Text (
              "Controle de Estoque", 
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
*/
