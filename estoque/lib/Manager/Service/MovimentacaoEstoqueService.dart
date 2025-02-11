import 'package:estoque/Manager/Model/Transicao/movimentacaoEstoque.dart';
import 'package:estoque/Manager/Service/service.dart';

class MovimentacaoEstoqueService extends Service<MovimentacaoEstoque> {
  List<MovimentacaoEstoque> _movimentacoes = [];

  @override
  Future<List<MovimentacaoEstoque>> ObterTodos() async {
    return _movimentacoes;
  }

  @override
  Future<MovimentacaoEstoque> Atualizar(MovimentacaoEstoque movimentacao) async {
    int index = _movimentacoes.indexWhere((m) => m.ID == movimentacao.ID);
    if (index != -1) {
      _movimentacoes[index] = movimentacao;
      return movimentacao;
    } else {
      throw Exception('Movimentação não encontrada');
    }
  }

  @override
  Future<MovimentacaoEstoque> Adicionar(MovimentacaoEstoque movimentacao) async {
    _movimentacoes.add(movimentacao);
    return movimentacao;
  }

  @override
  Future<MovimentacaoEstoque> Delete(int id) async {
    int index = _movimentacoes.indexWhere((m) => m.ID == id);
    if (index != -1) {
      MovimentacaoEstoque removed = _movimentacoes.removeAt(index);
      return removed;
    } else {
      throw Exception('Movimentação não encontrada');
    }
  }
}
