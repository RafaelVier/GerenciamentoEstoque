import 'package:estoque/Manager/Model/pessoa/fornecedor.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:estoque/Manager/Service/service.dart';
import 'package:estoque/main.dart';

class FornecedorService extends Service<Fornecedor> {
  final String tb_fornecedor='Fornecedor';

  @override
Future<List<Fornecedor>> ObterTodos() async {
  try{
    final List<dynamic> response = await supabase
      .from(tb_fornecedor)
      .select();
      return response.map((fornecedor) => Fornecedor.fromMap(fornecedor)).toList();
  }catch(e){
    throw Exception('Erro ao obter fornecedores: $e');
  }
}  
@override
Future<Fornecedor> ObterPorId(int id) async {
  try {
    final response = await supabase
      .from(tb_fornecedor)
      .select()
      .eq('ID', id)
      .single();
    return Fornecedor.fromMap(response);
  } catch (e) {
    throw Exception('Erro ao obter fornecedor: $e');
  }
}


 @override
Future<Fornecedor> Atualizar(Fornecedor fornecedor) async {
  try {
    await supabase
      .from(tb_fornecedor)
      .update(fornecedor.toMap())
      .eq('ID', fornecedor.ID);
    return fornecedor;
  } catch (e) {
    throw Exception('Erro ao atualizar fornecedor: $e');
  }
}

  @override
  Future<Fornecedor> Adicionar(Fornecedor fornecedor) async {
      try {
      await supabase
          .from(tb_fornecedor)
          .insert(fornecedor.toMap());
      return fornecedor;
    } catch (e) {
      throw Exception('Erro ao adicionar fornecedor: $e');
    }
  }
  
  @override
  Future<Fornecedor> Delete(int id) async {
    try{
      final fornecedor = await ObterPorId(id);
      await supabase
        .from(tb_fornecedor)
        .delete()
        .eq('ID', id);
      return fornecedor;
    }catch(e){
      throw Exception('Erro ao deletar fornecedor: $e');
    }
  }

  
}
