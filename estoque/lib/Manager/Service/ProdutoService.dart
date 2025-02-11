import 'package:estoque/Manager/Model/produto/produto.dart';
import 'service.dart';

class ProdutoService extends Service<Produto> {
  List<Produto> _produtos = [];

  @override
  Future<List<Produto>> ObterTodos() async {
    return _produtos;
  }

  @override
  Future<Produto> Atualizar(Produto produto) async {
    int index = _produtos.indexWhere((p) => p.id == produto.id);
    if (index != -1) {
      _produtos[index] = produto;
      return produto;
    } else {
      throw Exception('Produto não encontrado');
    }
  }

  @override
  Future<Produto> Adicionar(Produto produto) async {
    _produtos.add(produto);
    return produto;
  }

  @override
  Future<Produto> Delete(int id) async {
    int index = _produtos.indexWhere((p) => p.id == id);
    if (index != -1) {
      Produto removed = _produtos.removeAt(index);
      return removed;
    } else {
      throw Exception('Produto não encontrado');
    }
  }
}
