import 'IRepositorio.dart';
import 'package:estoque/controller/pessoa/funcionario.dart';
import 'dart:convert';
import 'dart:io';

class Repositoriofuncionario implements IRepositorio<Funcionario>{
  List<Funcionario> _funcionarios = [];

  @override
  Future<List<Funcionario>> getAll() async {
    return _funcionarios;
  }

  @override
  Future<Funcionario?> getById(String id) async {
    try {
      return _funcionarios.firstWhere((funcionario) => funcionario.iDFuncionario == (id));
    } catch (e) {
      return null; 
    }
  }
  

  @override
  Future<void> add(Funcionario item) async {
    _funcionarios.add(item);
  }

  @override
  Future<void> update(Funcionario item) async {
    int index = _funcionarios.indexWhere((funcionario) => funcionario.iDFuncionario == item.id);
    if (index != -1) {
      _funcionarios[index] = item;
    } else {
      throw Exception('Funcionario não encontrado');
    }
  }

  @override
  Future<void> delete(String id) async {
    int index = _funcionarios.indexWhere((funcionario) => funcionario.iDFuncionario == id);
    if (index != -1) {
      _funcionarios.removeAt(index);
    } else {
      throw Exception('Funcionario não encontrado');
    }
  }
}