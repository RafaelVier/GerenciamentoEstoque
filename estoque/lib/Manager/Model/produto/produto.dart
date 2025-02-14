//import 'dart:ffi';
import 'package:estoque/Manager/Model/pessoa/fornecedor.dart';
import 'categoria.dart';

class Produto {
  String _IDProduto;
  String CodigoBarras;
  String nome;
  double precoCusto;
  double precoVenda;
  Categoria categoria;
  Fornecedor FornecedorProduto;

  Produto(
      this._IDProduto,
      this.CodigoBarras,
      this.nome,
      this.precoCusto,
      this.precoVenda,
      this.categoria,
      this.FornecedorProduto);
  get id => _IDProduto;

  factory Produto.mapProduto(Map<String, dynamic> map) {
    return Produto(
        map['_IDProduto'],
        map['CodigoBarras'],
        map['nome'],
        map['precoCusto'],
        map['precoVenda'],
        Categoria.mapCategoria(map['categoria']),
        Fornecedor.mapFornecedor(map['FornecedorProduto']));
  }
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
        json['_IDProduto'],
        json['CodigoBarras'],
        json['nome'],
        json['precoCusto'],
        json['precoVenda'],
        Categoria.fromJson(json['categoria']),
        Fornecedor.mapFornecedor(json['FornecedorProduto']));
  }
}
