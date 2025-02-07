import 'package:estoque/controller/produto/produto.dart';

abstract class  INotificationObserver {
  void NotificarEstoqueBaixo(Produto produto);
}