import 'package:estoque/Manager/Model/Transicao/movimentacaoEstoque.dart';
import 'package:estoque/Manager/Service/service.dart';
import 'package:estoque/main.dart';

class MovimentacaoEstoqueService extends Service<MovimentacaoEstoque> {
  final String tb_movimentacaoestoque = 'MovimentacaoEstoque';

  @override
  Future<List<MovimentacaoEstoque>> ObterTodos() async {
    try{
      final List<dynamic> response = await supabase
        .from(tb_movimentacaoestoque)
        .select();
        return response.map((movimentacao) => MovimentacaoEstoque.fromMap(movimentacao)).toList();
    } catch(e){
      throw Exception('Erro ao obter movimentações: $e');
    }
  }
  Future<MovimentacaoEstoque> ObterPorId(int id) async {
    try {
      final response = await supabase
        .from(tb_movimentacaoestoque)
        .select()
        .eq('ID', id)
        .single();
      return MovimentacaoEstoque.fromMap(response);
    } catch (e) {
      throw Exception('Erro ao obter movimentação: $e');
    }
  }
  @override
  Future<MovimentacaoEstoque> Atualizar(MovimentacaoEstoque movimentacao) async {
    try{
      await supabase
        .from(tb_movimentacaoestoque)
        .update(movimentacao.toMap())
        .eq('ID', movimentacao.ID);
      return movimentacao;
    }catch(e){
      throw Exception('Erro ao atualizar movimentação: $e');
    }
  }

  @override
  Future<MovimentacaoEstoque> Adicionar(MovimentacaoEstoque movimentacao) async {
    try{
      await supabase
        .from(tb_movimentacaoestoque)
        .insert(movimentacao.toMap());
      return movimentacao;
    }catch(e){
      throw Exception('Erro ao adicionar movimentação: $e');
    }
  }

  @override
  Future<MovimentacaoEstoque> Delete(int id) async {
    try{
      final movimentacaoEstoque =await ObterPorId(id);
      await supabase
        .from(tb_movimentacaoestoque)
        .delete()
        .eq('ID', id);
      return movimentacaoEstoque;
    }catch(e){
      throw Exception('Erro ao deletar movimentação: $e');
    }
  }
}
