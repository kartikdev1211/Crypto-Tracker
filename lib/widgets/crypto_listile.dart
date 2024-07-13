import 'package:crypto_tracker/models/crypto_currency.dart';
import 'package:crypto_tracker/pages/details_page.dart';
import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  final CryptoCurrency currency;
  const CryptoListTile({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    MarketProvider provider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              id: currency.id!,
            ),
          ),
        );
      },
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currency.image!),
      ),
      title: Row(
        children: [
          Flexible(
              child: Text(
            currency.name!,
            overflow: TextOverflow.ellipsis,
          )),
          SizedBox(
            width: MediaQuery.of(context).size.width / 20,
          ),
          currency.isFavorite == false
              ? GestureDetector(
                  onTap: () {
                    provider.addFavourite(currency);
                  },
                  child: const Icon(
                    CupertinoIcons.heart,
                    size: 18,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    provider.removeFavourite(currency);
                  },
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    size: 18,
                    color: Colors.red,
                  ),
                ),
        ],
      ),
      subtitle: Text(currency.symbol!.toUpperCase()),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹${currency.currentPrice!.toStringAsFixed(4)}",
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Builder(
            builder: (context) {
              double priceChange = currency.priceChange24!;
              double priceChangePrecentage = currency.priceChangePercentage24!;
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
    );
  }
}
