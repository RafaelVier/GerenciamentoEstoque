import 'package:estoque/controller/pessoa/fornecedor.dart';
import 'IRepositorio.dart';
import 'dart:convert';
import 'dart:io';

class RepositorioFornecedor implements IRepositorio<Fornecedor> {
  List<Fornecedor> _fornecedores = [];

  @override
  Future<List<Fornecedor>> getAll() async {
    return _fornecedores;
  } 

  @override
  Future<Fornecedor?> getById(String cnpj) async {
    try {
      return _fornecedores.firstWhere((fornecedor) => fornecedor.CNPJ == cnpj);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> add(Fornecedor item) async {
    _fornecedores.add(item);
  }

  @override
  Future<void> update(Fornecedor item) async {
    int index = _fornecedores.indexWhere((fornecedor) => fornecedor.CNPJ == item.CNPJ);
    index != -1 ? _fornecedores[index] = item : throw Exception('Fornecedor não encontrado');
  }

  @override
  Future<void> delete(String cnpj) async {
    int index = _fornecedores.indexWhere((fornecedor) => fornecedor.CNPJ == cnpj);
    if (index != -1) {
      _fornecedores.removeAt(index);
    } else {
      throw Exception('Fornecedor não encontrado');
    }
  }
}
