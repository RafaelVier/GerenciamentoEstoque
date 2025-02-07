abstract class Service <T> {
  Future<List<T>> ObterTodos();
  Future<T> atualizar(T index);
  Future<T> Adicionar(T t);
  Future<T> delete(int id);
}