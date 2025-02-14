import 'package:estoque/Manager/Model/Transicao/movimentacaoEstoque.dart';
import 'package:estoque/Manager/Service/service.dart';
import 'package:estoque/main.dart';
import 'package:flutter/material.dart';
import 'notificaoService.dart';

class MovimentacaoEstoqueService extends Service<MovimentacaoEstoque> {
  final String tb_movimentacaoestoque = 'MovimentacaoEstoque';

  @override
  Future<List<MovimentacaoEstoque>> ObterTodos(BuildContext context, {int limite = 100, int offset = 0}) async {
    try{
      final List<dynamic> response = await supabase
        .from(tb_movimentacaoestoque)
        .select();
        return response.map((movimentacao) => MovimentacaoEstoque.fromMap(movimentacao)).toList();
    } catch(e){
      NotificationService.showSnackBar(context, 'Erro ao obter funcionários: $e');
      return [];
    }
  }

  @override
  Future<MovimentacaoEstoque> ObterPorId(BuildContext context, int id) async {
    try {
      final response = await supabase
        .from(tb_movimentacaoestoque)
        .select()
        .eq('ID', id)
        .single();
      return MovimentacaoEstoque.fromMap(response);
    } catch (e) {
      NotificationService.showSnackBar(context, 'Erro ao obter funcionário: $e');
      rethrow;
    }
  }

  @override
  Future<MovimentacaoEstoque> Atualizar(BuildContext context, MovimentacaoEstoque movimentacao) async {
    try{
      await supabase
        .from(tb_movimentacaoestoque)
        .update(movimentacao.toMap())
        .eq('ID', movimentacao.ID);
      return movimentacao;
    }catch(e){
      NotificationService.showSnackBar(context, 'Erro ao atualizar movimentação: $e');
      rethrow;
    }
  }

  @override
  Future<MovimentacaoEstoque> Adicionar(BuildContext context, MovimentacaoEstoque movimentacao) async {
    try{
      await supabase
        .from(tb_movimentacaoestoque)
        .insert(movimentacao.toMap());
      return movimentacao;
    }catch(e){
      NotificationService.showSnackBar(context, 'Erro ao adicionar movimentação: $e');
      rethrow;
    }
  }

  @override
  Future<MovimentacaoEstoque> Delete(BuildContext context, int id) async {
    try{
      final movimentacaoEstoque =await ObterPorId(context, id);
      await supabase
        .from(tb_movimentacaoestoque)
        .delete()
        .eq('ID', id);
      return movimentacaoEstoque;
    }catch(e){
      NotificationService.showSnackBar(context, 'Erro ao deletar movimentação: $e');
      rethrow;
    }
  }
}
