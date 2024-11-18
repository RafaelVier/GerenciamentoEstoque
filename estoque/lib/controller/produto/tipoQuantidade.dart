class TipoQuantidade {
  int id;
  String nome;
  String descricao;
  TipoQuantidade(this.id, this.nome, this.descricao);
  factory TipoQuantidade.mapTipoQuantidade(Map<String, dynamic> map) {
    return TipoQuantidade(map['id'], map['nome'], map['descricao']);
  }
}
