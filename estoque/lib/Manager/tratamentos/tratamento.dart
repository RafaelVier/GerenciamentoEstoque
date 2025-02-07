class Tratamento {
  void executarTratamento(Function func) {
    try {
      func();
    } catch (e) {
      print('Ocorreu um erro: $e');
    }
  }

  String tratarString(String texto) {
    return texto.trim();
  }
}
