import 'package:chefapp/core/listeners/favorite_listener.dart';

class FavoriteNotifier {
  // instância única
  static final FavoriteNotifier _instance = FavoriteNotifier._internal();

  // construtor privado
  FavoriteNotifier._internal();

  // acesso global
  factory FavoriteNotifier() => _instance;

  final List<FavoriteListener> _listeners = [];

  void addListener(FavoriteListener listener) {
    _listeners.add(listener);
  }

  void removeListener(FavoriteListener listener) {
    _listeners.remove(listener);
  }

  void notify() {
    for (final listener in _listeners) {
      listener.onFavoriteChanged();
    }
  }
}