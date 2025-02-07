import 'package:estoque/controller/pessoa/fornecedor.dart';
import 'tipoQuantidade.dart';
import 'produto.dart';
import 'package:flutter/material.dart';
import 'TipoMovimentacao.dart';
class MovimentacaoEstoque{
    int ID;
    Produto produto;
    Tipomovimentacao TipoMovimentacao;
    int Quantidade;
    TipoQuantidade tipoQuantidade;
    DateTime Data;
    String Observacao;
    MovimentacaoEstoque(this.ID, this.produto, this.TipoMovimentacao, this.Quantidade, this.tipoQuantidade, this.Data, this.Observacao);
    factory MovimentacaoEstoque.mapMovimentacao(Map<String, dynamic> map) {
      return MovimentacaoEstoque(
        map['ID'],
        Produto.mapProduto(map['produto']),
        map['TipoMovimentacao'],
        map['Quantidade'],
        map['tipoQuantidade'],
        map['Data'],
        map['Observacao']
      );
    }
    void ProdutoService () {
      
    }
}