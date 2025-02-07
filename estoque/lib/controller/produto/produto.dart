//import 'dart:ffi';
import 'package:estoque/controller/pessoa/fornecedor.dart';
import 'categoria.dart';

class Produto {
  String IDProduto;
  String CodigoBarras;
  String nome;
  double precoCusto;
  double precoVenda;
  Categoria categoria;
  Fornecedor FornecedorProduto;

  Produto(
      this.IDProduto,
      this.CodigoBarras,
      this.nome,
      this.precoCusto,
      this.precoVenda,
      this.categoria,
      this.FornecedorProduto);

  factory Produto.mapProduto(Map<String, dynamic> map) {
    return Produto(
        map['IDProduto'],
        map['CodigoBarras'],
        map['nome'],
        map['precoCusto'],
        map['precoVenda'],
        Categoria.mapCategoria(map['categoria']),
        Fornecedor.mapFornecedor(map['FornecedorProduto']));
  }
}
