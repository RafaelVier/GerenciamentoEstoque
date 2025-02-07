import 'package:estoque/controller/produto/MovimentacaoEstoque.dart';
import 'IRepositorio.dart';
import 'dart:convert';
import 'dart:io';

class RepositorioDeposito implements IRepositorio<MovimentacaoEstoque> {
  List<MovimentacaoEstoque> _movimentacoes = [];
  @override
  Future<List<MovimentacaoEstoque>> getAll() async {
    return _movimentacoes;
  }
  @override
  Future<MovimentacaoEstoque?> getById(String id) async {
    try {
      return _movimentacoes.firstWhere((movimentacao) => movimentacao.ID == id);
    } catch (e) {
      return null;
    }
  }
  @override
  Future<void> add(MovimentacaoEstoque item) async {
    _movimentacoes.add(item);
  }
  @override
  Future<void> update(MovimentacaoEstoque item) async {
    int index = _movimentacoes.indexWhere((movimentacao) => movimentacao.ID == item.ID);
    if (index != -1) {
      _movimentacoes[index] = item;
    } else {
      throw Exception('Movimentação não encontrada');
    }
  }
  @override
  Future<void> delete(String id) async {
    int index = _movimentacoes.indexWhere((movimentacao) => movimentacao.ID == id);
    if (index != -1) {
      _movimentacoes.removeAt(index);
    } else {
      throw Exception('Movimentação não encontrada');
    }
  }
  
}