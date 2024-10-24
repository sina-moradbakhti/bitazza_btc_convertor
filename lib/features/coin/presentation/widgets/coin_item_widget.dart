import 'package:bitazza/core/utils/formatters.dart';
import 'package:bitazza/features/coin/domain/entities/coin_price_entity.dart';
import 'package:flutter/material.dart';

class CoinItemWidget extends StatelessWidget {
  final String baseCoin;
  final CoinDetails coin;

  const CoinItemWidget({
    super.key,
    required this.baseCoin,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(
        vertical: 14.5,
        horizontal: 16,
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/details',
          arguments: coin,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.5,
              ),
              children: [
                TextSpan(
                  text: baseCoin.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19.5,
                  ),
                ),
                const TextSpan(
                  text: ' / ',
                ),
                TextSpan(
                  text: coin.symbol.toCurrencyName(),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    coin.rateStr,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 15.5,
                    ),
                  ),
                  const SizedBox(height: 2.5),
                  Text(
                    '${coin.symbol.toSymbol()}${coin.rateStr}',
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right_rounded, size: 22.5),
            ],
          )
        ],
      ),
    );
  }
}
