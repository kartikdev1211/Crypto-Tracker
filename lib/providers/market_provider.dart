// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:crypto_tracker/models/crypto_currency.dart';
import 'package:crypto_tracker/services/api.dart';
import 'package:crypto_tracker/services/local_storage.dart';
import 'package:flutter/material.dart';

class MarketProvider with ChangeNotifier {
  MarketProvider() {
    fetchData();
  }
  bool isLoading = true;
  List<CryptoCurrency> markets = [];
  Future<void> fetchData() async {
    List<dynamic> _markets = await Api.getMarkets();
    List<String> favourites = await LocalStorage.fetchFavourite();
    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency cryptoCurrency = CryptoCurrency.fromJSON(market);
      if (favourites.contains(cryptoCurrency.id!)) {
        cryptoCurrency.isFavorite = true;
      }
      temp.add(cryptoCurrency);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavourite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = true;
    await LocalStorage.addFavourite(crypto.id!);
    notifyListeners();
  }

  void removeFavourite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = false;
    await LocalStorage.removeFavourite(crypto.id!);
    notifyListeners();
  }
}
