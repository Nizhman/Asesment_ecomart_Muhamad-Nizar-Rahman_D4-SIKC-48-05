
import 'package:flutter/foundation.dart';

class FavoritProvider extends ChangeNotifier {
  int jumlahFavorit = 0;

  void tambahFavorit() {
    jumlahFavorit++;
    notifyListeners();
  }
}
