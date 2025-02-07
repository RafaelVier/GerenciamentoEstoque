import 'package:estoque/controller/produto/produto.dart';
import 'INotificationObserver.dart';

class Observernotificationmanager extends INotificationObserver{
  List<INotificationObserver> _observers = [];

  void AddObserver(INotificationObserver observer){
    _observers.add(observer);
  }

  void RemoveObserver(INotificationObserver observer){
    _observers.remove(observer);
  }

  @override
  void NotificarEstoqueBaixo(Produto produto) {
    _observers.forEach((observer) {
      observer.NotificarEstoqueBaixo(produto);
    });
  }
}