import 'package:estoque/Manager/Model/pessoa/Funcionario.dart';
import 'package:estoque/Manager/Service/service.dart';
import 'package:estoque/main.dart';
import 'package:flutter/material.dart';
import 'NotificaoService.dart';

class ServiceFuncionario extends Service<Funcionario>{
  final tb_funcionario = 'Funcionario';

  @override
  Future<List<Funcionario>> ObterTodos(BuildContext context, {int limite = 100, int offset = 0}) async {
    try{
      final List<dynamic> response = await supabase
        .from(tb_funcionario)
        .select();
        return response.map((funcionario) => Funcionario.fromMap(funcionario)).toList();
    } catch(e){
      NotificationService.showSnackBar(context,'Erro ao obter funcionarios: $e');
      return[];
    }
  }

  @override
  Future<Funcionario> ObterPorId(BuildContext context,int id) async {
    try {
      final response = await supabase
        .from(tb_funcionario)
        .select()
        .eq('ID', id)
        .single();
      return Funcionario.fromMap(response);
    } catch (e) {
      NotificationService.showSnackBar(context,'Erro ao obter funcionario: $e');
      rethrow;
    }
  }

  @override
  Future<Funcionario> Atualizar(BuildContext context,Funcionario funcionario) async {
    try{
     await supabase
        .from(tb_funcionario)
        .update(funcionario.toMap())
        .eq('ID', funcionario.iDFuncionario);
      NotificationService.showSnackBar(context, 'Funcionário atualizado com sucesso!');
      return funcionario;
    } catch (e) {
      NotificationService.showSnackBar(context, 'Erro ao atualizar funcionário: $e');
      rethrow;
    }
  }

  @override
  Future<Funcionario> Adicionar(BuildContext context,Funcionario funcionario) async {
    try{
      final response = await supabase
        .from(tb_funcionario)
        .insert(funcionario.toMap())
        .select()
        .single();
      return Funcionario.fromMap(response);
    } catch (e) {
      NotificationService.showSnackBar(context, 'Erro ao adicionar funcionário: $e');
      rethrow;
    }
  }

  @override
  Future<Funcionario> Delete(BuildContext context, int id) async {
    try{
      final funcionario =await ObterPorId(context,id);
      await supabase
        .from(tb_funcionario)
        .delete()
        .eq('ID', id);
      return funcionario;
    }catch(e){
      NotificationService.showSnackBar(context, 'Erro ao deletar funcionário: $e');
      rethrow;
    }
  }

}