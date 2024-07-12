// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:crypto_tracker/models/crypto_currency.dart';
import 'package:crypto_tracker/services/api.dart';
import 'package:flutter/material.dart';

class MarketProvider with ChangeNotifier {
  MarketProvider() {
    fetchData();
  }
  bool isLoading = true;
  List<CryptoCurrency> markets = [];
  void fetchData() async {
    List<dynamic> _markets = await Api.getMarkets();
    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency cryptoCurrency = CryptoCurrency.fromJSON(market);
      temp.add(cryptoCurrency);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();
    Timer(const Duration(seconds: 1), () {
      fetchData();
    });
  }
}
