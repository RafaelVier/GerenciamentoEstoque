abstract class Service <T> {
  Future<List<T>> ObterTodos();
  Future<T> ObterPorId(int id);
  Future<T> Atualizar(T index);
  Future<T> Adicionar(T index);
  Future<T> Delete(int id);
}