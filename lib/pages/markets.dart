import 'package:crypto_tracker/models/crypto_currency.dart';
import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:crypto_tracker/widgets/crypto_listile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Markets extends StatefulWidget {
  const Markets({super.key});

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (provider.markets.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await provider.fetchData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: provider.markets.length,
                itemBuilder: (context, index) {
                  CryptoCurrency currency = provider.markets[index];
                  return CryptoListTile(currency: currency);
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
