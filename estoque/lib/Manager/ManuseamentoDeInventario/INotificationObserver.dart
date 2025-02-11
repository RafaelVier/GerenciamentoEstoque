import 'package:estoque/Manager/Model/produto/produto.dart';

abstract class  INotificationObserver {
  void NotificarEstoqueBaixo(Produto produto);
}