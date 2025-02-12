class Categoria {
  int id;
  String nome;
  String descricao;
  Categoria(this.id, this.nome, this.descricao);
  factory Categoria.mapCategoria(Map<String, dynamic> map) {
    return Categoria(map['id'], map['nome'], map['descricao']);
  }
  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(json['id'], json['nome'], json['descricao']);
  }
}
