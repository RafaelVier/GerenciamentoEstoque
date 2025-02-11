abstract class Service <T>{
  Future<List<T>> ObterTodos();
  Future<T> Atualizar(T obj);
  Future<T> Adicionar(T obj);
  Future<T> Delete(int id);
}