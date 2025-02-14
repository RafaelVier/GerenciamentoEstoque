import 'package:flutter/material.dart';

abstract class Service <T> {
  Future<List<T>> ObterTodos(BuildContext context, {int limite = 100, int offset = 0});
  Future<T> ObterPorId(BuildContext context,int id);
  Future<T> Atualizar(BuildContext context,T index);
  Future<T> Adicionar(BuildContext context,T index);
  Future<T> Delete(BuildContext context,int id);
}