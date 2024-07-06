// lib/provider/cart_provider.dart

import 'package:flutter/foundation.dart';
import '../models/buku.dart';

class CartProvider with ChangeNotifier {
  List<Buku> _items = [];

  List<Buku> get items => _items;

  void addToCart(Buku item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(Buku item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
