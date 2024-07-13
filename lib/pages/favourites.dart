import 'package:crypto_tracker/models/crypto_currency.dart';
import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:crypto_tracker/widgets/crypto_listile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: (context, provider, child) {
      List<CryptoCurrency> fav = provider.markets
          .where((element) => element.isFavorite == true)
          .toList();
      if (fav.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.fetchData();
          },
          child: ListView.builder(
            itemCount: fav.length,
            itemBuilder: (context, index) {
              CryptoCurrency currency = fav[index];
              return CryptoListTile(currency: currency);
            },
          ),
        );
      } else {
        return const Center(
          child: Text(
            "No favourites yet",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        );
      }
    });
  }
}
