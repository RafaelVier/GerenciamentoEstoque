class Categoria {
  int id;
  String nome;
  String descricao;
  Categoria({
    required this.id,
    required this.nome,
    required this.descricao
  });
  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id']?? 0,
      nome: map['nome']??'',
      descricao: map['descricao'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
    };
  }
}
