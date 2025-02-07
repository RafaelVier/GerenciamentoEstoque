import 'IRepositorio.dart';
import 'package:estoque/controller/produto/produto.dart';
import 'dart:convert';
import 'dart:io';

class RepositorioProduto extends IRepositorio<Produto> {
  List<Produto> _produtos = [];

  @override
  Future<List<Produto>> getAll() async {
    return _produtos;
  }

  @override
  Future<Produto?> getById(String id) async {
    try {
      return _produtos.firstWhere((produto) => produto.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> add(Produto item) async {
    _produtos.add(item);
  }

  @override
  Future<void> update(Produto item) async {
    int index = _produtos.indexWhere((produto) => produto.id == item.id);
    if (index != -1) {
      _produtos[index] = item;
    } else {
      throw Exception('Produto não encontrado');
    }
  }

  @override
  Future<void> delete(String id) async {
    int index = _produtos.indexWhere((produto) => produto.id == id);
    if (index != -1) {
      _produtos.removeAt(index);
    } else {
      throw Exception('Produto não encontrado');
    }
  }
}