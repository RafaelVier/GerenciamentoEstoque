import 'package:estoque/Manager/Model/produto/produto.dart';
import 'package:estoque/Manager/Service/NotificaoService';
import 'package:estoque/main.dart';
import 'package:flutter/material.dart';
import 'service.dart';

class ProdutoService extends Service<Produto> {
  final String tb_produto = 'Produto';


  @override
  Future<List<Produto>> ObterTodos(BuildContext context, {int limite = 100, int offset = 0}) async {
    try{
      final List<dynamic> response = await supabase
        .from(tb_produto)
        .select();
        return response.map((produto) => Produto.fromMap(produto)).toList();
    } catch(e){
      NotificationService.showSnackBar(context, 'Erro ao obter produtos: $e');
      return [];
    }
  }
  
  @override
  Future<Produto> ObterPorId(BuildContext context,int id) async {
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
  Future<Produto> Atualizar(BuildContext context, Produto produto) async {
    try{
      await supabase
        .from(tb_produto)
        .update(produto.toMap())
        .eq('ID', produto.id);
      return produto;
    }catch(e){
      NotificationService.showSnackBar(context, 'Erro ao atualizar produto: $e');
      rethrow;
    }
  }

  @override
  Future<Produto> Adicionar(BuildContext context, Produto produto) async {
    try{
      await supabase
        .from(tb_produto)
        .insert(produto.toMap());
      return produto;
    }catch(e){
      NotificationService.showSnackBar(context, 'Erro ao adicionar produto: $e');
      rethrow;
    }
  }

  @override
  Future<Produto> Delete(BuildContext context, int id) async {
    try{
      final produto = await ObterPorId(context, id);
      await supabase
        .from(tb_produto)
        .delete()
        .eq('ID', id);
      return produto;
    }catch(e){
      NotificationService.showSnackBar(context, 'Erro ao deletar produto: $e');
      rethrow;
    }
  }
}
