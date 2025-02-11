import 'package:estoque/Manager/Model/pessoa/fornecedor.dart';
import 'package:estoque/Manager/Service/service.dart';

class FornecedorService extends Service<Fornecedor> {
  List<Fornecedor> _fornecedores = [];

  @override
  Future<List<Fornecedor>> ObterTodos() async {
    return _fornecedores;
  }

  @override
  Future<Fornecedor> Atualizar(Fornecedor fornecedor) async {
    int index = _fornecedores.indexWhere((f) => f.ID == fornecedor.ID);
    if (index != -1) {
      _fornecedores[index] = fornecedor;
      return fornecedor;
    } else {
      throw Exception('Fornecedor não encontrado');
    }
  }

  @override
  Future<Fornecedor> Adicionar(Fornecedor fornecedor) async {
    _fornecedores.add(fornecedor);
    return fornecedor;
  }

  @override
  Future<Fornecedor> Delete(int id) async {
    int index = _fornecedores.indexWhere((f) => f.ID == id);
    if (index != -1) {
      Fornecedor removed = _fornecedores.removeAt(index);
      return removed;
    } else {
      throw Exception('Fornecedor não encontrado');
    }
  }
}
