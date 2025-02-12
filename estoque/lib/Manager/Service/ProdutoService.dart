import 'package:estoque/Manager/Model/produto/produto.dart';
import 'package:estoque/main.dart';
import 'service.dart';

class ProdutoService extends Service<Produto> {
  final String tb_produto = 'Produto';


  @override
  Future<List<Produto>> ObterTodos() async {
    try{
      final List<dynamic> response = await supabase
        .from(tb_produto)
        .select();
        return response.map((produto) => Produto.fromMap(produto)).toList();
    } catch(e){
      throw Exception('Erro ao obter produtos: $e');
    }
  }
  
  @override
  Future<Produto> ObterPorId(int id) async {
    try {
      final response = await supabase
        .from(tb_produto)
        .select()
        .eq('ID', id)
        .single();
      return Produto.fromMap(response);
    } catch (e) {
      throw Exception('Erro ao obter produto: $e');
    }
  }

  @override
  Future<Produto> Atualizar(Produto produto) async {
    try{
      await supabase
        .from(tb_produto)
        .update(produto.toMap())
        .eq('ID', produto.id);
      return produto;
    }catch(e){
      throw Exception('Erro ao atualizar produto: $e');
    }
  }

  @override
  Future<Produto> Adicionar(Produto produto) async {
    try{
      await supabase
        .from(tb_produto)
        .insert(produto.toMap());
      return produto;
    }catch(e){
      throw Exception('Erro ao adicionar produto: $e');
    }
  }

  @override
  Future<Produto> Delete(int id) async {
    try{
      final produto = await ObterPorId(id);
      await supabase
        .from(tb_produto)
        .delete()
        .eq('ID', id);
      return produto;
    }catch(e){
      throw Exception('Erro ao deletar produto: $e');
    }
  }
}
