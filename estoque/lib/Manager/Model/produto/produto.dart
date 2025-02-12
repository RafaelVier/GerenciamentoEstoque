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

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
        map['_IDProduto'],
        map['CodigoBarras'],
        map['nome'],
        map['precoCusto'],
        map['precoVenda'],
        Categoria.fromMap(map['categoria']),
        Fornecedor.fromMap(map['FornecedorProduto']));
  }
  Map<String, dynamic> toMap() {
    return {
      '_IDProduto': _IDProduto,
      'CodigoBarras': CodigoBarras,
      'nome': nome,
      'precoCusto': precoCusto,
      'precoVenda': precoVenda,
      'categoria': categoria.toMap(),
      'FornecedorProduto': FornecedorProduto.toMap()
    };
  }
}
