import 'package:crypto_tracker/models/crypto_currency.dart';
import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(
          detail,
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Consumer<MarketProvider>(
            builder: (context, provider, child) {
              CryptoCurrency currency = provider.fetchCryptoById(widget.id);
              return RefreshIndicator(
                onRefresh: () async {
                  await provider.fetchData();
                },
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(currency.image!),
                      ),
                      title: Text(
                        "${currency.name!}(${currency.symbol!.toUpperCase()})",
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        "₹ ${currency.currentPrice!.toStringAsFixed(4)}",
                        style: const TextStyle(
                          color: Color(0xff0395eb),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Price Change (24H)",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Builder(
                          builder: (context) {
                            double priceChange = currency.priceChange24!;
                            double priceChangePrecentage =
                                currency.priceChangePercentage24!;
                            if (priceChange < 0) {
                              return Text(
                                "${priceChangePrecentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                style: const TextStyle(color: Colors.red),
                              );
                            } else {
                              return Text(
                                "+${priceChangePrecentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                style: const TextStyle(color: Colors.green),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Market Cap",
                            "₹ ${currency.marketCap!.toStringAsFixed(4)}",
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "Market Cap Rank",
                            "# ${currency.marketCapRank}",
                            CrossAxisAlignment.end),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Low 24H",
                            "₹ ${currency.low24!.toStringAsFixed(4)}",
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "High 24H",
                            "₹ ${currency.high24!.toStringAsFixed(4)}",
                            CrossAxisAlignment.end),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Circulating Supply",
                            currency.circulatingSupply!.toInt().toString(),
                            CrossAxisAlignment.start),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail("All Time Low", currency.atl.toString(),
                            CrossAxisAlignment.start),
                        titleAndDetail("All Time High", currency.ath.toString(),
                            CrossAxisAlignment.end),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
