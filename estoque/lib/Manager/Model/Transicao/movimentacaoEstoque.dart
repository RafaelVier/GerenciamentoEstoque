import 'dart:ffi';

import 'package:estoque/Manager/Model/pessoa/Funcionario.dart';
import 'package:estoque/Manager/Model/produto/produto.dart';
import 'package:estoque/Manager/Model/produto/tipoQuantidade.dart';
import 'TipoMovimentacao.dart';
class MovimentacaoEstoque{
    Int8 ID;
    Produto produto;
    Tipomovimentacao tipoMovimentacao;
    double Quantidade;
    Funcionario funcionario;
    TipoQuantidade tipoQuantidade;
    DateTime Data;
    String Observacao;
    MovimentacaoEstoque({
      required this.ID,
      required this.produto,
      required this.tipoMovimentacao,
      required this.Quantidade,
      required this.funcionario,
      required this.tipoQuantidade,
      required this.Data,
      required this.Observacao
    });

    factory MovimentacaoEstoque.fromMap(Map<String, dynamic> map) {
      return MovimentacaoEstoque(
        ID: map['ID']?? 0,
        produto: Produto.fromMap(map['produto']),
        tipoMovimentacao: Tipomovimentacao.values[(map['tipoMovimentacao'])],
        Quantidade: map['Quantidade']?? 0,
        funcionario: Funcionario.fromMap(map['funcionario']),
        tipoQuantidade: TipoQuantidade.values[(map['tipoQuantidade'])],
        Data: map['Data']?? DateTime.now(),
        Observacao: map['Observacao']?? '',
      );
    }
    Map<String, dynamic> toMap() {
      return {
        'ID': ID,
        'produto': produto.id,
        'tipoMovimentacao': tipoMovimentacao.name,
        'Quantidade': Quantidade,
        'funcionario': funcionario.iDFuncionario,
        'tipoQuantidade': tipoQuantidade.name,
        'Data': Data,
        'Observacao': Observacao,
      };
    }
    

}