//import 'dart:ffi';
import 'package:estoque/controller/pessoa/fornecedor.dart';
import 'tipoQuantidade.dart';
import 'package:estoque/Manager/Model/pessoa/fornecedor.dart';
import 'categoria.dart';

class Produto {
  int IDProduto;
  String CodigoBarras;
  String nome;
  double preco;
  double quantidade;
  Categoria categoria;
  TipoQuantidade tipoQuantidade;
  Fornecedor FornecedorProduto;

  Produto(
      this.IDProduto,
      this.CodigoBarras,
      this.nome,
      this.preco,
      this.quantidade,
      this.categoria,
      this.tipoQuantidade,
      this.FornecedorProduto);

  factory Produto.mapProduto(Map<String, dynamic> map) {
    return Produto(
        map['IDProduto'],
        map['CodigoBarras'],
        map['nome'],
        map['preco'],
        map['quantidade'],
        Categoria.mapCategoria(map['categoria']),
        TipoQuantidade.mapTipoQuantidade(map['tipoQuantidade']),
        Fornecedor.mapFornecedor(map['FornecedorProduto']));
  }
}
