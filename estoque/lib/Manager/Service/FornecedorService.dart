import 'package:estoque/Manager/Model/pessoa/fornecedor.dart';
import 'package:estoque/Manager/Service/NotificaoService';
//import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:estoque/Manager/Service/service.dart';
import 'package:estoque/main.dart';
import 'package:flutter/material.dart';

class FornecedorService extends Service<Fornecedor> {
  final String tb_fornecedor='Fornecedor';

  @override
Future<List<Fornecedor>> ObterTodos(BuildContext context, {int limite = 100, int offset = 0}) async {
  try{
    final List<dynamic> response = await supabase
      .from(tb_fornecedor)
      .select();
      return response.map((fornecedor) => Fornecedor.fromMap(fornecedor)).toList();
  }catch(e){
    NotificationService.showSnackBar(context, 'Erro ao obter fornecedores: $e');
    return [];
  }
}  
@override
Future<Fornecedor> ObterPorId(BuildContext context, int id) async {
  try {
    final response = await supabase
      .from(tb_fornecedor)
      .select()
      .eq('ID', id)
      .single();
    return Fornecedor.fromMap(response);
  } catch (e) {
    NotificationService.showSnackBar(context, 'Erro ao obter fornecedor: $e');
    rethrow;
  }
}


 @override
Future<Fornecedor> Atualizar(BuildContext context, Fornecedor fornecedor) async {
  try {
    await supabase
      .from(tb_fornecedor)
      .update(fornecedor.toMap())
      .eq('ID', fornecedor.ID);
    return fornecedor;
  } catch (e) {
    NotificationService.showSnackBar(context, 'Erro ao atualizar fornecedor: $e');
    rethrow;
  }
}

  @override
  Future<Fornecedor> Adicionar(BuildContext context, Fornecedor fornecedor) async {
      try {
      await supabase
          .from(tb_fornecedor)
          .insert(fornecedor.toMap());
      return fornecedor;
    } catch (e) {
      NotificationService.showSnackBar(context, 'Erro ao adicionar fornecedor: $e');
      rethrow;
    }
  }
  
  @override
  Future<Fornecedor> Delete(BuildContext context, int id) async {
    try{
      final fornecedor = await ObterPorId(context,id);
      await supabase
        .from(tb_fornecedor)
        .delete()
        .eq('ID', id);
      return fornecedor;
    }catch(e){
      NotificationService.showSnackBar(context, 'Erro ao deletar fornecedor: $e');
      rethrow;
    }
  }

  
}
