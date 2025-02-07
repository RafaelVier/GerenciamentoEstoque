import 'package:estoque/controller/pessoa/Funcionario.dart';
import 'tipoQuantidade.dart';
import 'produto.dart';
import 'TipoMovimentacao.dart';
class MovimentacaoEstoque{
    int ID;
    Produto produto;
    Tipomovimentacao tipoMovimentacao;
    int Quantidade;
    Funcionario funcionario;
    TipoQuantidade tipoQuantidade;
    DateTime Data;
    String Observacao;
    MovimentacaoEstoque(this.ID, this.funcionario, this.produto, this.tipoMovimentacao, this.Quantidade, this.tipoQuantidade, this.Data, this.Observacao);
    factory MovimentacaoEstoque.mapMovimentacao(Map<String, dynamic> map) {
      return MovimentacaoEstoque(
        map['ID'],
        map['funcionario'],
        Produto.mapProduto(map['produto']),
        map['TipoMovimentacao'],
        map['Quantidade'],
        map['tipoQuantidade'],
        map['Data'],
        map['Observacao']
      );
    }
}