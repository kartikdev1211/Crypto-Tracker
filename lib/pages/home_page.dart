import 'package:crypto_tracker/models/crypto_currency.dart';
import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:crypto_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Crypto Today",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      themeProvider.toggletheme();
                    },
                    padding: const EdgeInsets.all(0),
                    icon: (themeProvider.themeMode == ThemeMode.light)
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Expanded(
                child: Consumer<MarketProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (provider.markets.isNotEmpty) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: provider.markets.length,
                          itemBuilder: (context, index) {
                            CryptoCurrency currency = provider.markets[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(currency.image!),
                              ),
                              title: Text(
                                  "${currency.name!} #${currency.marketCapRank}"),
                              subtitle: Text(currency.symbol!.toUpperCase()),
                              trailing: currency.currentPrice != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "₹${currency.currentPrice!.toStringAsFixed(4)}",
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            double priceChange =
                                                currency.priceChange24!;
                                            double priceChangePrecentage =
                                                currency
                                                    .priceChangePercentage24!;
                                            if (priceChange < 0) {
                                              return Text(
                                                "${priceChangePrecentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              );
                                            } else {
                                              return Text(
                                                "+${priceChangePrecentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                                style: const TextStyle(
                                                    color: Colors.green),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    )
                                  : null,
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
